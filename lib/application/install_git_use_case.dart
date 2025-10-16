import '../infrastructure/system_service.dart';
import '../domain/command_output_line.dart';

class InstallGitUseCase {
  final SystemService systemService;
  InstallGitUseCase(this.systemService);

  Stream<CommandOutputLine> call() => systemService.installPackageByName('git');
}
