import '../infrastructure/system_service.dart';
import '../domain/command_output_line.dart';

class UpgradeUseCase {
  final SystemService systemService;
  UpgradeUseCase(this.systemService);

  Stream<CommandOutputLine> call() => systemService.upgrade();
}
