import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeGame());
}

class TicTacToeGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> board = List.generate(9, (index) => '');
  bool isXTurn = true; // X starts the game
  String result = '';
  bool gameOver = false;

  void resetGame() {
    setState(() {
      board = List.generate(9, (index) => '');
      isXTurn = true;
      result = '';
      gameOver = false;
    });
  }

  void handleTap(int index) {
    if (board[index] == '' && !gameOver) {
      setState(() {
        board[index] = isXTurn ? 'X' : 'O';
        isXTurn = !isXTurn;
        checkWinner();
      });
    }
  }

  void checkWinner() {
    const winConditions = [
      [0, 1, 2], // row 1
      [3, 4, 5], // row 2
      [6, 7, 8], // row 3
      [0, 3, 6], // column 1
      [1, 4, 7], // column 2
      [2, 5, 8], // column 3
      [0, 4, 8], // diagonal 1
      [2, 4, 6], // diagonal 2
    ];

    for (var condition in winConditions) {
      String line =
          board[condition[0]] + board[condition[1]] + board[condition[2]];

      if (line == 'XXX') {
        result = 'X Wins!';
        gameOver = true;
        return;
      } else if (line == 'OOO') {
        result = 'O Wins!';
        gameOver = true;
        return;
      }
    }

    if (!board.contains('')) {
      result = 'Draw!';
      gameOver = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tic Tac Toe"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => handleTap(index),
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color:
                              board[index] == 'X' ? Colors.red : Colors.green,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Text(
            result,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: resetGame,
            child: Text('Restart Game'),
          ),
        ],
      ),
    );
  }
}
