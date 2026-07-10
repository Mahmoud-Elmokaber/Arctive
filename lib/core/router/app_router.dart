import 'package:arctive/core/models/app_user.dart';
import 'package:arctive/features/auth/login_page.dart';
import 'package:arctive/features/auth/signup_page.dart';
import 'package:arctive/features/dashboard/dashboard_page.dart';
import 'package:arctive/features/doc_details/document_details_page.dart';
import 'package:arctive/features/documents/documents_page.dart';
import 'package:arctive/features/ocr_scan/ocr_scan_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'route_guard.dart';
import 'package:arctive/core/services/auth_repository.dart';

part 'app_router.g.dart';

class AppRoutes {
  static const login = '/login';
  static const signup = '/signup';
  static const dashboard = '/dashboard';
  static const documents = '/documents';
  static const scan = '/scan';
  static const documentDetails = '/documents/:id';
}

@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  ref.watch(currentAppUserProvider);

  return GoRouter(
    initialLocation: AppRoutes.login,
    redirect: (context, state) => routeGuard(ref, state),
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: AppRoutes.documents,
        builder: (context, state) => const DocumentsPage(),
      ),
      GoRoute(
        path: AppRoutes.scan,
        builder: (context, state) => const OcrScanPage(),
      ),
      GoRoute(
        path: AppRoutes.documentDetails,
        builder: (context, state) {
          final documentId = state.pathParameters['id'] ?? '';
          return DocumentDetailsPage(documentId: documentId);
        },
      ),
    ],
  );
}