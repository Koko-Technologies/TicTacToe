import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/tictac_play.dart';

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
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TicTacPlay(player1, player2)));
                    },
                    child: Text('Continue To Play!')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
