import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:health_app/model/daily_steps.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class FitnessDatabaseHelper {
  static FitnessDatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _fitnessDatabase; // Singleton Database

  String stepsTable = 'daily_steps_table';
  String colId = 'id';
  String colDate = 'date';
  String colSteps = 'steps';

  FitnessDatabaseHelper._createInstance();

  factory FitnessDatabaseHelper() {
    _databaseHelper ??= FitnessDatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get fitnessDatabase async {
    _fitnessDatabase ??= await initializeDatabase();
    return _fitnessDatabase!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}fitness.db';

    // Open/create the database at a given path
    var fitnessDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return fitnessDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $stepsTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colDate TEXT, $colSteps INTEGER)');
  }

  // Fetch Operation: Get all DailySteps objects from database
  Future<List<Map<String, dynamic>>> getStepsMapList() async {
    Database db = await fitnessDatabase;
    var result = await db.query(stepsTable, orderBy: '$colDate ASC');
    return result;
  }

  // Insert Operation: Insert a DailySteps object to database
  Future<int> insertSteps(DailySteps steps) async {
    Database db = await fitnessDatabase;
    var result = await db.insert(stepsTable, steps.toMap());
    return result;
  }

  // Update Operation: Update a DailySteps object and save it to database
  Future<int> updateSteps(DailySteps steps) async {
    Database db = await fitnessDatabase;

    // Check if the record exists
    List<Map> result = await db
        .query(stepsTable, where: '$colDate = ?', whereArgs: [steps.date]);

    if (result.isEmpty) {
      // If the record doesn't exist, insert it
      return await db.insert(stepsTable, steps.toMap());
    } else {
      // If the record exists, update it
      return await db.update(stepsTable, steps.toMap(),
          where: '$colDate = ?', whereArgs: [steps.date]);
    }
  }

  // Delete Operation: Delete a DailySteps object from database
  Future<int> deleteSteps(int id) async {
    var db = await fitnessDatabase;
    int result =
        await db.rawDelete('DELETE FROM $stepsTable WHERE $colId = $id');
    return result;
  }

  // Truncate Operation: Delete all DailySteps objects from database
  Future<int> truncateStepsTable() async {
    var db = await fitnessDatabase;
    int result = await db.rawDelete('DELETE FROM $stepsTable');
    return result;
  }

  // Get number of DailySteps objects in database
  Future<int?> getCount() async {
    Database db = await fitnessDatabase;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $stepsTable');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'DailySteps List' [ List<DailySteps> ]
  Future<List<DailySteps>> getStepsList() async {
    var stepsMapList = await getStepsMapList(); // Get 'Map List' from database
    int count =
        stepsMapList.length; // Count the number of map entries in db table

    List<DailySteps> stepsList = [];
    // For loop to create a 'FlSpot List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      DailySteps dailySteps = DailySteps.fromMapObject(stepsMapList[i]);
      // double date =
      //     double.parse(DateTime.parse(dailySteps.date).day.toString());
      // double steps = double.parse(dailySteps.steps.toString());
      stepsList.add(dailySteps);
    }

    return stepsList;
  }

  Future<void> populateDb() async {
    var rng = new Random();
    for (int i = 18; i <= 28; i++) {
      String date = '2024-04-${i.toString().padLeft(2, '0')}';
      int steps = rng.nextInt(990) +
          10; // generates a random integer where 10 <= _ <= 2000
      DailySteps dailySteps = DailySteps(date, steps);
      await insertSteps(dailySteps);
    }
  }
}
