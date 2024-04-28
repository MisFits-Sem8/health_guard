import 'package:flutter/material.dart';
import 'package:health_app/common_widgets/gender_card.dart';
import 'package:health_app/view/bottom_tab/bottom_tab.dart';
import '../../common/color_extension.dart';
import '../../common_widgets/rounded_btn.dart';
import '../../services/auth_service.dart';

enum Gender {
  male,
  female,
}

class CompleteProfileView extends StatefulWidget {
  const CompleteProfileView({super.key});

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  final _auth = AuthService();

  late Gender? gender;
  int height = 180;
  int weight = 50;
  int age = 25;
  final _formKey = GlobalKey<FormState>();
  final _sleep = TextEditingController();
  final _workout = TextEditingController();
  final _water = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: TColour.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Let's Complete your Profile",
                    style: TextStyle(
                        color: TColour.black1,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "It will help us to get to know more about you",
                    style: TextStyle(color: TColour.gray, fontSize: 13),
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  Text(
                    "Gender",
                    style: TextStyle(
                        color: TColour.black1,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: media.width * 0.02,
                  ),
                  Row(
                    children: [
                      GenderCard(
                        genderType: Gender.male,
                        onPress: () {
                          setState(() {
                            gender = Gender.male;
                          });
                        },
                        boxColor: gender == Gender.male
                            ? TColour.secondaryColor1
                            : TColour.white,
                      ),
                      GenderCard(
                          onPress: () {
                            setState(() {
                              gender = Gender.female;
                            });
                          },
                          genderType: Gender.female,
                          boxColor: gender == Gender.female
                              ? TColour.secondaryColor1
                              : TColour.white)
                    ],
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  Text(
                    "Height",
                    style: TextStyle(
                        color: TColour.black1,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    height: media.height * 0.15,
                    decoration: BoxDecoration(
                        color: TColour.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 2)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline
                              .alphabetic, //both arguments are needed, crossaxis with baseline
                          children: [
                            Text(
                              height.toString(),
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const Text(
                              "cm",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF8D8E98),
                              ),
                            )
                          ],
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: TColour.primaryColor2,
                            inactiveTrackColor: TColour.gray.withOpacity(0.3),
                            thumbColor: TColour.primaryColor1,
                            overlayColor: TColour.secondaryColor1,
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 10.0),
                            overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 20.0),
                          ),
                          child: Slider(
                              value: height.toDouble(),
                              min: 120.0,
                              max: 220.0,
                              onChanged: (double newValue) {
                                setState(() {
                                  height = newValue.round();
                                });
                              }),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: media.height * 0.02,
                  ),
                  Row(
                    children: [
                      Container(
                        width: media.width * 0.42,
                        child: Column(
                          children: [
                            Text(
                              "Weight",
                              style: TextStyle(
                                  color: TColour.black1,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                            Container(
                              height: media.height * 0.15,
                              margin:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              decoration: BoxDecoration(
                                  color: TColour.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12, blurRadius: 2)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline
                                        .alphabetic, //both arguments are needed, crossaxis with baseline
                                    children: [
                                      Text(
                                        weight.toString(),
                                        style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text(
                                        "kg",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: TColour.lightTextGray,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            weight--;
                                          });
                                        },
                                        icon: const Icon(Icons.arrow_drop_down),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            weight++;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.arrow_drop_up,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: media.width * 0.06,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text(
                              "Age",
                              style: TextStyle(
                                  color: TColour.black1,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                            Container(
                              height: media.height * 0.15,
                              margin:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              width: media.width * 0.42,
                              decoration: BoxDecoration(
                                  color: TColour.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12, blurRadius: 2)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline
                                        .alphabetic, //both arguments are needed, crossaxis with baseline
                                    children: [
                                      Text(
                                        age.toString(),
                                        style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text(
                                        "yo",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: TColour.lightTextGray,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            age--;
                                          });
                                        },
                                        icon: const Icon(Icons.arrow_drop_down),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            age++;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.arrow_drop_up,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: media.height * 0.02,
                  ),
                  Text(
                    "Set your goals",
                    style: TextStyle(
                        color: TColour.black1,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        color: TColour.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 2)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.local_drink, color: Colors.blue),
                            const SizedBox(width: 8),
                            const Text("Water"),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                controller: _water,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "litres",
                              style: TextStyle(
                                  fontSize: 13, color: TColour.lightTextGray),
                            ),
                          ],
                        ),
                        // Sleep Goal Row
                        Row(
                          children: [
                            const Icon(Icons.bedtime, color: Colors.orange),
                            const SizedBox(width: 8),
                            const Text("Sleep"),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                controller: _sleep,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "hrs",
                              style: TextStyle(
                                  fontSize: 13, color: TColour.lightTextGray),
                            ),
                          ],
                        ),
                        // Workout Goal Row
                        Row(
                          children: [
                            const Icon(Icons.fitness_center,
                                color: Colors.purple),
                            const SizedBox(width: 8),
                            const Text("Workout"),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                controller: _workout,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "hrs",
                              style: TextStyle(
                                  fontSize: 13, color: TColour.lightTextGray),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.06,
                  ),
                  RoundedButton(
                      title: "Update",
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _auth.addUserData(
                              height,
                              weight,
                              age,
                              _water.text as double,
                              _workout.text as double,
                              _sleep.text as double,
                              gender.toString());
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BottomTab()));
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
