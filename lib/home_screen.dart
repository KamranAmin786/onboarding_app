import 'package:flutter/material.dart';
import 'package:landing_screen/circles.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  bool isOnboardingViewActive = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.5;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                const ConcentricCircles(),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _controller.value * -60),
                      // Adjust the amplitude as needed
                      child: Image.asset(
                        "assets/character-2.png",
                        width: 200,
                        height: 200,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 40,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "It's not just the packages we deliver, but the care we put into every delivery.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView.builder(
                  itemCount: onboardingLines.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading:
                          const Icon(Icons.check_circle, color: Colors.teal),
                      title: Text(
                        onboardingLines[index],
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              width: buttonWidth,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Center(
                child: Text(
                  "Order Now",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  final List<String> onboardingLines = [
    "Experience Speedy Deliveries: From Your Door to Anywhere in Minutes.",
    "Shop, Order, Relax: Let Us Handle the Heavy Lifting.",
    "Track Your Deliveries in Real-Time: Know Exactly When to Expect Your Package.",
    "A World of Choices at Your Fingertips: Explore Restaurants, Stores, and More.",
    "Secure and Contactless: Your Safety, Our Priority.",
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
