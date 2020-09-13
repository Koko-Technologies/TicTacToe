import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TicTacPlay());
  }
}

class TicTacPlay extends StatefulWidget {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                  ? Text('It\'s Player1\'s Turn',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey,
                      ))
                  : Text('It\'s Player2\'s Turn',
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

  // _checkPlayer() {
  //   setState(() {
  //     String player = _lastChar;
  //     if (player == 'X')
  //       thePlayer = 'Player 1\'s turn';
  //     else
  //       thePlayer = 'Player 2\'s turn';
  //   });
  // }

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
    } else {
      dialogText = 'Player $winner won';
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
                  Navigator.pop(context);
                  setState(() {
                    _initMatrix();
                  });
                },
              )
            ],
          );
        });
  }

  _enterNamesDialog() {
    return Container(
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Player 1\'s name',
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelStyle: TextStyle(fontSize: 20.0),
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
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelStyle: TextStyle(fontSize: 20.0),
            ),
            onChanged: (value) {
              player2 = value;
            },
          ),
        ],
      ),
    );
  }
}
// actions: <Widget>[
//   FlatButton(
//     child: Text('Continue'),
//     onPressed: () {
//       Navigator.pop(context);
//       setState(() {
//         _initMatrix();
//       });
//     },
//   )
// ],
