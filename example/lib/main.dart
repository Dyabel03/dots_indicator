import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smooth Page Indicator Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
      debugShowMaterialGrid: true,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        10,
        (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade300,
              ),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Container(
                height: 280,
                child: Center(
                    child: Text(
                  "Page $index",
                  style: TextStyle(color: Colors.indigo),
                )),
              ),
            ));
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16),
              SizedBox(
                height: 240,
                child: PageView.builder(
                  controller: controller,
                  itemCount: pages.length,
                  itemBuilder: (_, index) {
                    return pages[index];
                  },
                ),
              ),
              //**** */
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 12),
                child: Text(
                  'Expanded',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: Colors.red,
                  //   width: 1,
                  // ),
                  color: Color(0XFF2C2A29),
                ),
                height: 100,
                width: 250,
                child: SmoothPageIndicator(
                  controller: controller,
                  count: pages.length,
                  effect: ExpandingDotsEffect(
                    dotWidth: 8,
                    dotHeight: 8,
                    spacing: 16,
                    expansionFactor: 5.0,
                    activeDotColor: Color(0XFFFDDA24),
                    dotColor: Color(0XFFFFFFFF).withOpacity(.56),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 12),
                child: Text(
                  'Scrolling Dots',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              SmoothPageIndicator(
                controller: controller,
                count: pages.length,
                effect: ScrollingDotsEffect(
                  activeStrokeWidth: 2.6,
                  activeDotScale: 1.3,
                  maxVisibleDots: 5,
                  radius: 8,
                  spacing: 16,
                  dotHeight: 8,
                  dotWidth: 8,
                  fixedCenter: true,
                ),
              ),
              const SizedBox(height: 32.0),
              Container(
                height: 100,
                width: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const SizedBox(width: 16.0),
                    _circle(Colors.red, 4, 4),
                    const SizedBox(width: 16.0),
                    _circle(Colors.red, 8),
                    const SizedBox(width: 16.0),
                    _circle(Colors.red, 8),
                    const SizedBox(width: 16.0),
                    _circle(Colors.red, 40),
                    const SizedBox(width: 16.0),
                    _circle(Colors.red, 8),
                    const SizedBox(width: 16.0),
                    _circle(Colors.red, 8),
                    const SizedBox(width: 16.0),
                    _circle(Colors.red, 4, 4),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circle(Color color, double width, [double height = 8]) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
    );
  }
}

final colors = const [
  Colors.red,
  Colors.green,
  Colors.greenAccent,
  Colors.amberAccent,
  Colors.blue,
  Colors.amber,
];
