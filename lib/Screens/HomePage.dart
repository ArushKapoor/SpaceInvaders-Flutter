import 'package:flutter/material.dart';
import 'package:space_invaders/Utilities/GamePieces.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GamePieces game = GamePieces();

  Color color;

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
                  Text(
                    'Play',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Left',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Up',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Right',
                    style: TextStyle(color: Colors.white),
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
