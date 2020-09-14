import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/main.dart';

class TicTacPlay extends StatefulWidget {
  TicTacPlay(this.player1, this.player2);
  final player1;
  final player2;

  @override
  State<StatefulWidget> createState() {
    return _TicTacPlayState();
  }
}

class _TicTacPlayState extends State<TicTacPlay> {
  List<List> _matrix;
  String _lastChar = 'O';
  String player1;
  String player2;
  bool play = false;

  _initMatrix() {
    _matrix = List<List>(3);
    for (var i = 0; i < _matrix.length; i++) {
      _matrix[i] = List(3);
      for (var j = 0; j < _matrix[i].length; j++) {
        _matrix[i][j] = ' ';
      }
    }
  }

  setNames(String first, String second) {
    if (first == null && second == null) {
      player1 = 'X';
      player2 = 'O';
    } else if (first == null) {
      player1 = 'X';
      player2 = second;
    } else if (second == null) {
      player2 = 'X';
      player1 = first;
    } else {
      player1 = first;
      player2 = second;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setNames(widget.player1, widget.player2);
    _initMatrix();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tic tac toe'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              play == false
                  ? Text('It\'s $player1\'s Turn',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey,
                      ))
                  : Text('It\'s $player2\'s Turn',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey,
                      )),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildElement(0, 0),
                  _buildElement(0, 1),
                  _buildElement(0, 2),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildElement(1, 0),
                  _buildElement(1, 1),
                  _buildElement(1, 2),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildElement(2, 0),
                  _buildElement(2, 1),
                  _buildElement(2, 2),
                ],
              ),
            ],
          ),
        ));
  }

  _buildElement(int i, int j) {
    return GestureDetector(
      onTap: () {
        _changeMatrixField(i, j);
        play = !play;
        print(_matrix.length);
        if (_checkWinner(i, j)) {
          _showDialog(_matrix[i][j]);
        } else {
          if (_checkDraw()) {
            _showDialog(null);
          }
        }
      },
      child: Container(
        width: 90.0,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle, border: Border.all(color: Colors.black)),
        child: Center(
          child: Text(
            _matrix[i][j],
            style: TextStyle(fontSize: 92.0),
          ),
        ),
      ),
    );
  }

  _changeMatrixField(int i, int j) {
    setState(() {
      if (_matrix[i][j] == ' ') {
        if (_lastChar == 'O')
          _matrix[i][j] = 'X';
        else
          _matrix[i][j] = 'O';

        _lastChar = _matrix[i][j];
      }
    });
  }

  _checkDraw() {
    var draw = true;
    _matrix.forEach((i) {
      i.forEach((j) {
        if (j == ' ') draw = false;
      });
    });
    return draw;
  }

  _checkWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    var n = _matrix.length - 1;
    var player = _matrix[x][y];

    for (int i = 0; i < _matrix.length; i++) {
      if (_matrix[x][i] == player) col++;
      if (_matrix[i][y] == player) row++;
      if (_matrix[i][i] == player) diag++;
      if (_matrix[i][n - i] == player) rdiag++;
    }
    if (row == n + 1 || col == n + 1 || diag == n + 1 || rdiag == n + 1) {
      return true;
    }
    return false;
  }

  _showDialog(String winner) {
    String dialogText;
    if (winner == null) {
      dialogText = 'It\'s a draw';
    } else if (winner == 'X') {
      dialogText = 'Player $player1 won!';
    } else {
      dialogText = 'Player $player2 won!';
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Game over'),
            content: Text(dialogText),
            actions: <Widget>[
              FlatButton(
                child: Text('Reset Game'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TicTacName()));
                  setState(() {
                    _initMatrix();
                  });
                },
              )
            ],
          );
        });
  }
}
