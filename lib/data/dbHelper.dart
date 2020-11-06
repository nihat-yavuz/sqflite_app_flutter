import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_app/models/product.dart';

class DbHelper {
  Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "ecommerce.db");
    var eCommerceDb =
        await openDatabase(dbPath, version: 1, onCreate: createDb);
    return eCommerceDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table products(id integer primary key, name text, description text, unitPrice integer)");
  }

  Future<List<Product>> getProducts() async {
    Database db = await this.db;
    var result = await db.query("products");
    return List.generate(result.length, (index) {
      return Product.fromObject(result[index]);
    });
  }

  Future<int> insert(Product product) async {
    Database db = await this.db;
    var result = await db.insert("products", product.toMap());
    return result;
  }

  //This is method(rawDelete,rawUpdate etc.),
  // may cause some security issues like SQL Injection!
  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from products where id=$id");
    return result;
  }

  // ? means parameter --> id=? <--
  // write parameters to whereArgs as a [list]
  Future<int> update(Product product) async {
    Database db = await this.db;
    var result = await db.update("products", product.toMap(),
        where: "id=?", whereArgs: [product.id]);
    return result;
  }
}
