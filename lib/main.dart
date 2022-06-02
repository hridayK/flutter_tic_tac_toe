import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  bool xTurn = true;

  String playerName(){
    if(xTurn)
      return "X";
    else
      return "O";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(0,80,0,0),
              color: Colors.grey[800],
              child: Text(
                "Player: " + playerName(),
                style: TextStyle(color: Colors.white, fontSize: 44),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _tapped(index);
                  },
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Center(
                      child: Text(
                        displayXO[index],
                        style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (xTurn) {
        displayXO[index] = "X";
      } else {
        displayXO[index] = "O";
      }
    });
    xTurn = !xTurn;
    _checkwinner();
  }

  void _checkwinner() {
    //diagonals
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      _showDialog(displayXO[0]);
    }

    if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != '') {
      _showDialog(displayXO[2]);
    }

    //horizontal
    for (int i = 2; i < 9; i += 3) {
      if (displayXO[i] == displayXO[i - 1] &&
          displayXO[i] == displayXO[i - 2] &&
          displayXO[i] != '') {
        _showDialog(displayXO[i]);
        break;
      }
    }

    //vertical
    for (int i = 0; i < 2; i++) {
      if (displayXO[i] == displayXO[i + 3] &&
          displayXO[i] == displayXO[i + 6] &&
          displayXO[i] != '') {
        _showDialog(displayXO[i]);
        break;
      }
    }
  }

  void _showDialog(String winnerName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Game Over'),
        );
      },
    );
  }
}
