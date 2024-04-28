import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_app/services/sleep_track_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:health_app/common/color_extension.dart';
import 'package:health_app/view/on_boarding/getting_started_view.dart';
import 'firebase_options.dart';
import 'package:cron/cron.dart';
import 'package:health_app/db_helper/db_helper.dart';
import 'package:health_app/db_helper/steps_update_job.dart';

void main() async {
  final cron = Cron();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  sqfliteFfiInit();
  var databaseFactory = databaseFactoryFfi;
  final FitnessDatabaseHelper dbh = FitnessDatabaseHelper();
  final Future<Database> db = dbh.fitnessDatabase;
  // await dbh.initializeDatabase();
  // dbh.truncateStepsTable();

  cron.schedule(Schedule.parse('*/10 * * * *'), () async {
    executeCronJob();
    debugPrint("steps count updated to local database");
  });

  SleepTracker _sleepTracker = SleepTracker();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Health Guard',
        theme: ThemeData(
          primaryColor: TColour.primaryColor1,
          fontFamily: "Poppins",
          useMaterial3: true,
        ),
        home: const GettingStartedView());
  }
}
