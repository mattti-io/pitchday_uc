import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pitchday/provider/room_data_provider.dart';
import 'package:pitchday/resources/socket_methods.dart';
import 'package:pitchday/utils.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        routes: {
          GameRoom.routeName: (context) => const GameRoom(),
          CreateLobby.routeName: (context) => const CreateLobby(),
        },
        theme: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
            selectionColor: Color(0xFFEF4136),
          ),
        ),
        home: const Landing(),
      ),
    );
  }
}

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF101010),
        body: Stack(
          children: [
            const Positioned(
              left: 50,
              right: 50,
              top: 50,
              child:
                  Align(alignment: Alignment.topCenter, child: PitchDayLogo()),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 150, 50, 150),
              child: Center(
                  child: Container(
                width: 1197.0,
                height: 651.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: const Color(0xFF202020),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 50,
                      right: 50,
                      top: 30,
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: SelectableText(
                            'Welcome to Pitch Day!',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.rubik(
                              fontSize: 33.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                    ),
                    Center(
                      child: SizedBox(
                        height: 180,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ButtonDings(
                                label: "Create Lobby",
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, CreateLobby.routeName);
                                }),
                            Text(
                              'or',
                              style: GoogleFonts.rubik(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                            TextOnlyButton(label: "Join Lobby")
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 30,
                      right: 30,
                      left: 30,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SocialBarBottom()),
                    )
                  ],
                ),
              )),
            )
          ],
        ));
  }
}

class CreateLobby extends StatefulWidget {
  static String routeName = "/createLobby";
  const CreateLobby({super.key});

  @override
  State<CreateLobby> createState() => _CreateLobbyState();
}

