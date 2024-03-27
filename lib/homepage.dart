import 'dart:async';

import 'package:flappybird/barriers.dart';
import 'package:flappybird/bird.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static double birdYAxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYAxis;
  bool gameHasStarted = false;
  // double barrierXTwo = 1;
  static double barrierXOne = 1;

  double barrierXTwo = barrierXOne + 1.5;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYAxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYAxis = initialHeight - height;
        barrierXOne += 0.05;
        barrierXTwo += 0.05;
      });

      setState(() {
        if (barrierXOne < 1.1) {
          barrierXOne += 2.2;
        } else {
          barrierXOne -= 0.05;
        }
      });

      setState(() {
        if (barrierXTwo < 1.1) {
          barrierXTwo += 2.2;
        } else {
          barrierXTwo -= 0.05;
        }
      });

      if (birdYAxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (gameHasStarted) {
                          jump();
                        } else {
                          startGame();
                        }
                      },
                      child: AnimatedContainer(
                        alignment: Alignment(0, birdYAxis),
                        color: Colors.blue,
                        duration: const Duration(milliseconds: 0),
                        child: const MyBird(),
                      ),
                    ),
                    Container(
                      alignment: const Alignment(0, -0.3),
                      child: gameHasStarted
                          ? const Text('')
                          : const Text(
                              'T A P  T O  P L A Y',
                              style: TextStyle(fontSize: 20),
                            ),
                    ),
                    AnimatedContainer(
                        alignment: Alignment(barrierXOne, 1.1),
                        duration: Duration(milliseconds: 0),
                        child: MyBarrier(size: 200.0)),
                    AnimatedContainer(
                        alignment: Alignment(barrierXOne, -1.1),
                        duration: Duration(milliseconds: 0),
                        child: MyBarrier(size: 200.0)),
                    AnimatedContainer(
                        alignment: Alignment(barrierXTwo, 1.1),
                        duration: Duration(milliseconds: 0),
                        child: MyBarrier(size: 150.0)),
                    AnimatedContainer(
                        alignment: Alignment(barrierXTwo, -1.1),
                        duration: Duration(milliseconds: 0),
                        child: MyBarrier(size: 250.0)),
                  ],
                )),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
                child: Container(
              color: Colors.brown,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Score',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('0',
                          style: TextStyle(color: Colors.white, fontSize: 20))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Best',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('0',
                          style: TextStyle(color: Colors.white, fontSize: 20))
                    ],
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
