import '../infrastructure/system_service.dart';
import '../domain/command_output_line.dart';

class UpdateUseCase {
  final SystemService systemService;
  UpdateUseCase(this.systemService);

  Stream<CommandOutputLine> call() => systemService.update();
}
