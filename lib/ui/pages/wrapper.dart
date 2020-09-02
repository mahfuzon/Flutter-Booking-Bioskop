part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);
    if (firebaseUser == null) {
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.bloc<PageBloc>().add(GoToSplashPage());
      }
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
        prevPageEvent = GoToMainPage();
        context.bloc<PageBloc>().add(GoToMainPage());
      }
    }

    return BlocBuilder<PageBloc, PageState>(builder: (_, pageState) {
      if (pageState is OnSplashPage) {
        return SplashPage();
      } else if (pageState is OnLoginlPage) {
        return SignInPage();
      } else {
        return MainPage();
      }
    });
  }
}
