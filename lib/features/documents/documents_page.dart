import 'package:arctive/core/models/app_user.dart';
import 'package:arctive/core/models/document.dart';
import 'package:arctive/core/router/app_router.dart';
import 'package:arctive/core/services/auth_repository.dart';
import 'package:arctive/core/services/document_repository.dart';
import 'package:arctive/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class DocumentsPage extends ConsumerStatefulWidget {
  const DocumentsPage({super.key});

  @override
  ConsumerState<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends ConsumerState<DocumentsPage> {
  final TextEditingController _searchController = TextEditingController();

  DocumentSector? _sectorFilter;
  String? _selectedDocumentId;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final documents = ref.watch(documentRepositoryProvider).getAll();
    final currentUser = ref.watch(currentAppUserProvider);
    final isScanner = currentUser?.role == UserRole.scanner;
    final canOpenScan = currentUser?.role.canOpenScan ?? false;
    final isWideLayout = MediaQuery.sizeOf(context).width >= 1100;

    final filteredDocuments = isScanner
        ? const <Document>[]
        : _filterDocuments(documents, currentUser);

    final selectedDocument = _selectedDocumentId == null
        ? null
        : _documentById(filteredDocuments, _selectedDocumentId);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: isScanner
              ? _ScannerView(onScanPressed: () => context.go(AppRoutes.scan))
              : isWideLayout
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: _DocumentsBrowser(
                        searchController: _searchController,
                        documents: filteredDocuments,
                        sectorFilter: _sectorFilter,
                        canOpenScan: canOpenScan,
                        onQueryChanged: () => setState(() {}),
                        onSectorChanged: (sector) => setState(() {
                          _sectorFilter = sector;
                        }),
                        onScanPressed: canOpenScan
                            ? () => context.go(AppRoutes.scan)
                            : null,
                        onDocumentPressed: (document) => setState(() {
                          _selectedDocumentId = document.id;
                        }),
                        selectedDocumentId: selectedDocument?.id,
                      ),
                    ),
                    const SizedBox(width: 24),
                    SizedBox(
                      width: 440,
                      child: _InspectorPanelShell(
                        document: selectedDocument,
                        onClose: null,
                      ),
                    ),
                  ],
                )
              : _DocumentsBrowser(
                  searchController: _searchController,
                  documents: filteredDocuments,
                  sectorFilter: _sectorFilter,
                  canOpenScan: canOpenScan,
                  onQueryChanged: () => setState(() {}),
                  onSectorChanged: (sector) => setState(() {
                    _sectorFilter = sector;
                  }),
                  onScanPressed: canOpenScan
                      ? () => context.go(AppRoutes.scan)
                      : null,
                  onDocumentPressed: (document) async {
                    setState(() {
                      _selectedDocumentId = document.id;
                    });
                    await showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      backgroundColor: AppTheme.surface,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                      ),
                      builder: (sheetContext) {
                        return FractionallySizedBox(
                          heightFactor: 0.92,
                          child: _InspectorPanelShell(
                            document: document,
                            onClose: () => Navigator.of(sheetContext).pop(),
                          ),
                        );
                      },
                    );
                  },
                  selectedDocumentId: null,
                ),
        ),
      ),
    );
  }

  List<Document> _filterDocuments(
    List<Document> documents,
    AppUser? currentUser,
  ) {
    final query = _searchController.text.trim().toLowerCase();
    final allowedSectors = currentUser?.allowedSectors.isNotEmpty == true
        ? currentUser!.allowedSectors
        : DocumentSector.values;

    return documents
        .where((document) {
          if (!allowedSectors.contains(document.sector)) {
            return false;
          }

          if (_sectorFilter != null && document.sector != _sectorFilter) {
            return false;
          }

          if (query.isNotEmpty) {
            final searchableText = <String>[
              document.title,
              document.ocrText,
              ...document.tags,
            ].join(' ').toLowerCase();

            if (!searchableText.contains(query)) {
              return false;
            }
          }

          return true;
        })
        .toList(growable: false);
  }

  Document? _documentById(List<Document> documents, String? id) {
    if (id == null) {
      return null;
    }

    for (final document in documents) {
      if (document.id == id) {
        return document;
      }
    }

    return null;
  }
}

