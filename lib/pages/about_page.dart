import 'package:flutter/material.dart';
import 'package:project/utils/colors.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
  late final AnimationController _bigCloudController = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
  )..repeat(reverse: true);

  late final AnimationController _smallCloudController = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
  )..repeat(reverse: true);

  @override
  void dispose() {
    _bigCloudController.dispose();
    _smallCloudController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.info),
          const SizedBox(width: 5),
          Text("ABOUT", style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
      backgroundColor: AppColors.primaryOrange,
      foregroundColor: AppColors.white,
      elevation: 0,
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: AppColors.backgroundOffWhite,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final Size biggest = constraints.biggest;
          return Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned(
                top: 50,
                left: 30,
                child: Text(
                  "Weather App",
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.left,
                ),
              ),
              Positioned(
                top: 130,
                left: 30,
                width: 313,
                child: Text(
                  "This is an app that is developed for the course 1DV535 at Linneaus University using Flutter and the OpenWeatherMap API.",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.left,
                ),
              ),
              Positioned(
                top: 295,
                left: 30,
                child: Text(
                  "Developed by Pauline Wiman",
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.left,
                ),
              ),
              PositionedTransition(
                rect: RelativeRectTween(
                  begin: RelativeRect.fromSize(
                    const Rect.fromLTWH(-60, 340, 346, 252),
                    biggest,
                  ),
                  end: RelativeRect.fromSize(
                    const Rect.fromLTWH(-40, 340, 346, 252),
                    biggest,
                  ),
                ).animate(CurvedAnimation(
                  parent: _bigCloudController,
                  curve: Curves.easeOut,
                )),
                child: Image.asset("images/tealcloud.png"),
              ),
              PositionedTransition(
                rect: RelativeRectTween(
                  begin: RelativeRect.fromSize(
                    const Rect.fromLTWH(240, 280, 200, 138),
                    biggest,
                  ),
                  end: RelativeRect.fromSize(
                    const Rect.fromLTWH(260, 280, 200, 138),
                    biggest,
                  ),
                ).animate(CurvedAnimation(
                  parent: _smallCloudController,
                  curve: Curves.easeIn,
                )),
                child: Image.asset("images/lightbluecloud.png"),
              ),
            ],
          );
        },
      ),
    );
  }
}
