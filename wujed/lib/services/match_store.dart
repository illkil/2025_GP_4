import 'package:flutter/foundation.dart';

enum MatchStatus {
  none,      // no decision yet
  accepted,  // user accepted the match
  revoked,   // user revoked after accepting
}

class MatchStore {
  MatchStore._();
  static final MatchStore instance = MatchStore._();

  final Map<String, MatchStatus> _states = {};

  MatchStatus statusOf(String reportId) =>
      _states[reportId] ?? MatchStatus.none;

  bool isAccepted(String reportId) =>
      statusOf(reportId) == MatchStatus.accepted;

  void accept(String reportId) {
    _states[reportId] = MatchStatus.accepted;
    debugPrint('Match accepted for $reportId');
  }

  void revoke(String reportId) {
    _states[reportId] = MatchStatus.revoked;
    debugPrint('Match revoked for $reportId');
  }

}
