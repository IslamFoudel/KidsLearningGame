// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static final ROUTE = '/Home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var player = AudioPlayer();
  Map<String, bool> score = {};
  Map<String, Color> choices = {
    '🍎': Colors.red,
    '📗': Colors.green,
    '👖': Colors.blue,
    '🍋': Colors.yellow,
    '🍊': Colors.orange,
    '🍇': Colors.purple,
    '🐒': Colors.brown,
  };
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Score: ${score.length}/7'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: choices.keys.map((element) {
              return Expanded(
                child: Draggable<String>(
                  data: element,
                  child: Movable(score[element] == true ? '🎓' : element),
                  feedback: Text(
                    element,
                    style: TextStyle(fontSize: 75),
                  ),
                  childWhenDragging: Movable('🐰'),
                ),
              );
            }).toList(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: choices.keys.map((element) {
              return buildTarget(element);
            }).toList()
              ..shuffle(Random(index)),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 75,
        height: 75,
        child: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          child: Icon(
            Icons.refresh,
            size: 50,
          ),
          onPressed: () {
            setState(() {
              score.clear();
              index++;
            });
          },
        ),
      ),
    );
  }

  Widget buildTarget(String element) {
    return DragTarget<String>(
      builder: (context, incoming, rejected) {
        if (score[element] == true) {
          return Container(
            color: Colors.white,
            child: Center(
                child: Text(
              'Congratulations!',
              style: Theme.of(context).textTheme.bodyLarge,
            )),
            alignment: Alignment.center,
            height: 80,
            width: 200,
          );
        } else {
          return Container(
            color: choices[element],
            height: 80,
            width: 200,
          );
        }
      },
      // Use details.data instead of just data
      onWillAcceptWithDetails: (details) {
        return details.data == element;
      },
      onAcceptWithDetails: (details) {
        setState(() {
          score[element] = true;
          //player.setSource(AssetSource('ambient_c_motion.mp3'));
          player.play(AssetSource('sounds/clap.mp3'));
        });
      },
      onLeave: (data) {},
    );
  }
}

class Movable extends StatelessWidget {
  final String emoji;
  Movable(this.emoji);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 75,
        padding: EdgeInsets.all(10),
        child: Text(
          emoji,
          style: TextStyle(color: Colors.black, fontSize: 50),
        ),
      ),
    );
  }
}