class _DocumentsBrowser extends StatelessWidget {
  const _DocumentsBrowser({
    required this.searchController,
    required this.documents,
    required this.sectorFilter,
    required this.canOpenScan,
    required this.onQueryChanged,
    required this.onSectorChanged,
    required this.onScanPressed,
    required this.onDocumentPressed,
    required this.selectedDocumentId,
  });

  final TextEditingController searchController;
  final List<Document> documents;
  final DocumentSector? sectorFilter;
  final bool canOpenScan;
  final VoidCallback onQueryChanged;
  final ValueChanged<DocumentSector?> onSectorChanged;
  final VoidCallback? onScanPressed;
  final ValueChanged<Document> onDocumentPressed;
  final String? selectedDocumentId;

  @override
  Widget build(BuildContext context) {
    final showFilterControls = true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DocumentsHeader(
          searchController: searchController,
          canOpenScan: canOpenScan,
          onQueryChanged: onQueryChanged,
          onScanPressed: onScanPressed,
        ),
        if (showFilterControls) const SizedBox(height: 20),
        _SectorFilterChips(
          sectorFilter: sectorFilter,
          onSectorChanged: onSectorChanged,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: documents.isEmpty
              ? _EmptyDocumentsState(
                  title: searchController.text.trim().isEmpty
                      ? 'No documents to show'
                      : 'No documents match your filters',
                  message: searchController.text.trim().isEmpty
                      ? 'The current role or selected sector does not expose any documents yet.'
                      : 'Try a different keyword, sector, or clear the current filters.',
                  actionLabel: searchController.text.trim().isEmpty
                      ? null
                      : 'Clear filters',
                  onActionPressed: searchController.text.trim().isEmpty
                      ? null
                      : () {
                          searchController.clear();
                          onSectorChanged(null);
                          onQueryChanged();
                        },
                )
              : ListView.separated(
                  padding: const EdgeInsets.only(bottom: 12),
                  itemCount: documents.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final document = documents[index];
                    final isSelected = document.id == selectedDocumentId;
                    return _DocumentListTile(
                      document: document,
                      isSelected: isSelected,
                      onTap: () => onDocumentPressed(document),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _DocumentsHeader extends StatelessWidget {
  const _DocumentsHeader({
    required this.searchController,
    required this.canOpenScan,
    required this.onQueryChanged,
    required this.onScanPressed,
  });

  final TextEditingController searchController;
  final bool canOpenScan;
  final VoidCallback onQueryChanged;
  final VoidCallback? onScanPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            onChanged: (_) => onQueryChanged(),
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: 'Search by title, OCR text, or tags',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchController.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        searchController.clear();
                        onQueryChanged();
                      },
                      icon: const Icon(Icons.close),
                      tooltip: 'Clear search',
                    ),
            ),
          ),
        ),
        if (canOpenScan) ...[
          const SizedBox(width: 14),
          FilledButton.icon(
            onPressed: onScanPressed,
            icon: const Icon(Icons.document_scanner_outlined),
            label: const Text('Scan Document'),
          ),
        ],
      ],
    );
  }
}

class _SectorFilterChips extends StatelessWidget {
  const _SectorFilterChips({
    required this.sectorFilter,
    required this.onSectorChanged,
  });

  final DocumentSector? sectorFilter;
  final ValueChanged<DocumentSector?> onSectorChanged;

  @override
  Widget build(BuildContext context) {
    final chips = <_SectorChipData>[
      const _SectorChipData(label: 'All', sector: null, color: AppTheme.accent),
      _SectorChipData(
        label: 'Real Estate',
        sector: DocumentSector.realEstate,
        color: AppTheme.realEstate,
      ),
      _SectorChipData(
        label: 'Legal',
        sector: DocumentSector.legal,
        color: AppTheme.legal,
      ),
      _SectorChipData(
        label: 'Medical',
        sector: DocumentSector.medical,
        color: AppTheme.medical,
      ),
      _SectorChipData(
        label: 'Engineering',
        sector: DocumentSector.engineering,
        color: AppTheme.engineering,
      ),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var index = 0; index < chips.length; index++) ...[
            _SectorChip(
              data: chips[index],
              isSelected: sectorFilter == chips[index].sector,
              onSelected: () => onSectorChanged(chips[index].sector),
            ),
            if (index != chips.length - 1) const SizedBox(width: 10),
          ],
        ],
      ),
    );
  }
}

