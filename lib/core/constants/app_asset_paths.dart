class AssetPaths {
  static final AssetPaths _instance = AssetPaths._init();
  AssetPaths._init();

  factory AssetPaths() {
    return _instance;
  }

  String _toSVG(String name) => 'assets/svg/$name.svg';
  String _toPNG(String name) => 'assets/png/$name.png';
  String _toJPEG(String name) => 'assets/jpeg/$name.jpeg';
  String _toLOTTIE(String name) => 'assets/animations/$name.json';
  String _toGIF(String name) => 'assets/gif/$name.gif';

  //*SVG

  //*PNG
  String get home => _toPNG("home");
  String get message => _toPNG("message");
  String get settings => _toPNG("settings");

  //*JSON
  String get forgotPassword => _toLOTTIE("forgot_password");
  String get auth => _toLOTTIE("auth");

  //*GIF
}
