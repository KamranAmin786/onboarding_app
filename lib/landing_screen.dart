import 'package:flutter/material.dart';
import 'package:landing_screen/home_screen.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  double buttonOffset = 0;
  bool isAnimating = false;
  Offset imageOffset = Offset.zero;
  String textTitle = 'Deliver';

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isAnimating = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width - 80;
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Column(
        children: [
          const Spacer(),
          AnimatedOpacity(
            curve: Curves.easeInToLinear,
            opacity: isAnimating ? 1 : 0,
            duration: const Duration(seconds: 1),
            child: Text(
              textTitle,
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
           Center(
            child: AnimatedOpacity(
              curve: Curves.easeInToLinear,
              opacity: isAnimating ? 1 : 0,
              duration: const Duration(seconds: 1),
              child: const Text(
                "Deliver & Delight: Your World, Your Order, Your Way",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Spacer(),
          AnimatedOpacity(
            curve: Curves.easeInToLinear,
            opacity: isAnimating ? 1 : 0,
            duration: const Duration(milliseconds: 500),
            child: Transform(
              transform: Matrix4.translationValues(
                imageOffset.dx,
                0, // Only move horizontally, no vertical movement
                0,
              )..rotateZ((imageOffset.dx / 20) * 3.14 / 180),
              child: GestureDetector(
                onPanUpdate: (details) {
                  // Adjust the maximum horizontal movement range (150 pixels)
                  if (imageOffset.dx.abs() <= 120) {
                    setState(() {
                      imageOffset = Offset(
                        imageOffset.dx + details.delta.dx, // Adjust the X position
                        0, // No change in the Y position
                      );
                      textTitle = 'Order';
                    });
                  }
                },
                onPanEnd: (_) {
                  setState(() {
                    imageOffset = Offset.zero;
                    textTitle = 'Deliver';
                  });
                },
                child: SizedBox(
                  width: 350,
                  height: 350,
                  child: Image.asset(
                    'assets/character-1.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onPanUpdate: (details) {
              if (details.delta.dx > 0 && buttonOffset <= buttonWidth - 80) {
                setState(() {
                  buttonOffset += details.delta.dx;
                });
              }
            },
            onPanEnd: (_) {
              if (buttonOffset > buttonWidth / 2) {
                setState(() {
                  buttonOffset = buttonWidth - 80;
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeView()));
              } else {
                setState(() {
                  buttonOffset = 0;
                });
              }
            },
            child: AnimatedOpacity(
              curve: Curves.easeInToLinear,
              opacity: isAnimating ? 1 : 0,
              duration: const Duration(seconds: 1),
              child: Container(
                width: buttonWidth,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: buttonOffset + 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.red.shade200,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 80,
                          height: 70,
                          decoration:  const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.chevron_right,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
