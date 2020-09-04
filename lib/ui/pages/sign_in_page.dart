part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSignInIn = false;
  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToSplashPage());
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 70,
                    child: Image(
                      image: AssetImage('assets/logo.png'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 70, bottom: 40),
                    child: Text(
                      'Welcome Back,\nExplorer!:',
                      style: blackTextFont.copyWith(fontSize: 20),
                    ),
                  ),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isEmailValid = EmailValidator.validate(text);
                      });
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Email Address",
                        hintText: "Email Address"),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 16)),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isPasswordValid = text.length >= 6;
                      });
                    },
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Password",
                        hintText: "Password"),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 6)),
                  Row(
                    children: [
                      Text(
                        'Forgot Password?',
                        style: greyTextFont.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(right: 5)),
                      Text('Get Now', style: purpleTextFont)
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(top: 40, bottom: 30),
                      child: (isSignInIn)
                          ? SpinKitFadingCircle(
                              color: mainColor,
                            )
                          : FloatingActionButton(
                              elevation: 0,
                              child: Icon(
                                Icons.arrow_forward,
                                color: (isEmailValid && isPasswordValid)
                                    ? Colors.white
                                    : Color(0xffbebebe),
                              ),
                              onPressed: (isEmailValid && isPasswordValid)
                                  ? () async {
                                      setState(() {
                                        isSignInIn = true;
                                      });
                                      SignInSignUpResult result =
                                          await AuthServices.signIn(
                                              emailController.text,
                                              passwordController.text);
                                      if (result.user == null) {
                                        setState(() {
                                          isSignInIn = false;
                                        });
                                        Flushbar(
                                          duration: Duration(seconds: 4),
                                          flushbarPosition:
                                              FlushbarPosition.TOP,
                                          backgroundColor: Color(0xffff5c83),
                                          message: result.message,
                                        ).show(context);
                                      }
                                    }
                                  : null,
                              backgroundColor: (isEmailValid && isPasswordValid)
                                  ? mainColor
                                  : Color(0xffe4e4e4)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Start Fresh Now?',
                        style:
                            greyTextFont.copyWith(fontWeight: FontWeight.w400),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Text(
                        'Sign Up',
                        style: purpleTextFont,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
