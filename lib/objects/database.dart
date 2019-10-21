/*
    Classe responsavel por manipular os dados dos 
    resultados obtidos dos testes no banco de dados SQLite.

    Foi baseado no código do @Rahiche, hospedado no GitHub 
    através deste link: https://github.com/Rahiche/sqlite_demo/blob/master/lib/Database.dart
 */
import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:Veloz/objects/resultClass.dart';

class DBProvider{
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async{
    if(this._database != null){
      return this._database;
    }
    this._database = await initDatabase();
    return this._database;
  }

  // Função de inicialização(criação) do banco de dados
  initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Result ("
          "ID       INTEGER PRIMARY KEY AUTOINCREMENT,"
          "IDSERVER INTEGER NOT NULL,"
          "PINGAVG  INTEGER NOT NULL,"
          "DOWNAVG  INTEGER NOT NULL,"
          "UPAVG    INTEGER NOT NULL,"
          "DATE     TEXT    NOT NULL"
          ")");
    });
  }

  // Função que insere o resultado que acabou de ser obtido nos testes no Banco de dados
  insertResult(ResultTest result) async {
    final db = await database;
    var res = await db.rawInsert(
      "INSERT INTO Result (IDSERVER,PINGAVG,DOWNAVG,UPAVG,DATE)"
      " VALUES (${result.idServer},${result.pingAvg},${result.downAvg},${result.upAvg},${result.date})");
    return res;
  }

  // Função que retorna uma lista com os últimos 15 testes feitos, dado um identificador do servidor.
  // Este resultado capturado é usado para gerar os gráficos inseridos no HistoryPage
  Future<List<ResultTest>> getClient(int idServer) async {
    final db = await database;
    var res = await  db.query("Result", where: "IDSERVER = ?", whereArgs: [idServer],orderBy: 'ID DESC', limit: 15);
    return res.isNotEmpty ? res.map((c) => ResultTest.fromMap(c)).toList() : [] ;
  }
}