class _SectorChipData {
  const _SectorChipData({
    required this.label,
    required this.sector,
    required this.color,
  });

  final String label;
  final DocumentSector? sector;
  final Color color;
}

class _SectorChip extends StatelessWidget {
  const _SectorChip({
    required this.data,
    required this.isSelected,
    required this.onSelected,
  });

  final _SectorChipData data;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final selectedColor = data.color.withOpacity(0.2);
    final borderColor = isSelected ? data.color : AppTheme.cardHover;

    return FilterChip(
      selected: isSelected,
      onSelected: (_) => onSelected(),
      label: Text(data.label),
      avatar: _SectorDot(color: data.color),
      backgroundColor: AppTheme.card,
      selectedColor: selectedColor,
      checkmarkColor: data.color,
      side: BorderSide(color: borderColor.withOpacity(isSelected ? 1 : 0.8)),
      labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: isSelected ? Colors.white : AppTheme.textSecondary,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }
}

class _SectorDot extends StatelessWidget {
  const _SectorDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _DocumentListTile extends StatelessWidget {
  const _DocumentListTile({
    required this.document,
    required this.isSelected,
    required this.onTap,
  });

  final Document document;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sectorColor = _sectorColor(document.sector);
    final confidenceColor = _confidenceColor(document.completenessScore);

    return Material(
      color: isSelected ? AppTheme.cardHover.withOpacity(0.9) : AppTheme.card,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected
                  ? AppTheme.accent
                  : AppTheme.cardHover.withOpacity(0.55),
            ),
          ),
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: sectorColor.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text(
                    document.iconEmoji,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            document.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        _ConfidenceBadge(
                          score: document.completenessScore,
                          color: confidenceColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      document.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final tag in document.tags) _TagChip(label: tag),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _MetaLine(
                          icon: Icons.calendar_month_outlined,
                          label: _formatDate(document.dateCreated),
                        ),
                        _MetaLine(
                          icon: Icons.document_scanner_outlined,
                          label:
                              '${document.completenessScore}% OCR confidence',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppTheme.cardHover.withOpacity(0.55)),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(color: AppTheme.textSecondary),
      ),
    );
  }
}

class _ConfidenceBadge extends StatelessWidget {
  const _ConfidenceBadge({required this.score, required this.color});

  final int score;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        '$score% OCR',
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _MetaLine extends StatelessWidget {
  const _MetaLine({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppTheme.textMuted),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: AppTheme.textMuted),
        ),
      ],
    );
  }
}

class _ScannerView extends StatelessWidget {
  const _ScannerView({required this.onScanPressed});

  final VoidCallback onScanPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton.icon(
              onPressed: onScanPressed,
              icon: const Icon(Icons.document_scanner_outlined),
              label: const Text('Scan Document'),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.card,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppTheme.cardHover.withOpacity(0.6)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppTheme.accent.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      Icons.document_scanner_outlined,
                      size: 34,
                      color: AppTheme.accent,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Scanner workspace',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Scanner users do not browse documents here. Use the scan button to capture a document and start extraction.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textSecondary,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyDocumentsState extends StatelessWidget {
  const _EmptyDocumentsState({
    required this.title,
    required this.message,
    required this.actionLabel,
    required this.onActionPressed,
  });

  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: AppTheme.card,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: AppTheme.cardHover.withOpacity(0.6)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppTheme.textMuted.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.folder_open_outlined,
                  size: 34,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              if (actionLabel != null && onActionPressed != null) ...[
                const SizedBox(height: 18),
                OutlinedButton(
                  onPressed: onActionPressed,
                  child: Text(actionLabel!),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _InspectorPanelShell extends StatelessWidget {
  const _InspectorPanelShell({required this.document, required this.onClose});

  final Document? document;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    if (document == null) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.card,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AppTheme.cardHover.withOpacity(0.6)),
        ),
        child: const _InspectorEmptyState(),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppTheme.cardHover.withOpacity(0.6)),
      ),
      child: _DocumentInspectorSurface(document: document!, onClose: onClose),
    );
  }
}

