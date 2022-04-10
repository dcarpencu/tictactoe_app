import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool greenTurn = true;
  bool isWinner = false;
  List<Color> displayElement = [
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent
  ];
  int displayedColorIndex1 = 0;
  int displayedColorIndex2 = 0;
  int displayedColorIndex3 = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'tic-tac-toe',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: Column(
        children: [
          GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (greenTurn && displayElement[index] == Colors.transparent) {
                        displayElement[index] = Colors.green;
                        filledBoxes++;
                      } else if (!greenTurn && displayElement[index] == Colors.transparent) {
                        displayElement[index] = Colors.red;
                        filledBoxes++;
                      }

                      greenTurn = !greenTurn;
                      _checkWinner();
                    });
                  },
                  child: AnimatedContainer(
                    decoration: BoxDecoration(
                        color: displayElement[index], border: Border.all(color: Colors.black, width: 0.3)),
                    duration: const Duration(milliseconds: 300),
                  ),
                );
              }),
          if (isWinner || filledBoxes == 9)
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white54,
                  onPrimary: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    for (int i = 0; i < 9; i++) {
                      displayElement[i] = Colors.transparent;
                    }
                  });
                  isWinner = false;
                },
                child: const Text('Play again!'))
        ],
      ),
    );
  }

  void _changeColorForReset() {
    for (int i = 0; i < 9; i++) {
      if (displayElement[i] == displayElement[displayedColorIndex1] &&
          !(i == displayedColorIndex1 || i == displayedColorIndex2 || i == displayedColorIndex3)) {
        displayElement[i] = Colors.transparent;
      }
      if (displayElement[i] != displayElement[displayedColorIndex1]) {
        displayElement[i] = Colors.transparent;
      }
    }
    filledBoxes = 0;
  }

  void _checkWinner() {
    // Checking rows
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != Colors.transparent) {
      displayedColorIndex1 = 0;
      displayedColorIndex2 = 1;
      displayedColorIndex3 = 2;
      isWinner = true;
    } else if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != Colors.transparent) {
      displayedColorIndex1 = 3;
      displayedColorIndex2 = 4;
      displayedColorIndex3 = 5;
      isWinner = true;
    } else if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != Colors.transparent) {
      displayedColorIndex1 = 6;
      displayedColorIndex2 = 7;
      displayedColorIndex3 = 8;
      isWinner = true;
    }

    // Checking Column
    else if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != Colors.transparent) {
      displayedColorIndex1 = 0;
      displayedColorIndex2 = 3;
      displayedColorIndex3 = 6;
      isWinner = true;
    } else if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != Colors.transparent) {
      displayedColorIndex1 = 1;
      displayedColorIndex2 = 4;
      displayedColorIndex3 = 7;
      isWinner = true;
    } else if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != Colors.transparent) {
      displayedColorIndex1 = 2;
      displayedColorIndex2 = 5;
      displayedColorIndex3 = 8;
      isWinner = true;
    }

    // Checking Diagonal
    else if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != Colors.transparent) {
      displayedColorIndex1 = 0;
      displayedColorIndex2 = 4;
      displayedColorIndex3 = 8;
      isWinner = true;
    } else if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != Colors.transparent) {
      displayedColorIndex1 = 2;
      displayedColorIndex2 = 4;
      displayedColorIndex3 = 6;
      isWinner = true;
    } else if (filledBoxes == 9) {
      isWinner = true;
    }

    if (isWinner && filledBoxes != 9) {
      _changeColorForReset();
    }
  }
}
