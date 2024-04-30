import 'dart:io';
import 'package:flutter/material.dart';
import 'package:health_app/models/chat.dart';
import 'package:health_app/models/daily_sleep.dart';
import 'package:health_app/models/daily_target.dart';
import 'package:health_app/models/depression_detector.dart';
import 'package:health_app/models/schedule.dart';
import 'package:health_app/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:health_app/models/daily_steps.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class FitnessDatabaseHelper {
  static FitnessDatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _fitnessDatabase; // Singleton Database

  // String stepsTable = 'daily_steps_table';
  // String colId = 'id';
  // String colDate = 'date';
  // String colSteps = 'steps';

  String stepsTable = 'daily_steps_table';
  String userTable = 'user_table';
  String sleepTable = 'sleep_table';
  String scheduleTable = 'schedule_table';
  String targetTable = 'target_table';
  String chatTable = 'chat_table';
  String depressionDetectorTable = 'depression_detector_table';

  String colId = 'id';
  String colDate = 'date';
  String colSteps = 'steps';
  String colUserId = 'user_id';
  String colName = 'name';
  String colEmail = 'email';
  String colGender = 'gender';
  String colAge = 'age';
  String colHeight = 'height';
  String colWeight = 'weight';
  String colDuration = 'duration';
  String colType = 'type';
  String colTime = 'time';
  String colIsActive = 'is_active';
  String colCalories = 'calories';
  String colWater = 'water';
  String colIsSender = 'is_sender';
  String colMessage = 'message';
  String colStressLevel = 'stress_level';
  String colSleepingStatus = 'sleeping_status';
  String colSadness = 'sadness';
  String colJoy = 'joy';
  String colLove = 'love';
  String colAngry = 'angry';
  String colFear = 'fear';
  String colSurprise = 'surprise';
  String colThoughts = 'thoughts';

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

    // Delete the database if it already exists
    // if (await databaseExists(path)) {
    //   await deleteDatabase(path);
    // }

    // Open/create the database at a given path
    var fitnessDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return fitnessDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $stepsTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colDate TEXT, $colSteps INTEGER, $colUserId INTEGER, FOREIGN KEY($colUserId) REFERENCES $userTable($colId))');
    await db.execute(
        'CREATE TABLE $userTable($colId TEXT PRIMARY KEY, $colName TEXT, $colEmail TEXT, $colGender TEXT, $colAge INTEGER, $colHeight INTEGER, $colWeight INTEGER)');
    await db.execute(
        'CREATE TABLE $sleepTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colUserId INTEGER, $colDate TEXT, $colDuration INTEGER, FOREIGN KEY($colUserId) REFERENCES $userTable($colId))');
    await db.execute(
        'CREATE TABLE $scheduleTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colUserId INTEGER, $colType TEXT, $colTime TEXT, $colIsActive BOOLEAN, FOREIGN KEY($colUserId) REFERENCES $userTable($colId))');
    await db.execute(
        'CREATE TABLE $targetTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colUserId INTEGER, $colCalories INTEGER, $colWater INTEGER, $colSteps INTEGER, FOREIGN KEY($colUserId) REFERENCES $userTable($colId))');
    await db.execute(
        'CREATE TABLE $chatTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colUserId INTEGER, $colIsSender BOOLEAN, $colMessage TEXT, FOREIGN KEY($colUserId) REFERENCES $userTable($colId))');
    await db.execute(
        'CREATE TABLE $depressionDetectorTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colUserId INTEGER, $colTime TEXT, $colStressLevel INTEGER, $colSleepingStatus TEXT, $colSadness INTEGER, $colJoy INTEGER, $colLove INTEGER, $colAngry INTEGER, $colFear INTEGER, $colSurprise INTEGER, $colThoughts TEXT, FOREIGN KEY($colUserId) REFERENCES $userTable($colId))');
  }

  // Fetch Operation: Get all DailySteps objects from database
  Future<List<Map<String, dynamic>>> getStepsMapList(String userId) async {
    Database db = await fitnessDatabase;
    var result = await db.query(
      stepsTable,
      where: '$colUserId = ?',
      whereArgs: [userId],
      orderBy: '$colDate ASC',
    );
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
  Future<List<DailySteps>> getStepsList(String userId) async {
    var stepsMapList =
        await getStepsMapList(userId); // Get 'Map List' from database
    int count =
        stepsMapList.length; // Count the number of map entries in db table

    List<DailySteps> stepsList = [];
    // For loop to create a 'FlSpot List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      DailySteps dailySteps = DailySteps.fromMapObject(stepsMapList[i]);
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
      DailySteps dailySteps = DailySteps(date, steps, "1");
      await insertSteps(dailySteps);
    }
  }

  Future<int> insertUser(UserDataModel user) async {
    Database db = await fitnessDatabase;

    // Check if user already exists
    List<Map> existingUsers = await db
        .query(userTable, where: '$colEmail = ?', whereArgs: [user.email]);

    // If user does not exist, insert new user
    if (existingUsers.isEmpty) {
      var result = await db.insert(userTable, user.toMap());
      return result;
    } else {
      debugPrint('User with email ${user.email} already exists');
      return -1;
    }
  }

  Future<int> updateUser(UserDataModel user) async {
    Database db = await fitnessDatabase;
    var result = await db.update(userTable, user.toMap(),
        where: '$colId = ?', whereArgs: [user.id]);
    return result;
  }

  Future<int> deleteUser(int id) async {
    var db = await fitnessDatabase;
    int result =
        await db.rawDelete('DELETE FROM $userTable WHERE $colId = $id');
    return result;
  }

  Future<List<UserDataModel>> getUserList() async {
    var userMapList = await getUserMapList();
    int count = userMapList.length;

    List<UserDataModel> userList = [];
    for (int i = 0; i < count; i++) {
      UserDataModel user = UserDataModel.fromMapObject(userMapList[i]);
      userList.add(user);
    }

    return userList;
  }

  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await fitnessDatabase;
    var result = await db.query(userTable);
    return result;
  }

  // Sleep table operations
  Future<int> insertSleep(Sleep sleep) async {
    Database db = await fitnessDatabase;
    var result = await db.insert(sleepTable, sleep.toMap());
    return result;
  }

  Future<int> updateSleep(Sleep sleep) async {
    Database db = await fitnessDatabase;
    var result = await db.update(sleepTable, sleep.toMap(),
        where: '$colId = ?', whereArgs: [sleep.id]);
    return result;
  }

  Future<int> deleteSleep(int id) async {
    var db = await fitnessDatabase;
    int result =
        await db.rawDelete('DELETE FROM $sleepTable WHERE $colId = $id');
    return result;
  }

  Future<List<Sleep>> getSleepList() async {
    var sleepMapList = await getSleepMapList();
    int count = sleepMapList.length;

    List<Sleep> sleepList = [];
    for (int i = 0; i < count; i++) {
      Sleep sleep = Sleep.fromMapObject(sleepMapList[i]);
      sleepList.add(sleep);
    }

    return sleepList;
  }

  Future<List<Map<String, dynamic>>> getSleepMapList() async {
    Database db = await fitnessDatabase;
    var result = await db.query(sleepTable);
    return result;
  }

  Future<int> insertSchedule(Schedule schedule) async {
    Database db = await fitnessDatabase;
    var result = await db.insert(scheduleTable, schedule.toMap());
    return result;
  }

  Future<int> updateSchedule(Schedule schedule) async {
    Database db = await fitnessDatabase;
    var result = await db.update(scheduleTable, schedule.toMap(),
        where: '$colId = ?', whereArgs: [schedule.id]);
    return result;
  }

  Future<int> deleteSchedule(int id) async {
    var db = await fitnessDatabase;
    int result =
        await db.rawDelete('DELETE FROM $scheduleTable WHERE $colId = $id');
    return result;
  }

  Future<List<Schedule>> getScheduleList(String userId) async {
    var scheduleMapList = await getScheduleMapList(userId);
    int count = scheduleMapList.length;

    List<Schedule> scheduleList = [];
    for (int i = 0; i < count; i++) {
      Schedule schedule = Schedule.fromMapObject(scheduleMapList[i]);
      scheduleList.add(schedule);
    }

    return scheduleList;
  }

  Future<List<Map<String, dynamic>>> getScheduleMapList(String userId) async {
    Database db = await fitnessDatabase;
    var result = await db.query(
      scheduleTable,
      where: '$colUserId = ?',
      whereArgs: [userId],
    );
    return result;
  }

  // Target table operations
  Future<int> insertTarget(Target target) async {
    Database db = await fitnessDatabase;
    var result = await db.insert(targetTable, target.toMap());
    return result;
  }

  Future<int> updateTarget(Target target) async {
    Database db = await fitnessDatabase;
    var result = await db.update(targetTable, target.toMap(),
        where: '$colId = ?', whereArgs: [target.id]);
    return result;
  }

  Future<int> deleteTarget(int id) async {
    var db = await fitnessDatabase;
    int result =
        await db.rawDelete('DELETE FROM $targetTable WHERE $colId = $id');
    return result;
  }

  Future<List<Target>> getTargetList() async {
    var targetMapList = await getTargetMapList();
    int count = targetMapList.length;

    List<Target> targetList = [];
    for (int i = 0; i < count; i++) {
      Target target = Target.fromMapObject(targetMapList[i]);
      targetList.add(target);
    }

    return targetList;
  }

  Future<List<Map<String, dynamic>>> getTargetMapList() async {
    Database db = await fitnessDatabase;
    var result = await db.query(targetTable);
    return result;
  }

  // Chat table operations
  Future<int> insertChat(Chat chat) async {
    Database db = await fitnessDatabase;
    var result = await db.insert(chatTable, chat.toMap());
    return result;
  }

  Future<int> updateChat(Chat chat) async {
    Database db = await fitnessDatabase;
    var result = await db.update(chatTable, chat.toMap(),
        where: '$colId = ?', whereArgs: [chat.id]);
    return result;
  }

  Future<int> deleteChat(int id) async {
    var db = await fitnessDatabase;
    int result =
        await db.rawDelete('DELETE FROM $chatTable WHERE $colId = $id');
    return result;
  }

  Future<List<Chat>> getChatList() async {
    var chatMapList = await getChatMapList();
    int count = chatMapList.length;

    List<Chat> chatList = [];
    for (int i = 0; i < count; i++) {
      Chat chat = Chat.fromMapObject(chatMapList[i]);
      chatList.add(chat);
    }

    return chatList;
  }

  Future<List<Map<String, dynamic>>> getChatMapList() async {
    Database db = await fitnessDatabase;
    var result = await db.query(chatTable);
    return result;
  }

  // Depression Detector table operations
  Future<int> insertDepressionDetector(DepressionDetector detector) async {
    Database db = await fitnessDatabase;
    var result = await db.insert(depressionDetectorTable, detector.toMap());
    return result;
  }

  Future<int> updateDepressionDetector(DepressionDetector detector) async {
    Database db = await fitnessDatabase;
    var result = await db.update(depressionDetectorTable, detector.toMap(),
        where: '$colId = ?', whereArgs: [detector.id]);
    return result;
  }

  Future<int> deleteDepressionDetector(int id) async {
    var db = await fitnessDatabase;
    int result = await db
        .rawDelete('DELETE FROM $depressionDetectorTable WHERE $colId = $id');
    return result;
  }

  Future<List<DepressionDetector>> getDepressionDetectorList() async {
    var detectorMapList = await getDepressionDetectorMapList();
    int count = detectorMapList.length;

    List<DepressionDetector> detectorList = [];
    for (int i = 0; i < count; i++) {
      DepressionDetector detector =
          DepressionDetector.fromMapObject(detectorMapList[i]);
      detectorList.add(detector);
    }

    return detectorList;
  }

  Future<List<Map<String, dynamic>>> getDepressionDetectorMapList() async {
    Database db = await fitnessDatabase;
    var result = await db.query(depressionDetectorTable);
    return result;
  }
}
