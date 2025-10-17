import '../infrastructure/system_service.dart';
import '../domain/command_output_line.dart';

class InstallLutrisUseCase {
  final SystemService systemService;
  InstallLutrisUseCase(this.systemService);

  Stream<CommandOutputLine> call() =>
      systemService.installPackageByName('lutris');
}
