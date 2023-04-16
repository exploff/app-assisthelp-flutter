import 'package:app_assisthelp/page/signin.page.dart';
import 'package:app_assisthelp/repository/auth.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroPage extends StatefulWidget {
  final AuthRepository authRepository;

  const IntroPage({super.key, required this.authRepository});

  @override
  State<IntroPage> createState() => _IntroPageState(authRepository);
}

class _IntroPageState extends State<IntroPage> {

  final AuthRepository authRepository;

  _IntroPageState(this.authRepository);

  bool clicked = false;

  void afterIntroComplete () {
    setState(() {
      clicked = true;
    });
  }

  final List<PageViewModel> pages = [
    PageViewModel(
      titleWidget: 
        Column(
          children: [
            const Text('Free GIHT'),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              width: 100.0,
              height: 3.0,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10.0)
              ),
            )
          ],
        ),
        body: "Free gifrs with pruchase offer free gifts like a fift....",
        image: Center(
          child: SvgPicture.asset('assets/icons/de.svg')
        )
    ),
     PageViewModel(
      titleWidget: 
        Column(
          children: [
            const Text('Free GIHT'),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              width: 100.0,
              height: 3.0,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10.0)
              ),
            )
          ],
        ),
        body: "Bili babobo.",
        image: Center(
          child: SvgPicture.asset('assets/icons/de.svg')
        )
    )
  ];


  @override
  Widget build(BuildContext context) {
    return clicked ? SignIn(authRepository: authRepository,) : IntroductionScreen(
      pages: pages,
      onDone: () {
        afterIntroComplete();
      },
      onSkip: () {
        afterIntroComplete();
      },
      showSkipButton: true,
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.bold),),
      next: const Icon(Icons.navigate_next),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.bold)),
      dotsDecorator: DotsDecorator(
        size: const Size.square(7.0),
        activeSize: const Size(20.0, 5.0),
        activeColor: Colors.amber,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(
          horizontal: 3.0
        ),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        )
      )
    );
  }
}