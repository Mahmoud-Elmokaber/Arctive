import 'package:arctive/core/models/document.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'document_repository.g.dart';

abstract class DocumentRepository {
  List<Document> getAll();

  Document? getById(String id);

  List<Document> getBySector(DocumentSector sector);

  List<Document> search(String query);

  void add(Document document);

  void update(Document document);

  void delete(String id);
}

class MockDocumentRepository implements DocumentRepository {
  MockDocumentRepository() : _documents = List<Document>.from(_seedDocuments);

  final List<Document> _documents;

  static final List<Document> _seedDocuments = [
    Document(
      id: 'doc_1',
      title: 'Sale Agreement - Suite 204',
      sector: DocumentSector.realEstate,
      dateCreated: DateTime.parse('2026-06-12'),
      description: 'Commercial property transfer in New Cairo',
      tags: const ['sale', 'commercial', 'contract'],
      ocrText:
          'PROPERTY PURCHASE AND SALES CONTRACT\n\nDate: June 12, 2026\nDeveloper: CityScape Developments S.A.E\nBuyer: Mr. Hany Rashed Aly\nNational ID: 28805040123456\n\nProperty details:\nUnit reference: Tower B, Suite 204\nTotal Floor Area: 120sqm\nTotal Price: EGP 6,800,000\nDownpayment paid: EGP 1,500,000\nBalance due: 24 monthly installments of EGP 220,833',
      aiSummary:
          'A commercial property sale contract for Suite 204 in Tower B, New Cairo. The buyer is Hany Rashed Aly purchasing from CityScape Developments for EGP 6.8 million.',
      aiFields: const {
        'Buyer Name': 'Hany Rashed Aly',
        'Developer': 'CityScape Developments',
        'Unit No': 'Suite 204',
        'Property Area': '120 sqm',
        'Total Price': 'EGP 6,800,000',
        'Downpayment': 'EGP 1,500,000',
      },
      timeline: [
        DocumentTimelineEntry(
          title: 'Contract Signed',
          date: DateTime.parse('2026-06-12'),
        ),
        DocumentTimelineEntry(
          title: 'First Installment Due',
          date: DateTime.parse('2026-07-12'),
        ),
        DocumentTimelineEntry(
          title: 'Unit Handover Expected',
          date: DateTime.parse('2028-12-01'),
        ),
      ],
      risks: const [
        'No late payment penalty clause found.',
        'Missing official notary public stamp.',
      ],
      completenessScore: 85,
      iconEmoji: '🏢',
      colorHex: '#6366F1',
    ),
    Document(
      id: 'doc_2',
      title: 'Power of Attorney - General',
      sector: DocumentSector.legal,
      dateCreated: DateTime.parse('2026-05-30'),
      description: 'Notarized representation documents',
      tags: const ['POA', 'notarized', 'court'],
      ocrText:
          'GENERAL POWER OF ATTORNEY\n\nRegistry No: 7854 / 2026\nNotary Office: Heliopolis District, Cairo\n\nPRINCIPAL: Counselor Sherif Mamdouh Abdelaziz\nATTORNEY: Advocate Tarek Mohsen Mahmoud\nBar Registration: 56984\n\nPowers granted:\nThe Principal hereby grants the Attorney full authority to act in all civil court hearings, sign settlement papers, represent in property sales disputes, and manage utility registration procedures.',
      aiSummary:
          'General power of attorney (Registry No. 7854/2026) issued at Heliopolis Notary Office. Principal Counselor Sherif Mamdouh Abdelaziz authorizes Advocate Tarek Mohsen Mahmoud to act in civil court hearings and property sales disputes.',
      aiFields: const {
        'Principal': 'Sherif Mamdouh Abdelaziz',
        'Attorney': 'Tarek Mohsen Mahmoud',
        'Registry No': '7854 / 2026',
        'Notary Office': 'Heliopolis District',
        'Attorney Bar ID': '56984',
      },
      timeline: [
        DocumentTimelineEntry(
          title: 'POA Issuance',
          date: DateTime.parse('2026-05-30'),
        ),
        DocumentTimelineEntry(
          title: 'Annual Registry Validation',
          date: DateTime.parse('2027-05-30'),
        ),
      ],
      risks: const [
        'Unrestricted financial power of attorney.',
        'No validation expiry date specified.',
      ],
      completenessScore: 92,
      iconEmoji: '⚖️',
      colorHex: '#F59E0B',
    ),
    Document(
      id: 'doc_3',
      title: 'X-Ray Diagnosis - Samir Aly',
      sector: DocumentSector.medical,
      dateCreated: DateTime.parse('2026-04-18'),
      description: 'Diagnostic clinic reports',
      tags: const ['orthopedic', 'X-ray', 'diagnosis'],
      ocrText:
          'CAIRO DIAGNOSTIC CLINIC & IMAGING CENTER\n\nPatient Name: Mr. Samir Aly Mansour\nAge: 45 | Sex: Male\nDate: April 18, 2026\nReferral Doctor: Dr. Khaled Ibrahim\n\nExam: Left Shoulder Digital Radiography\n\nFINDINGS:\nNo fracture or dislocation noted.\nMinor acromioclavicular joint osteophyte formation.\nSubacromial space narrowing suggesting rotator cuff tendinopathy.\n\nIMPRESSION:\nSigns of rotator cuff impingement. Recommend clinical correlation and MRI evaluation.',
      aiSummary:
          'Left shoulder digital radiography report for patient Samir Aly Mansour (45). Exam finds no fractures, but notes rotator cuff tendinopathy and impingement. Recommends MRI evaluation.',
      aiFields: const {
        'Patient Name': 'Samir Aly Mansour',
        'Referral Doctor': 'Dr. Khaled Ibrahim',
        'Exam Type': 'Left Shoulder X-Ray',
        'Finding': 'Rotator cuff impingement',
        'Recommendation': 'Rotator Cuff MRI Evaluation',
      },
      timeline: [
        DocumentTimelineEntry(
          title: 'X-Ray Performed',
          date: DateTime.parse('2026-04-18'),
        ),
        DocumentTimelineEntry(
          title: 'MRI Review Due',
          date: DateTime.parse('2026-05-02'),
        ),
      ],
      risks: const ['Risk of tendon tear if untreated.'],
      completenessScore: 96,
      iconEmoji: '🏥',
      colorHex: '#10B981',
    ),
    Document(
      id: 'doc_4',
      title: 'Permit - Heliopolis Tower',
      sector: DocumentSector.engineering,
      dateCreated: DateTime.parse('2026-03-05'),
      description: 'Structural syndicate approvals',
      tags: const ['permit', 'syndicate', 'structural'],
      ocrText:
          'EGYPTIAN SYNDICATE OF ENGINEERS\nPERMIT LICENSE FOR TALL BUILDING CONSTRUCTION\n\nProject Code: HT-3392\nLicense Date: March 5, 2026\nConsultant Engineer: Eng. Khaled Wafiq Taha\nRegistration No: 99827\n\nProject Scope:\nLocation: Plot 12, District 6, Heliopolis, Cairo\nBuilding specifications: 15 floors above ground + 2 underground parking floors.\nPermitted loads and soil calculations verified according to Code 2022.',
      aiSummary:
          'Construction permit (HT-3392) issued by the Egyptian Syndicate of Engineers. Consultant Engineer Khaled Wafiq Taha registered for a 15-floor building construction at Plot 12, District 6, Heliopolis.',
      aiFields: const {
        'Consultant': 'Eng. Khaled Wafiq Taha',
        'Project Code': 'HT-3392',
        'Plot Location': 'Plot 12, Heliopolis',
        'Max Floors': '15 floors + 2 basements',
        'Syndicate ID': '99827',
      },
      timeline: [
        DocumentTimelineEntry(
          title: 'Permit Issuance',
          date: DateTime.parse('2026-03-05'),
        ),
        DocumentTimelineEntry(
          title: 'Foundation Excavation Audit',
          date: DateTime.parse('2026-09-05'),
        ),
        DocumentTimelineEntry(
          title: 'Syndicate Permit Expiry',
          date: DateTime.parse('2029-03-05'),
        ),
      ],
      risks: const [
        'Permit expiry scheduled for 2029-03-05.',
        'Missing third-party civil liability insurance document.',
      ],
      completenessScore: 89,
      iconEmoji: '⚙️',
      colorHex: '#EC4899',
    ),
  ];

