import '../infrastructure/system_service.dart';
import '../domain/command_output_line.dart';

class InstallDebUseCase {
  final SystemService systemService;
  final String downloadFolder;
  InstallDebUseCase(this.systemService, {required this.downloadFolder});

  Stream<CommandOutputLine> call(String url) =>
      systemService.installDebFromUrl(url, downloadFolder: downloadFolder);
}
