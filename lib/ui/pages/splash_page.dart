part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 136,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/logo.png')),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 70, bottom: 16),
              child: Text(
                'New Experience',
                style: blackTextFont.copyWith(fontSize: 20),
              ),
            ),
            Text(
              'Watch a new movie much\nesier than any before',
              style: greyTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
            //  BUTTON GET STARTED
            Container(
              width: 250,
              height: 46,
              margin: EdgeInsets.only(top: 76, bottom: 19),
              child: RaisedButton(
                color: mainColor,
                onPressed: () {
                  context
                      .bloc<PageBloc>()
                      .add(GoToRegistrationPage(RegistrationData()));
                },
                child: Text('Get Started',
                    style: whitekTextFont.copyWith(fontSize: 16)),
              ),
            ),
            // AKHIR BUTTON GET STARTED
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: greyTextFont.copyWith(fontWeight: FontWeight.w400),
                ),
                // LINK SIGN IN
                GestureDetector(
                  onTap: () {
                    context.bloc<PageBloc>().add(GoToLoginPage());
                  },
                  child: Text(
                    'Sign In',
                    style: purpleTextFont,
                  ),
                ),
                // AKHIR LINK SIGN IN
              ],
            ),
          ],
        ),
      ),
    );
  }
}
