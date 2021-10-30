import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:planilla_de_calidad/classes/trainning.dart';
import 'package:path_provider/path_provider.dart';

class Database{
  List<Trainning> trainningsDB;

  Database({required this.trainningsDB});

  Map<String, dynamic> toJson() => {
    "trainnings": List<dynamic>.from(trainningsDB.map((e) => e.toJson()))
  };

  factory Database.fromJson(Map<String, dynamic> jsonDB) => Database(
    trainningsDB: List<Trainning>.from(jsonDB["trainnings"].map((x) => Trainning.formJson(x))),
  )
  ;
}

class DatabaseFileRoutines{
  Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async{
    final path = await _localPath;

    return File('$path/localDB.json');
  }

  Future writeDataBase(String json) async{
    final file = await _localFile;

    try {
      file.writeAsString(json);
    } catch (e) {
      print("$e");
    }
  }

  Future<String> readDataBase() async{
    try {
      final file = await _localFile;

      if(!file.existsSync()){
        print('File does not exist: ${file.absolute}');
        await writeDataBase('{"trainnings":[]}}');
      }
      String content = await file.readAsString();
      return content;

    } catch (e) {
      print("error reading Database: $e");
      return "";
    }
  }
}

Database databaseFronJson(String string){
  final dataFromJson  = json.decode(string);
  return Database.fromJson(dataFromJson);
}

String databaseToJson(Database data){
  final dataToJson = data.toJson();
  return json.encode(dataToJson);
}