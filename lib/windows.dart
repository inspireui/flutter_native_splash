part of flutter_native_splash;

void _createWindowsSplash({ int? width, int? height}) {
  if (width != null && height != null) {
    var mainMenu = File(_WindowsMainFile);
    mainMenu.createSync(recursive: true);
    mainMenu.writeAsStringSync(windowsMain(width, height));
  }
}
