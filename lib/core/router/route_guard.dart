import 'package:arctive/core/models/app_user.dart';
import 'package:arctive/core/models/document.dart';
import 'package:arctive/core/router/app_router.dart';
import 'package:arctive/core/services/auth_repository.dart';
import 'package:arctive/core/services/document_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:go_router/go_router.dart';

String? routeGuard(Ref ref, GoRouterState state) {
  final user = ref.read(currentAppUserProvider);
  final location = state.uri.path;

  final isAuthRoute =
      location == AppRoutes.login || location == AppRoutes.signup;

  if (user == null) {
    return isAuthRoute ? null : AppRoutes.login;
  }

  if (isAuthRoute) {
    return user.role == UserRole.scanner
        ? AppRoutes.scan
        : AppRoutes.documents;
  }

  if (user.role == UserRole.scanner) {
    if (location == AppRoutes.scan || location == AppRoutes.documents) {
      return null;
    }

    if (_isDocumentDetailRoute(location)) {
      return AppRoutes.documents;
    }

    return AppRoutes.scan;
  }

  if (location == AppRoutes.scan && !user.role.canOpenScan) {
    return AppRoutes.documents;
  }

  if (_isDocumentDetailRoute(location)) {
    final documentId = state.pathParameters['id'];
    if (documentId == null || documentId.isEmpty) {
      return AppRoutes.documents;
    }

    final document = ref.read(documentRepositoryProvider).getById(documentId);
    if (document == null) {
      return AppRoutes.documents;
    }

    if (!user.allowedSectors.contains(document.sector)) {
      return AppRoutes.documents;
    }
  }

  return null;
}

bool _isDocumentDetailRoute(String location) {
  return location.startsWith('/documents/');
}