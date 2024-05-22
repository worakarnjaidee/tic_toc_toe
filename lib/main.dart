import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:tic_toc_toe/tic_toc_toe2.dart';

void main() {
  runApp(TicTacToeApp());
}
/*

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  late List<String> board;
  late String currentPlayer;
  late bool gameOver;
  late String winner;
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    resetGame();
  }

  void resetGame() {
    board = List<String>.filled(9, '');
    currentPlayer = 'X';
    gameOver = false;
    winner = '';
  }

  Future<void> playSound(String sound) async {
    audioPlayer.play(
      AssetSource('audio/$sound.wav'),
    );

  }

  void makeMove(int index) {
    if (board[index] == '' && !gameOver) {
      setState(() {
        board[index] = currentPlayer;
        playSound('move');
        if (checkWinner(currentPlayer)) {
          gameOver = true;
          winner = currentPlayer;
          playSound('win');
        } else if (board.every((element) => element != '')) {
          gameOver = true;
          playSound('draw');
        } else {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  bool checkWinner(String player) {
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (List<int> pattern in winPatterns) {
      if (pattern.every((index) => board[index] == player)) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildBoard(),
            if (gameOver) ...[
              Text(
                winner.isNotEmpty ? 'Player $winner Wins!' : 'It\'s a Draw!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5,),
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    resetGame();
                  });
                },
                child: Text('Play Again'),
              ),
            ],
            if (!gameOver) ...[
              SizedBox(height: 5,),
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    resetGame();
                  });
                },
                child: const Text('Restart Game.'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildBoard() {
    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => makeMove(index),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.all(4),
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
                    color: board[index] == 'X' ? Colors.blue : Colors.red,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
*/