class _InspectorEmptyState extends StatelessWidget {
  const _InspectorEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: AppTheme.accent.withOpacity(0.14),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.visibility_outlined,
              size: 34,
              color: AppTheme.accent,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Select a document',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            'Open a document from the list to inspect the AI summary, OCR text, and workflow timeline.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentInspectorSurface extends StatelessWidget {
  const _DocumentInspectorSurface({
    required this.document,
    required this.onClose,
  });

  final Document document;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final sectorColor = _sectorColor(document.sector);

    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 14, 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppTheme.cardHover.withOpacity(0.55)),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: sectorColor.withOpacity(0.16),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                    child: Text(
                      document.iconEmoji,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        document.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        document.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onClose != null) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: onClose,
                    icon: const Icon(Icons.close),
                    tooltip: 'Close inspector',
                  ),
                ],
              ],
            ),
          ),
          const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'AI Analysis'),
              Tab(text: 'OCR Text'),
              Tab(text: 'Workflow'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _AiAnalysisTab(document: document),
                _OcrTextTab(document: document),
                _WorkflowTab(document: document),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AiAnalysisTab extends StatelessWidget {
  const _AiAnalysisTab({required this.document});

  final Document document;

  @override
  Widget build(BuildContext context) {
    final sectorColor = _sectorColor(document.sector);
    final score = document.completenessScore.clamp(0, 100) / 100;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summary',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            document.aiSummary,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondary,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Extracted Fields',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          ...document.aiFields.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppTheme.cardHover.withOpacity(0.55),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        entry.key,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 5,
                      child: Text(
                        entry.value,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: sectorColor.withOpacity(0.28)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Completeness Score',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    Text(
                      '${document.completenessScore}%',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: score,
                    minHeight: 12,
                    backgroundColor: AppTheme.cardHover,
                    valueColor: AlwaysStoppedAnimation<Color>(sectorColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OcrTextTab extends StatelessWidget {
  const _OcrTextTab({required this.document});

  final Document document;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.cardHover.withOpacity(0.55)),
        ),
        child: SelectableText(
          document.ocrText,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontFamily: 'monospace',
            height: 1.5,
            color: AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _WorkflowTab extends StatelessWidget {
  const _WorkflowTab({required this.document});

  final Document document;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Timeline',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          ...document.timeline.asMap().entries.expand((entry) {
            final index = entry.key;
            final timelineEntry = entry.value;
            return [
              _TimelineItem(
                title: timelineEntry.title,
                date: timelineEntry.date,
                isLast: index == document.timeline.length - 1,
              ),
              if (index != document.timeline.length - 1)
                const SizedBox(height: 12),
            ];
          }),
          const SizedBox(height: 20),
          Text(
            'Risk Indicators',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          if (document.risks.isEmpty)
            _RiskBanner(
              color: AppTheme.success,
              icon: Icons.verified_outlined,
              title: 'No risks detected',
              message:
                  'The current workflow review did not flag any known issues.',
            )
          else
            ...document.risks.map(
              (risk) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _RiskBanner(
                  color: AppTheme.warning,
                  icon: Icons.error_outline,
                  title: 'Review required',
                  message: risk,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.title,
    required this.date,
    required this.isLast,
  });

  final String title;
  final DateTime date;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final sectorColor = AppTheme.accent;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: sectorColor,
                shape: BoxShape.circle,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 54,
                margin: const EdgeInsets.only(top: 4),
                color: AppTheme.cardHover,
              ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.cardHover.withOpacity(0.55)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDate(date),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RiskBanner extends StatelessWidget {
  const _RiskBanner({
    required this.color,
    required this.icon,
    required this.title,
    required this.message,
  });

  final Color color;
  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Color _sectorColor(DocumentSector sector) {
  return switch (sector) {
    DocumentSector.realEstate => AppTheme.realEstate,
    DocumentSector.legal => AppTheme.legal,
    DocumentSector.medical => AppTheme.medical,
    DocumentSector.engineering => AppTheme.engineering,
  };
}

Color _confidenceColor(int score) {
  if (score >= 90) {
    return AppTheme.success;
  }

  if (score >= 75) {
    return AppTheme.warning;
  }

  return AppTheme.error;
}

String _formatDate(DateTime date) {
  return DateFormat('dd MMM yyyy').format(date);
}