class _CreateLobbyState extends State<CreateLobby> {
  TextEditingController lobbyTitleController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  SocketMethods socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    socketMethods.createRoomSuccessListener(context);
    socketMethods.errorOccuredListener(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF101010),
        body: Stack(
          children: [
            const Positioned(
              left: 50,
              right: 50,
              top: 50,
              child:
                  Align(alignment: Alignment.topCenter, child: PitchDayLogo()),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 150, 50, 150),
              child: Center(
                  child: Container(
                width: 1197.0,
                height: 651.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: const Color(0xFF202020),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 50,
                      right: 50,
                      top: 30,
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: SelectableText(
                            'Create Lobby',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.rubik(
                              fontSize: 33.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                    ),
                    Center(
                      child: SizedBox(
                        height: 365,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextField(
                                hint: "Lobby Title",
                                controller: lobbyTitleController),
                            SizedBox(
                              width: 500,
                              child: Row(
                                children: [
                                  //Character Chooser
                                  SizedBox(
                                    height: 70,
                                    width: 70,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 70.0,
                                          height: 70.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            border: Border.all(
                                              width: 3.0,
                                              color: const Color(0xFFDEDEDE),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: SizedBox(
                                              width: 23.0,
                                              height: 23.0,
                                              child: Container(
                                                width: 23.0,
                                                height: 23.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                  color:
                                                      const Color(0xFFEF4136),
                                                ),
                                                child: Center(
                                                  child: SvgPicture.string(
                                                    // refresh-cw (2)
                                                    '<svg viewBox="1.0 3.0 13.08 10.7" ><path transform="translate(-6.48, -0.4)" d="M 20.56849670410156 4 L 20.56849670410156 7.568496704101562 L 17 7.568496704101562" fill="none" stroke="#ffffff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /><path transform="translate(0.0, -4.46)" d="M 1 17.56849670410156 L 1 14 L 4.568496704101562 14" fill="none" stroke="#ffffff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /><path transform="translate(0.0, 0.0)" d="M 2.492821216583252 6.569385528564453 C 3.105936527252197 4.836767673492432 4.565086841583252 3.539859771728516 6.357674121856689 3.134264469146729 C 8.150260925292969 2.7286696434021 10.02558708190918 3.271110057830811 11.32485198974609 4.571027755737305 L 14.08448791503906 7.164134979248047 M 1 9.543132781982422 L 3.759637355804443 12.13624095916748 C 5.058903217315674 13.43615913391113 6.934228897094727 13.97859859466553 8.726815223693848 13.57300281524658 C 10.51940155029297 13.16740608215332 11.97854995727539 11.87049961090088 12.59166622161865 10.1378812789917" fill="none" stroke="#ffffff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /></svg>',
                                                    width: 13.08,
                                                    height: 10.7,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                      width: 410,
                                      child: CustomTextField(
                                          hint: "Choose a nickname...",
                                          controller: userNameController))
                                ],
                              ),
                            ),
                            ButtonDings(
                              label: "Create Lobby",
                              onPressed: () {
                                if (lobbyTitleController.text != "" &&
                                    userNameController.text != "") {
                                  socketMethods.createRoom(
                                      userNameController.text,
                                      lobbyTitleController.text);
                                  Navigator.pushNamed(context, "/game");
                                } else {
                                  window.alert("Please fill out all fields");
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 30,
                      right: 30,
                      left: 30,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SocialBarBottom()),
                    )
                  ],
                ),
              )),
            )
          ],
        ));
  }
}

class JoinRoom extends StatefulWidget {
  static String routeName = "/joinRoom";
  const JoinRoom({super.key});

  @override
  State<JoinRoom> createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  TextEditingController lobbyCodeController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  SocketMethods socketMethods = SocketMethods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socketMethods.joinRoomSuccessListener(context);
    socketMethods.errorOccuredListener(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF101010),
        body: Stack(
          children: [
            const Positioned(
              left: 50,
              right: 50,
              top: 50,
              child:
                  Align(alignment: Alignment.topCenter, child: PitchDayLogo()),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 150, 50, 150),
              child: Center(
                  child: Container(
                width: 1197.0,
                height: 651.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: const Color(0xFF202020),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 50,
                      right: 50,
                      top: 30,
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: SelectableText(
                            'Join Lobby',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.rubik(
                              fontSize: 33.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                    ),
                    Center(
                      child: SizedBox(
                        height: 365,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextField(
                                hint: "Lobby Code",
                                controller: lobbyCodeController),
                            SizedBox(
                              width: 500,
                              child: Row(
                                children: [
                                  //Character Chooser
                                  SizedBox(
                                    height: 70,
                                    width: 70,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 70.0,
                                          height: 70.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            border: Border.all(
                                              width: 3.0,
                                              color: const Color(0xFFDEDEDE),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: SizedBox(
                                              width: 23.0,
                                              height: 23.0,
                                              child: Container(
                                                width: 23.0,
                                                height: 23.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                  color:
                                                      const Color(0xFFEF4136),
                                                ),
                                                child: Center(
                                                  child: SvgPicture.string(
                                                    // refresh-cw (2)
                                                    '<svg viewBox="1.0 3.0 13.08 10.7" ><path transform="translate(-6.48, -0.4)" d="M 20.56849670410156 4 L 20.56849670410156 7.568496704101562 L 17 7.568496704101562" fill="none" stroke="#ffffff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /><path transform="translate(0.0, -4.46)" d="M 1 17.56849670410156 L 1 14 L 4.568496704101562 14" fill="none" stroke="#ffffff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /><path transform="translate(0.0, 0.0)" d="M 2.492821216583252 6.569385528564453 C 3.105936527252197 4.836767673492432 4.565086841583252 3.539859771728516 6.357674121856689 3.134264469146729 C 8.150260925292969 2.7286696434021 10.02558708190918 3.271110057830811 11.32485198974609 4.571027755737305 L 14.08448791503906 7.164134979248047 M 1 9.543132781982422 L 3.759637355804443 12.13624095916748 C 5.058903217315674 13.43615913391113 6.934228897094727 13.97859859466553 8.726815223693848 13.57300281524658 C 10.51940155029297 13.16740608215332 11.97854995727539 11.87049961090088 12.59166622161865 10.1378812789917" fill="none" stroke="#ffffff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /></svg>',
                                                    width: 13.08,
                                                    height: 10.7,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                      width: 410,
                                      child: CustomTextField(
                                          hint: "Choose a nickname...",
                                          controller: userNameController))
                                ],
                              ),
                            ),
                            ButtonDings(
                              label: "Join Lobby",
                              onPressed: () {
                                if (lobbyCodeController.text != "" &&
                                    userNameController.text != "") {
                                  socketMethods.joinRoom(
                                      userNameController.text,
                                      lobbyCodeController.text);
                                } else {
                                  window.alert("Please fill out all fields");
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 30,
                      right: 30,
                      left: 30,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SocialBarBottom()),
                    )
                  ],
                ),
              )),
            )
          ],
        ));
  }
}

class GameRoom extends StatefulWidget {
  static String routeName = "/game";
  const GameRoom({super.key});

  @override
  State<GameRoom> createState() => _GameRoomState();
}

class _GameRoomState extends State<GameRoom> {
  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    bool isJoinable = roomDataProvider.roomData['isJoinable'];

    return Scaffold(
        backgroundColor: const Color(0xFF101010),
        body: isJoinable
            ? Stack(
                children: [
                  const Positioned(
                    left: 50,
                    right: 50,
                    top: 50,
                    child: Align(
                        alignment: Alignment.topCenter, child: PitchDayLogo()),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 150, 50, 150),
                    child: Center(
                        child: Container(
                      width: 1197.0,
                      height: 651.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: const Color(0xFF202020),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 50,
                            right: 50,
                            top: 30,
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: SelectableText(
                                  roomDataProvider.roomData['title'] ?? "Null",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.rubik(
                                    fontSize: 33.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )),
                          ),
                          Center(
                            child: SizedBox(
                              height: 180,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ButtonDings(
                                      label: "Create Lobby",
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, CreateLobby.routeName);
                                      }),
                                  Text(
                                    'or',
                                    style: GoogleFonts.rubik(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextOnlyButton(label: "Join Lobby")
                                ],
                              ),
                            ),
                          ),
                          const Positioned(
                            bottom: 30,
                            right: 30,
                            left: 30,
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: SocialBarBottom()),
                          )
                        ],
                      ),
                    )),
                  )
                ],
              )
            : const GameScreen());
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