  @override
  List<Document> getAll() => List<Document>.unmodifiable(_documents);

  @override
  Document? getById(String id) {
    for (final document in _documents) {
      if (document.id == id) {
        return document;
      }
    }
    return null;
  }

  @override
  List<Document> getBySector(DocumentSector sector) {
    return _documents
        .where((document) => document.sector == sector)
        .toList(growable: false);
  }

  @override
  List<Document> search(String query) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) {
      return getAll();
    }

    return _documents
        .where((document) {
          final haystacks = <String>[
            document.id,
            document.title,
            document.description,
            document.ocrText,
            document.aiSummary,
            document.iconEmoji,
            document.colorHex,
            document.sector.name,
            ...document.tags,
            ...document.aiFields.keys,
            ...document.aiFields.values,
            ...document.risks,
            ...document.timeline.map((entry) => entry.title),
          ];

          return haystacks.any(
            (value) => value.toLowerCase().contains(normalizedQuery),
          );
        })
        .toList(growable: false);
  }

  @override
  void add(Document document) {
    _documents.add(document);
  }

  @override
  void update(Document document) {
    final index = _documents.indexWhere(
      (existing) => existing.id == document.id,
    );
    if (index == -1) {
      _documents.add(document);
      return;
    }

    _documents[index] = document;
  }

  @override
  void delete(String id) {
    _documents.removeWhere((document) => document.id == id);
  }
}

@Riverpod(keepAlive: true)
DocumentRepository documentRepository(DocumentRepositoryRef ref) {
  return MockDocumentRepository();
}
