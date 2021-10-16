part of flutter_native_splash;

class _MacosSplashImageTemplate {
  final String fileName;
  final double pixelDensity;

  _MacosSplashImageTemplate(
      {required this.fileName, required this.pixelDensity});
}

final List<_MacosSplashImageTemplate> MacosSplashImages =
    <_MacosSplashImageTemplate>[
  _MacosSplashImageTemplate(fileName: 'SplashImage.png', pixelDensity: 1),
  _MacosSplashImageTemplate(fileName: 'SplashImage@2x.png', pixelDensity: 2),
  _MacosSplashImageTemplate(fileName: 'SplashImage@3x.png', pixelDensity: 3),
];

void _createMacosSplash({required String? imagePath}) {
  if (imagePath == null) {
    return;
  }
  final image = decodeImage(File(imagePath).readAsBytesSync());
  if (image == null) {
    print(imagePath + ' could not be loaded.');
    exit(1);
  }
  MacosSplashImages.forEach((template) {
    var newFile = copyResize(
      image,
      width: image.width * template.pixelDensity ~/ 4,
      height: image.height * template.pixelDensity ~/ 4,
      interpolation: Interpolation.linear,
    );
    var file = File(_MacosAssetsSplashImageFolder + template.fileName);
    file.createSync(recursive: true);
    file.writeAsBytesSync(encodePng(newFile));
  });

  var splashImageFile = File(_MacosAssetsSplashImageFolder + 'Contents.json');
  splashImageFile.createSync(recursive: true);
  splashImageFile.writeAsStringSync(_MacosContentsJson);
}
