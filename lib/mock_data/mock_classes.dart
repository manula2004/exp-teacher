import '../models/class_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Mock class data — 8 classes with varied subjects/counts.
// One class has a deliberately long name to exercise text-overflow handling.
// The default list is NOT empty; empty state is only reached via search.
// ─────────────────────────────────────────────────────────────────────────────
final List<ClassModel> mockClasses = [
  const ClassModel(
    id: 'cls-001',
    name: 'Mathematics 101',
    subject: 'Grade 10 • Section A',
    schedule: 'Mon/Wed 09:00 AM',
    room: 'Lab 402',
    studentCount: 28,
    nextExamDate: 'Oct 15',
  ),
  const ClassModel(
    id: 'cls-002',
    name: 'Advanced Physics',
    subject: 'Grade 12 • Section B',
    schedule: 'Tue/Thu 11:00 AM',
    room: 'Room 301',
    studentCount: 22,
    nextExamDate: 'Oct 18',
  ),
  const ClassModel(
    id: 'cls-003',
    name: 'Introduction to Ethics',
    subject: 'Grade 9 • Section C',
    schedule: 'Mon/Wed/Fri 08:00 AM',
    room: 'Room 105',
    studentCount: 31,
    nextExamDate: 'Nov 02',
  ),
  const ClassModel(
    id: 'cls-004',
    name: 'English Literature',
    subject: 'Grade 11 • Section A',
    schedule: 'Tue/Thu 02:00 PM',
    room: 'Room 210',
    studentCount: 25,
    nextExamDate: 'Oct 12',
  ),
  const ClassModel(
    id: 'cls-005',
    name: 'Chemistry — Organic & Inorganic Compounds (Advanced)',
    subject: 'Grade 12 • Section D',
    schedule: 'Mon/Wed 01:00 PM',
    room: 'Science Lab 2',
    studentCount: 18,
    nextExamDate: 'Nov 20',
  ),
  const ClassModel(
    id: 'cls-006',
    name: 'World History',
    subject: 'Grade 10 • Section B',
    schedule: 'Fri 10:00 AM',
    room: 'Room 108',
    studentCount: 30,
    nextExamDate: 'Dec 01',
  ),
  const ClassModel(
    id: 'cls-007',
    name: 'Computer Science',
    subject: 'Grade 11 • Section C',
    schedule: 'Tue/Thu 09:00 AM',
    room: 'IT Lab 1',
    studentCount: 20,
    nextExamDate: 'Oct 28',
  ),
  const ClassModel(
    id: 'cls-008',
    name: 'Biology',
    subject: 'Grade 9 • Section A',
    schedule: 'Mon/Wed/Fri 10:00 AM',
    room: 'Bio Lab',
    studentCount: 27,
    nextExamDate: 'Nov 10',
  ),
];
