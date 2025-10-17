import '../infrastructure/system_service.dart';
import '../domain/command_output_line.dart';

class InstallVSCodeUseCase {
  final SystemService systemService;
  final String debUrl;
  final String downloadFolder;
  InstallVSCodeUseCase(
    this.systemService, {
    required this.debUrl,
    required this.downloadFolder,
  });

  Stream<CommandOutputLine> call() async* {
    // Try apt install code first
    await for (final line in systemService.installPackageByName('code')) {
      yield line;
      if (line.exitCode != null && line.exitCode == 0) return;
    }
    // Fallback to .deb download/install
    await for (final line in systemService.installDebFromUrl(
      debUrl,
      downloadFolder: downloadFolder,
    )) {
      yield line;
    }
  }
}
