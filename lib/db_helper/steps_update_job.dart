import 'package:health_app/db_helper/db_helper.dart';
import 'package:health_app/repositories/data_repository.dart';
import 'package:health_app/model/daily_steps.dart';

void executeCronJob() async {
  FitnessDatabaseHelper databaseHelper = FitnessDatabaseHelper();
  DataRepository dataRepository = DataRepository();
  Map<int, DailySteps> recordSteps = dataRepository.recordSteps;

  // Get the list of keys from the recordSteps map and sort it in descending order
  List<int> keys = recordSteps.keys.toList()..sort((a, b) => b.compareTo(a));

  // Call _updateSteps_ for the two highest keys in the list
  if (keys.isNotEmpty) {
    int highestKey = keys[0];
    DailySteps step1 = recordSteps[highestKey]!;
    await databaseHelper.updateSteps(step1);

    if (keys.length > 1) {
      int secondHighestKey = keys[1];
      DailySteps step2 = recordSteps[secondHighestKey]!;
      await databaseHelper.updateSteps(step2);
    }
  }
  // print(databaseHelper.getStepsList());
}
