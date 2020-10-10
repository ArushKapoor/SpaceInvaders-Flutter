import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int alienStartPos = 50;
  List<int> alienPosition = [
    alienStartPos,
    alienStartPos + 1,
    alienStartPos + 2,
    alienStartPos + 3,
    alienStartPos + 4,
    alienStartPos + 5,
    alienStartPos + 6,
    alienStartPos - 20,
    alienStartPos - 20 + 1,
    alienStartPos - 20 + 2,
    alienStartPos - 20 + 3,
    alienStartPos - 20 + 4,
    alienStartPos - 20 + 5,
    alienStartPos - 20 + 6,
  ];

  static int playerStartPos = 489;
  List<int> playerPosition = [
    playerStartPos,
    playerStartPos + 1,
    playerStartPos + 2,
    playerStartPos + 3,
    playerStartPos + 20,
    playerStartPos + 20 + 1,
    playerStartPos + 20 + 2,
    playerStartPos + 20 + 3,
  ];

  static int shieldStartPos = 382;
  List<int> shieldPosition = [
    shieldStartPos,
    shieldStartPos + 1,
    shieldStartPos + 2,
    shieldStartPos + 3,
    shieldStartPos + 20,
    shieldStartPos + 20 + 1,
    shieldStartPos + 20 + 2,
    shieldStartPos + 20 + 3,
    shieldStartPos + 6,
    shieldStartPos + 7,
    shieldStartPos + 8,
    shieldStartPos + 9,
    shieldStartPos + 20 + 6,
    shieldStartPos + 20 + 7,
    shieldStartPos + 20 + 8,
    shieldStartPos + 20 + 9,
    shieldStartPos + 12,
    shieldStartPos + 13,
    shieldStartPos + 14,
    shieldStartPos + 15,
    shieldStartPos + 20 + 12,
    shieldStartPos + 20 + 13,
    shieldStartPos + 20 + 14,
    shieldStartPos + 20 + 15
  ];

  Color color;

  bool isGoingLeft = true;
  bool toMoveLeft = false;
  bool toMoveRight = false;
  bool toFire = false;

  int alienFirePos;
  int playerFirePos;
  bool nextFireReady = true;

  void updateGame() {
    setState(() {
      if (isGoingLeft) {
        for (int i = 0; i < alienPosition.length; i++) {
          alienPosition[i] -= 1;
        }
      } else {
        for (int i = 0; i < alienPosition.length; i++) {
          alienPosition[i] += 1;
        }
      }
      if (alienPosition[0] % 20 == 0) {
        isGoingLeft = false;
      } else if ((alienPosition.last + 1) % 20 == 0) {
        isGoingLeft = true;
      }
    });
  }

  void alienFire() {
    setState(() {
      alienFirePos += 20;
      if (alienFirePos > 540) {
        alienFirePos = alienPosition[0];
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (playerPosition[0] % 20 != 0) {
        for (int i = 0; i < playerPosition.length; i++) {
          playerPosition[i] -= 1;
        }
      }
    });
  }

  void moveRight() {
    setState(() {
      if ((playerPosition.last + 1) % 20 != 0) {
        for (int i = 0; i < playerPosition.length; i++) {
          playerPosition[i] += 1;
        }
      }
    });
  }

  void fire() {
    if (nextFireReady) {
      nextFireReady = false;
      playerFirePos = playerPosition[0];
      const duration = const Duration(milliseconds: 150);
      Timer.periodic(duration, (Timer timer) {
        setState(() {
          if (playerFirePos >= 0) {
            playerFirePos -= 20;
          }
          if (playerFirePos < 0) {
            nextFireReady = true;
            timer.cancel();
          }
        });
      });
    }
  }

  void startGame() {
    const duration = const Duration(milliseconds: 700);
    const fireDuration = const Duration(milliseconds: 200);
    alienFirePos = alienPosition[0];

    Timer.periodic(fireDuration, (Timer timer) {
      alienFire();
    });

    Timer.periodic(duration, (Timer timer) {
      updateGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    // print(MediaQuery.of(context).devicePixelRatio);
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                  itemCount: 540,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 20),
                  itemBuilder: (BuildContext context, int index) {
                    if (alienPosition.contains(index) ||
                        alienFirePos == index) {
                      color = Colors.green;
                    } else if (playerPosition.contains(index) ||
                        shieldPosition.contains(index)) {
                      if (playerPosition[0] == index) {
                        color = Colors.red;
                      } else {
                        color = Colors.white;
                      }
                    } else {
                      color = Colors.grey[900];
                    }
                    if (playerFirePos == index) {
                      color = Colors.red;
                    }
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3.5)),
                          color: color,
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: _height * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: startGame,
                    child: Text(
                      'Play',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: moveLeft,
                    child: Text(
                      'Left',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: fire,
                    child: Text(
                      'Up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: moveRight,
                    child: Text(
                      'Right',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
