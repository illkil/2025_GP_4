import 'package:flutter/foundation.dart';

class MatchStore {
  MatchStore._();
  static final MatchStore instance = MatchStore._();

  final Set<String> _acceptedMatches = {};

  bool isAccepted(String reportId) => _acceptedMatches.contains(reportId);

  void accept(String reportId) {
    _acceptedMatches.add(reportId);
    debugPrint('Match accepted for $reportId');
  }

  void revoke(String reportId) {
    _acceptedMatches.remove(reportId);
    debugPrint('Match revoked for $reportId');
  }
}
