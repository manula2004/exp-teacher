// ─────────────────────────────────────────────────────────────────────────────
// StudentModel — represents a single student in a class.
// ─────────────────────────────────────────────────────────────────────────────
class StudentModel {
  const StudentModel({
    required this.id,
    required this.name,
    required this.classId,
    required this.performancePercent,
  });

  final String id;
  final String name;
  final String classId;

  /// 0–100 inclusive.
  final double performancePercent;

  /// Performance band derived from the HTML banding spec:
  ///   Strong       → ≥85%
  ///   Mid          → 70–84%
  ///   Needs Support → <70%
  PerformanceBand get band {
    if (performancePercent >= 85) return PerformanceBand.strong;
    if (performancePercent >= 70) return PerformanceBand.mid;
    return PerformanceBand.needsSupport;
  }
}

enum PerformanceBand { strong, mid, needsSupport }
