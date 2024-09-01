import 'package:campusleave/features/email/email_repository/email_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campusleave/models/faculty_advisor_model.dart';

final facultyAdvisorControllerProvider =
    StateNotifierProvider<FacultyAdvisorController, FacultyAdvisor?>((ref) {
  final facultyAdvisorRepository = ref.watch(facultyAdvisorRepositoryProvider);
  return FacultyAdvisorController(facultyAdvisorRepository: facultyAdvisorRepository, ref: ref);
});

class FacultyAdvisorController extends StateNotifier<FacultyAdvisor?> {
  final FacultyAdvisorRepository _facultyAdvisorRepository;


  FacultyAdvisorController({
    required FacultyAdvisorRepository facultyAdvisorRepository,
    required Ref ref,
  })  : _facultyAdvisorRepository = facultyAdvisorRepository,
        super(null) {
    _fetchFacultyAdvisor();
  }

  void _fetchFacultyAdvisor() async {

    final advisors = await _facultyAdvisorRepository.getFacultyAdvisors();
    final advisor = advisors.firstWhere(
      (advisor) => advisor.branch == 'branch' && advisor.year == 2022,
      orElse: () => FacultyAdvisor(
        id: 'unknown', // Placeholder ID for unknown advisors
        name: 'Unknown',
        email: 'unknown@iitj.ac.in',
        branch: 'branch',
        year: 2022,
      ),
    );
    state = advisor;
  }
}
