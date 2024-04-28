import 'package:flutter/material.dart';
import 'package:health_app/view/bottom_tab/bottom_tab.dart';
import '../../common/color_extension.dart';
import '../../common_widgets/rounded_btn.dart';
import '../../services/auth_service.dart';

class EditProfileView extends StatefulWidget {
  late int height;
  late int weight;
  late int age;
  late double sleep;
  late double water;
  late double workout;
  final String gender;
  EditProfileView(
      {required this.height,
      required this.weight,
      required this.sleep,
      required this.water,
      required this.workout,
      required this.age,
      required this.gender});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _auth = AuthService();
  final _editProfileFormKey = GlobalKey<FormState>();
  late final _sleep = TextEditingController(text: widget.sleep.toString());
  late final _workout = TextEditingController(text: widget.workout.toString());
  late final _water = TextEditingController(text: widget.water.toString());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColour.white,
        centerTitle: true,
        elevation: 0,
        // leadingWidth: 0,
        title: Text(
          "Edit Profile",
          style: TextStyle(
              color: TColour.black1, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: TColour.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: media.width * 0.05),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Let's Update your Profile",
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
                  height: media.height * 0.025,
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
                            '${widget.height}',
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
                            value: widget.height.toDouble(),
                            min: 120.0,
                            max: 220.0,
                            onChanged: (double newValue) {
                              setState(() {
                                widget.height = newValue.round();
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
                            margin: const EdgeInsets.symmetric(vertical: 15.0),
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
                                      widget.weight.toString(),
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
                                          widget.weight--;
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
                                          widget.weight++;
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
                            margin: const EdgeInsets.symmetric(vertical: 15.0),
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
                                      widget.age.toString(),
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
                                          widget.age--;
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
                                          widget.age++;
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
                  "Update your goals",
                  style: TextStyle(
                      color: TColour.black1,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15.0),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      color: TColour.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 2)
                      ]),
                  child: Form(
                    key: _editProfileFormKey,
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _water.text = "1.5";
                                    }
                                    return null;
                                  }),
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
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  controller: _sleep,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _sleep.text = "6.0";
                                    }
                                    return null;
                                  }),
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _workout.text = "1.0";
                                    }
                                    return null;
                                  }),
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
                ),
                SizedBox(
                  height: media.height * 0.01,
                ),
                RoundedButton(
                    title: "Update",
                    onPressed: () {
                      if (_editProfileFormKey.currentState?.validate() ??
                          false) {
                        _auth.addUserData(
                          widget.height,
                          widget.weight,
                          widget.age,
                          double.parse(_water.text),
                          double.parse(_workout.text),
                          double.parse(_sleep.text),
                          widget.gender,
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BottomTab(),
                            ));                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
