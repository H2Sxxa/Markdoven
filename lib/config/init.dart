import 'dart:convert';
import 'dart:io';

var initTemplate = {"host": "127.0.0.1", "port": 9098};

var configFile = File("mdv_Data/config.json");
void initConfig() {
  if (!configFile.existsSync()) {
    configFile.writeAsStringSync(jsonEncode(initTemplate));
  }
}

dynamic readValue(String key) {
  return jsonDecode(configFile.readAsStringSync())[key];
}
