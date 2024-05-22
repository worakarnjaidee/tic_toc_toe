import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic-Tac-Toe 18+',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> with SingleTickerProviderStateMixin {
  late List<String> board;
  late String currentPlayer;
  late bool gameOver;
  late String winner;
  late AudioPlayer audioPlayer;
  late  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    resetGame();
  }

  void resetGame() {
    setState(() {
      board = List<String>.filled(9, '');
      currentPlayer = 'X';
      gameOver = false;
      winner = '';
    });
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
          playSound('winner');
        } else if (board.every((element) => element != '')) {
          gameOver = true;
          playSound('draw');
        } else {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        }
        _controller.forward(from: 0);
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
        centerTitle: true,
        title: Text('Tic-Tac-Toe', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.black,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildBoard(),
            if (gameOver) ...[
              SizedBox(height: 10,),
              Text(
                winner.isNotEmpty ? 'Player $winner Wins!' : 'It\'s a Draw!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: resetGame,
                child: Text('Play Again'),
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
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: Offset(0, 0),
                  ),
                  BoxShadow(
                    color: Colors.redAccent.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Center(
                child: NeonText(
                  text: board[index],
                  color: board[index] == 'X' ? Colors.blueAccent : Colors.redAccent,
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
    _controller.dispose();
    audioPlayer.dispose();
    super.dispose();
  }
}

class NeonText extends StatelessWidget {
  final String text;
  final Color color;

  NeonText({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 80,
        fontWeight: FontWeight.bold,
        color: color,
        shadows: [
          Shadow(
            blurRadius: 10.0,
            color: color,
            offset: Offset(0, 0),
          ),
          Shadow(
            blurRadius: 20.0,
            color: color,
            offset: Offset(0, 0),
          ),
          Shadow(
            blurRadius: 30.0,
            color: color,
            offset: Offset(0, 0),
          ),
        ],
      ),
    );
  }
}
