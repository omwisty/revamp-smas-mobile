enum Environment {
  dev,
  stage,
  prod,
}

class AppConfig {
  static late Map<String, dynamic> _config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        _config = _Config.debugConstants;
        break;
      case Environment.stage:
        _config = _Config.stageConstants;
        break;
      case Environment.prod:
        _config = _Config.prodConstants;
        break;
    }
  }

  static String get env {
    return _config[_Config.flavour] as String;
  }
}

class _Config {
  static const flavour = 'flavour';

  static Map<String, dynamic> debugConstants = {
    flavour: 'dev',
  };

  static Map<String, dynamic> stageConstants = {
    flavour: 'stage',
  };

  static Map<String, dynamic> prodConstants = {
    flavour: 'prod',
  };
}

extension FlavourTypeExtension on String {
  String getEnvironmentName() {
    switch (this) {
      case 'dev':
        return 'Development';
      case 'stage':
        return 'Staging';
      case 'prod':
        return 'Production';
      default:
        return 'Unknown';
    }
  }

  String getEndpoint() {
    switch (this) {
      case 'dev':
        return 'http://10.0.148.255:8443/v2';
      case 'stage':
        return 'http://10.0.148.255:8443/v2';
      case 'prod':
        return 'https://websvc02.smartfren.com/v2';
      default:
        return 'https://websvc02.smartfren.com/v2';
    }
  }
}