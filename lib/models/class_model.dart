// ─────────────────────────────────────────────────────────────────────────────
// ClassModel — represents a single teacher's class.
// ─────────────────────────────────────────────────────────────────────────────
class ClassModel {
  const ClassModel({
    required this.id,
    required this.name,
    required this.subject,
    required this.schedule,
    required this.room,
    required this.studentCount,
    required this.nextExamDate,
  });

  final String id;
  final String name;
  final String subject;
  final String schedule;
  final String room;
  final int studentCount;
  final String nextExamDate;
}
