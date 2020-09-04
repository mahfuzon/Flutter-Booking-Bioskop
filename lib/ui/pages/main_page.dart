part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: accentColor1,
          ),
          SafeArea(
            child: Container(
              color: Color(0xfff6f7f9),
            ),
          ),
          ListView(),
          createCustomBottomNavbar(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 46,
              width: 46,
              margin: EdgeInsets.only(bottom: 42),
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: accentColor2,
                onPressed: () {},
                child: SizedBox(
                    height: 26,
                    width: 26,
                    child: Icon(
                      MdiIcons.walletPlus,
                      color: Colors.black.withOpacity(0.42),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget createCustomBottomNavbar() => Align(
        alignment: Alignment.bottomCenter,
        child: ClipPath(
          clipper: ButtonNavBarClipper(),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: accentColor1,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
        ),
      );
}

class ButtonNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width / 2 - 28, 0);
    path.quadraticBezierTo(size.width / 2 - 28, 33, size.width / 2, 33);
    path.quadraticBezierTo(size.width / 2 + 28, 33, size.width / 2 + 28, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
