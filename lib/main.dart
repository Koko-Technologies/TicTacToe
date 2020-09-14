import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/tictac_play.dart';
import 'dart:math' as math;

void main() => runApp(MaterialApp(
      home: TicTacName(),
    ));

class TicTacName extends StatefulWidget {
  @override
  _TicTacNameState createState() => _TicTacNameState();
}

class _TicTacNameState extends State<TicTacName> {
  String player1;
  String player2;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Transform.rotate(
                  angle: math.pi / 4,
                  child: Container(
                    height: 350.0,
                    width: 350.0,
                    padding: const EdgeInsets.all(8.0),
                    color: const Color(0xFFE8581C).withOpacity(0.1),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 60.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 5.0),
                          height: 60.0,
                          width: 60.0,
                          child: Image.asset('images/tictactoe.png'),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          'TIC TAC TOE',
                          style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Player 1\'s name',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      onChanged: (value) {
                        setState(() {
                          player1 = value;
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Player 2\'s name',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      onChanged: (value) {
                        setState(() {
                          player2 = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    FlatButton(
                        color: Colors.deepOrange,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  TicTacPlay(player1, player2)));
                        },
                        child: Text('Continue To Play!')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
