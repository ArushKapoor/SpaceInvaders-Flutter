import 'dart:async';

import 'package:flutter/material.dart';
import 'package:space_invaders/Utilities/GamePieces.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GamePieces game = new GamePieces();

  Color color;

  bool isGoingLeft = true;
  bool toMoveLeft = false;
  bool toMoveRight = false;
  bool toFire = false;

  void updateGame() {
    setState(() {
      game = new GamePieces();

      if (isGoingLeft) {
        GamePieces.alienStartPos -= 1;
      } else {
        GamePieces.alienStartPos += 1;
      }
      if ((game.alienPosition[0] - 1) % 20 == 0) {
        isGoingLeft = false;
      } else if ((game.alienPosition.last + 2) % 20 == 0) {
        isGoingLeft = true;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (game.playerPosition[0] % 20 != 0) {
        GamePieces.playerStartPos -= 1;
      }
    });
  }

  void moveRight() {
    setState(() {
      if ((game.playerPosition.last + 1) % 20 != 0) {
        GamePieces.playerStartPos += 1;
      }
    });
  }

  void startGame() {
    const duration = const Duration(milliseconds: 700);
    Timer.periodic(duration, (Timer timer) {
      updateGame();
      if (toMoveLeft) {
        moveLeft();
        toMoveLeft = false;
      }
      if (toMoveRight) {
        moveRight();
        toMoveRight = false;
      }
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
                    if (game.alienPosition.contains(index)) {
                      color = Colors.green;
                    } else if (game.playerPosition.contains(index) ||
                        game.shieldPosition.contains(index)) {
                      if (game.playerPosition[0] == index) {
                        color = Colors.red;
                      } else {
                        color = Colors.white;
                      }
                    } else {
                      color = Colors.grey[900];
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
                    onTap: () {
                      toMoveLeft = true;
                    },
                    child: Text(
                      'Left',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Text(
                    'Up',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      toMoveRight = true;
                    },
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
