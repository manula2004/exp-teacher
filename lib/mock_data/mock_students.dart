import '../models/student_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Mock student data — 15 students per class, spread across all three
// performance bands so every filter (All / Strong / Needs Support) is testable.
//
// Band breakdown per class (consistent pattern):
//   Strong (≥85%)       → 6 students
//   Mid    (70–84%)     → 5 students
//   Needs Support (<70%) → 4 students
// ─────────────────────────────────────────────────────────────────────────────

List<StudentModel> studentsForClass(String classId) {
  return _allStudents.where((s) => s.classId == classId).toList();
}

final List<StudentModel> _allStudents = [
  // ── cls-001: Mathematics 101 ─────────────────────────────────────────────
  const StudentModel(id: 'S001', classId: 'cls-001', name: 'Alex Johnson',      performancePercent: 94),
  const StudentModel(id: 'S002', classId: 'cls-001', name: 'Maria Garcia',      performancePercent: 91),
  const StudentModel(id: 'S003', classId: 'cls-001', name: 'Lina Chen',         performancePercent: 98),
  const StudentModel(id: 'S004', classId: 'cls-001', name: 'Priya Nair',        performancePercent: 88),
  const StudentModel(id: 'S005', classId: 'cls-001', name: 'Samuel Osei',       performancePercent: 86),
  const StudentModel(id: 'S006', classId: 'cls-001', name: 'Fatima Al-Amin',    performancePercent: 85),
  const StudentModel(id: 'S007', classId: 'cls-001', name: 'Ethan Hunt',        performancePercent: 82),
  const StudentModel(id: 'S008', classId: 'cls-001', name: 'Zara Williams',     performancePercent: 78),
  const StudentModel(id: 'S009', classId: 'cls-001', name: 'Diego Reyes',       performancePercent: 75),
  const StudentModel(id: 'S010', classId: 'cls-001', name: 'Amelia Brooks',     performancePercent: 70),
  const StudentModel(id: 'S011', classId: 'cls-001', name: 'James Wilson',      performancePercent: 68),
  const StudentModel(id: 'S012', classId: 'cls-001', name: 'Hana Kimura',       performancePercent: 62),
  const StudentModel(id: 'S013', classId: 'cls-001', name: 'Oliver Thompson',   performancePercent: 55),
  const StudentModel(id: 'S014', classId: 'cls-001', name: 'Chloe Dupont',      performancePercent: 48),
  const StudentModel(id: 'S015', classId: 'cls-001', name: 'Ravi Sharma',       performancePercent: 72),

  // ── cls-002: Advanced Physics ────────────────────────────────────────────
  const StudentModel(id: 'S101', classId: 'cls-002', name: 'Sofia Martinez',    performancePercent: 96),
  const StudentModel(id: 'S102', classId: 'cls-002', name: 'Lucas Müller',      performancePercent: 93),
  const StudentModel(id: 'S103', classId: 'cls-002', name: 'Aisha Patel',       performancePercent: 90),
  const StudentModel(id: 'S104', classId: 'cls-002', name: 'Tom Laurent',       performancePercent: 87),
  const StudentModel(id: 'S105', classId: 'cls-002', name: 'Elena Rossi',       performancePercent: 85),
  const StudentModel(id: 'S106', classId: 'cls-002', name: 'Kai Nakamura',      performancePercent: 86),
  const StudentModel(id: 'S107', classId: 'cls-002', name: 'Bea Schneider',     performancePercent: 80),
  const StudentModel(id: 'S108', classId: 'cls-002', name: 'Finn O\'Brien',     performancePercent: 76),
  const StudentModel(id: 'S109', classId: 'cls-002', name: 'Yuna Park',         performancePercent: 73),
  const StudentModel(id: 'S110', classId: 'cls-002', name: 'Noah Costa',        performancePercent: 71),
  const StudentModel(id: 'S111', classId: 'cls-002', name: 'Isla Cameron',      performancePercent: 74),
  const StudentModel(id: 'S112', classId: 'cls-002', name: 'Max Krüger',        performancePercent: 65),
  const StudentModel(id: 'S113', classId: 'cls-002', name: 'Camille Leroy',     performancePercent: 58),
  const StudentModel(id: 'S114', classId: 'cls-002', name: 'Ahmed Hassan',      performancePercent: 52),
  const StudentModel(id: 'S115', classId: 'cls-002', name: 'Ingrid Svensson',   performancePercent: 63),

  // ── cls-003: Introduction to Ethics ─────────────────────────────────────
  const StudentModel(id: 'S201', classId: 'cls-003', name: 'Mia Andersen',      performancePercent: 97),
  const StudentModel(id: 'S202', classId: 'cls-003', name: 'Ethan Clark',       performancePercent: 92),
  const StudentModel(id: 'S203', classId: 'cls-003', name: 'Zara Ahmed',        performancePercent: 89),
  const StudentModel(id: 'S204', classId: 'cls-003', name: 'Leon Fischer',      performancePercent: 85),
  const StudentModel(id: 'S205', classId: 'cls-003', name: 'Amara Diallo',      performancePercent: 88),
  const StudentModel(id: 'S206', classId: 'cls-003', name: 'Hugo Bernard',      performancePercent: 87),
  const StudentModel(id: 'S207', classId: 'cls-003', name: 'Lily Nguyen',       performancePercent: 83),
  const StudentModel(id: 'S208', classId: 'cls-003', name: 'Ben Walsh',         performancePercent: 79),
  const StudentModel(id: 'S209', classId: 'cls-003', name: 'Nora Jensen',       performancePercent: 76),
  const StudentModel(id: 'S210', classId: 'cls-003', name: 'Tariq Al-Rashid',   performancePercent: 72),
  const StudentModel(id: 'S211', classId: 'cls-003', name: 'Vera Popova',       performancePercent: 70),
  const StudentModel(id: 'S212', classId: 'cls-003', name: 'Karl Bergmann',     performancePercent: 66),
  const StudentModel(id: 'S213', classId: 'cls-003', name: 'Grace O\'Sullivan',  performancePercent: 59),
  const StudentModel(id: 'S214', classId: 'cls-003', name: 'Jae-won Oh',        performancePercent: 50),
  const StudentModel(id: 'S215', classId: 'cls-003', name: 'Freya Larsson',     performancePercent: 45),

  // ── cls-004: English Literature ──────────────────────────────────────────
  const StudentModel(id: 'S301', classId: 'cls-004', name: 'Charlotte Evans',   performancePercent: 99),
  const StudentModel(id: 'S302', classId: 'cls-004', name: 'Oscar Silva',       performancePercent: 93),
  const StudentModel(id: 'S303', classId: 'cls-004', name: 'Aria Singh',        performancePercent: 90),
  const StudentModel(id: 'S304', classId: 'cls-004', name: 'William Brown',     performancePercent: 88),
  const StudentModel(id: 'S305', classId: 'cls-004', name: 'Isla Mackenzie',    performancePercent: 86),
  const StudentModel(id: 'S306', classId: 'cls-004', name: 'Felix Wagner',      performancePercent: 85),
  const StudentModel(id: 'S307', classId: 'cls-004', name: 'Luna Ibáñez',       performancePercent: 81),
  const StudentModel(id: 'S308', classId: 'cls-004', name: 'Ryan Murphy',       performancePercent: 77),
  const StudentModel(id: 'S309', classId: 'cls-004', name: 'Mei Lin',           performancePercent: 74),
  const StudentModel(id: 'S310', classId: 'cls-004', name: 'Bjorn Eriksson',    performancePercent: 71),
  const StudentModel(id: 'S311', classId: 'cls-004', name: 'Tanya Volkov',      performancePercent: 70),
  const StudentModel(id: 'S312', classId: 'cls-004', name: 'Kieran Walsh',      performancePercent: 67),
  const StudentModel(id: 'S313', classId: 'cls-004', name: 'Simone Moreau',     performancePercent: 61),
  const StudentModel(id: 'S314', classId: 'cls-004', name: 'Amir Khalil',       performancePercent: 55),
  const StudentModel(id: 'S315', classId: 'cls-004', name: 'Hana Yamamoto',     performancePercent: 49),

  // ── cls-005: Chemistry (long name class) ─────────────────────────────────
  const StudentModel(id: 'S401', classId: 'cls-005', name: 'Isabelle Fontaine', performancePercent: 95),
  const StudentModel(id: 'S402', classId: 'cls-005', name: 'Marco Vitale',      performancePercent: 91),
  const StudentModel(id: 'S403', classId: 'cls-005', name: 'Leila Mansouri',    performancePercent: 88),
  const StudentModel(id: 'S404', classId: 'cls-005', name: 'Henry Whitfield',   performancePercent: 87),
  const StudentModel(id: 'S405', classId: 'cls-005', name: 'Aiko Tanaka',       performancePercent: 85),
  const StudentModel(id: 'S406', classId: 'cls-005', name: 'Pedro Alves',       performancePercent: 86),
  const StudentModel(id: 'S407', classId: 'cls-005', name: 'Sophie Dupuis',     performancePercent: 83),
  const StudentModel(id: 'S408', classId: 'cls-005', name: 'Cian Gallagher',    performancePercent: 78),
  const StudentModel(id: 'S409', classId: 'cls-005', name: 'Nia Okafor',        performancePercent: 75),
  const StudentModel(id: 'S410', classId: 'cls-005', name: 'Sam Kowalski',      performancePercent: 72),
  const StudentModel(id: 'S411', classId: 'cls-005', name: 'Darya Ivanova',     performancePercent: 70),
  const StudentModel(id: 'S412', classId: 'cls-005', name: 'Emre Yilmaz',       performancePercent: 64),
  const StudentModel(id: 'S413', classId: 'cls-005', name: 'Elsa Lindqvist',    performancePercent: 57),
  const StudentModel(id: 'S414', classId: 'cls-005', name: 'Theo Baumann',      performancePercent: 51),
  const StudentModel(id: 'S415', classId: 'cls-005', name: 'Ji-ho Choi',        performancePercent: 44),

  // ── cls-006: World History ────────────────────────────────────────────────
  const StudentModel(id: 'S501', classId: 'cls-006', name: 'Anna Kowalczyk',    performancePercent: 96),
  const StudentModel(id: 'S502', classId: 'cls-006', name: 'Nathan Bradley',    performancePercent: 92),
  const StudentModel(id: 'S503', classId: 'cls-006', name: 'Sana Mirza',        performancePercent: 89),
  const StudentModel(id: 'S504', classId: 'cls-006', name: 'Tobias Roth',       performancePercent: 86),
  const StudentModel(id: 'S505', classId: 'cls-006', name: 'Fatou Diop',        performancePercent: 85),
  const StudentModel(id: 'S506', classId: 'cls-006', name: 'Victor Nguyen',     performancePercent: 88),
  const StudentModel(id: 'S507', classId: 'cls-006', name: 'Marisol Torres',    performancePercent: 82),
  const StudentModel(id: 'S508', classId: 'cls-006', name: 'Callum Reid',       performancePercent: 79),
  const StudentModel(id: 'S509', classId: 'cls-006', name: 'Yuki Hayashi',      performancePercent: 75),
  const StudentModel(id: 'S510', classId: 'cls-006', name: 'Adina Ionescu',     performancePercent: 71),
  const StudentModel(id: 'S511', classId: 'cls-006', name: 'Damian Wojcik',     performancePercent: 73),
  const StudentModel(id: 'S512', classId: 'cls-006', name: 'Nour El-Din',       performancePercent: 68),
  const StudentModel(id: 'S513', classId: 'cls-006', name: 'Petra Horak',       performancePercent: 60),
  const StudentModel(id: 'S514', classId: 'cls-006', name: 'Luca Romano',       performancePercent: 53),
  const StudentModel(id: 'S515', classId: 'cls-006', name: 'Abby Chen',         performancePercent: 47),

  // ── cls-007: Computer Science ─────────────────────────────────────────────
  const StudentModel(id: 'S601', classId: 'cls-007', name: 'Liam Patel',        performancePercent: 98),
  const StudentModel(id: 'S602', classId: 'cls-007', name: 'Zoe Andersson',     performancePercent: 94),
  const StudentModel(id: 'S603', classId: 'cls-007', name: 'Marcus Webb',       performancePercent: 91),
  const StudentModel(id: 'S604', classId: 'cls-007', name: 'Chiara Conti',      performancePercent: 87),
  const StudentModel(id: 'S605', classId: 'cls-007', name: 'Daan van der Berg', performancePercent: 85),
  const StudentModel(id: 'S606', classId: 'cls-007', name: 'Nadia El-Fassi',    performancePercent: 86),
  const StudentModel(id: 'S607', classId: 'cls-007', name: 'Rupert Holmes',     performancePercent: 84),
  const StudentModel(id: 'S608', classId: 'cls-007', name: 'Layla Hussain',     performancePercent: 78),
  const StudentModel(id: 'S609', classId: 'cls-007', name: 'Soren Nielsen',     performancePercent: 74),
  const StudentModel(id: 'S610', classId: 'cls-007', name: 'Beatriz Santos',    performancePercent: 71),
  const StudentModel(id: 'S611', classId: 'cls-007', name: 'Piotr Kaczmarek',   performancePercent: 70),
  const StudentModel(id: 'S612', classId: 'cls-007', name: 'Tao Zhang',         performancePercent: 65),
  const StudentModel(id: 'S613', classId: 'cls-007', name: 'Evie Gallagher',    performancePercent: 58),
  const StudentModel(id: 'S614', classId: 'cls-007', name: 'Kofi Mensah',       performancePercent: 52),
  const StudentModel(id: 'S615', classId: 'cls-007', name: 'Rina Watanabe',     performancePercent: 46),

  // ── cls-008: Biology ─────────────────────────────────────────────────────
  const StudentModel(id: 'S701', classId: 'cls-008', name: 'Harper Lee',        performancePercent: 97),
  const StudentModel(id: 'S702', classId: 'cls-008', name: 'Ezra Cohen',        performancePercent: 93),
  const StudentModel(id: 'S703', classId: 'cls-008', name: 'Mia Johansson',     performancePercent: 90),
  const StudentModel(id: 'S704', classId: 'cls-008', name: 'Arjun Mehta',       performancePercent: 88),
  const StudentModel(id: 'S705', classId: 'cls-008', name: 'Celeste Moreau',    performancePercent: 86),
  const StudentModel(id: 'S706', classId: 'cls-008', name: 'Sven Lindberg',     performancePercent: 85),
  const StudentModel(id: 'S707', classId: 'cls-008', name: 'Tara O\'Brien',     performancePercent: 83),
  const StudentModel(id: 'S708', classId: 'cls-008', name: 'Isaac Abrams',      performancePercent: 80),
  const StudentModel(id: 'S709', classId: 'cls-008', name: 'Amara Diallo',      performancePercent: 76),
  const StudentModel(id: 'S710', classId: 'cls-008', name: 'Kirra Anderson',    performancePercent: 72),
  const StudentModel(id: 'S711', classId: 'cls-008', name: 'Vasile Ionescu',    performancePercent: 70),
  const StudentModel(id: 'S712', classId: 'cls-008', name: 'Umi Nakamura',      performancePercent: 67),
  const StudentModel(id: 'S713', classId: 'cls-008', name: 'Finn Brennan',      performancePercent: 61),
  const StudentModel(id: 'S714', classId: 'cls-008', name: 'Elif Sahin',        performancePercent: 54),
  const StudentModel(id: 'S715', classId: 'cls-008', name: 'Leo Mwangi',        performancePercent: 48),
];
