import 'package:flutter/material.dart';
import 'package:health_app/view/bottom_tab/bottom_tab.dart';
import '../../common/color_extension.dart';
import '../../common_widgets/rounded_btn.dart';
import 'complete_profile.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  Gender? gender;
  int height = 180;
  int weight = 50;
  int age = 25;

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 65),
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
                  height: media.width * 0.05,
                ),

                Text(
                  "Height",
                  style: TextStyle(
                      color: TColour.black1,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
                Container(
                  margin: const EdgeInsets.all(15.0),
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
                  height: media.width * 0.03,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              Text(
                                "Weight",
                                style: TextStyle(
                                    color: TColour.black1,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: media.width * 0.02,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: TColour.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 2)
                                      ]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
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
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              Text(
                                "Age",
                                style: TextStyle(
                                    color: TColour.black1,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: media.width * 0.02,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: TColour.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 2)
                                      ]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: media.width * 0.1,
                ),
                RoundedButton(
                    title: "Update",
                    onPressed: () {
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
    );
  }
}
