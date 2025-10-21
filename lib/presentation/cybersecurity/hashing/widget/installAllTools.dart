import '../hashing_export.dart';

class Installalltools {
  final BuildContext context;
  final system;
  Installalltools(this.context, this.system) {
    installAllTools(context, system);
  }
  void installAllTools(BuildContext context, system) {
    final tools = [
      'john',
      'hashcat',
      'openssl',
      'cryptsetup',
      'gnupg',
      'coreutils',
      'pwgen',
      'passage',
    ];

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Install All Cryptography Tools'),
            content: Text(
              'This will install ${tools.length} cryptography and hashing tools. Continue?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  showConsoleStream(
                    context,
                    system.runAsRoot([
                      'apt',
                      'update',
                      '&&',
                      'apt',
                      'install',
                      '-y',
                      ...tools,
                    ]),
                  );
                },
                child: const Text('Install All'),
              ),
            ],
          ),
    );
  }
}
