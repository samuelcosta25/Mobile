import 'package:path/path.dart';
import '/Model/UserModel.dart';
import 'package:sqflite/sqflite.dart';

class BancoDadosCrud {
  // Atributos
  static const String DB_NOME = 'flutter_db'; // Nome do banco de dados
  static const String TABLE_NOME = 'flutters'; // Nome da tabela de usuários

  static const String CREATE_USUARIOS_TABLE_SCRIPT =
      "CREATE TABLE IF NOT EXISTS $TABLE_NOME("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "nome TEXT,"
      "cpf TEXT,"
      "email TEXT,"
      "senha TEXT"
      ")";

  static final BancoDadosCrud _instance = BancoDadosCrud._();
  static Database? _database;

  BancoDadosCrud._();

  factory BancoDadosCrud() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), DB_NOME);
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(CREATE_USUARIOS_TABLE_SCRIPT);
      },
    );
  }

  Future<void> create(ContatoModel model) async {
    try {
      final Database db = await database;
      await db.insert(TABLE_NOME, model.toMap());
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future<List<ContatoModel>> getUsuarios() async {
    try {
      final Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query(TABLE_NOME);
      return List.generate(
        maps.length,
        (i) {
          return ContatoModel(
            nome: maps[i]['nome'],
            cpf: maps[i]['cpf'],
            email: maps[i]['email'],
            senha: maps[i]['senha'],
          );
        },
      );
    } catch (ex) {
      print(ex);
      return [];
    }
  }

  Future<bool> checkUserByEmailExists(String email, String senha) async {
    try {
      final Database db = await database;
      final List<Map<String, dynamic>> result = await db.query(
        TABLE_NOME,
        where: 'email = ? and senha = ?',
        whereArgs: [email, senha],
      );
      return result.isNotEmpty;
    } catch (ex) {
      print(ex);
      return false;
    }
  }

  Future<ContatoModel?> readByEmail(String email) async {
    try {
      final Database db = await database;
      final List<Map<String, dynamic>> result = await db.query(
        TABLE_NOME,
        where: 'email = ?',
        whereArgs: [email],
      );
      if (result.isNotEmpty) {
        return ContatoModel(
          nome: result[0]['nome'],
          cpf: result[0]['cpf'],
          email: result[0]['email'],
          senha: result[0]['senha'],
        );
      } else {
        return null;
      }
    } catch (ex) {
      print(ex);
      return null;
    }
  }
}
