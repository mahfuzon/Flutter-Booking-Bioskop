part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomNavbarIndex;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    bottomNavbarIndex = 0;
    pageController = PageController(initialPage: bottomNavbarIndex);
  }

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
          PageView(
            onPageChanged: (index) {
              setState(() {
                bottomNavbarIndex = index;
              });
            },
            controller: pageController,
            children: [
              MoviePage(),
              Center(
                child: Text('MyTickets'),
              )
            ],
          ),
          createCustomBottomNavbar(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 46,
              width: 46,
              margin: EdgeInsets.only(bottom: 42),
              // TOP UP WALLET
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: accentColor2,
                onPressed: () {
                  context.bloc<UserBloc>().add(SignOut());
                  AuthServices.signOut();
                },
                child: SizedBox(
                    height: 26,
                    width: 26,
                    child: Icon(
                      MdiIcons.walletPlus,
                      color: Colors.black.withOpacity(0.42),
                    )),
              ),
              // AKHIR TOP UP WALLET
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
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: BottomNavigationBar(
              onTap: (index) {
                setState(() {
                  bottomNavbarIndex = index;
                  pageController.jumpToPage(index);
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 6),
                    height: 20,
                    child: Image.asset((bottomNavbarIndex == 0)
                        ? "assets/ic_movie.png"
                        : "assets/ic_movie_grey.png"),
                  ),
                  title: Text(
                    'New Movies',
                    style: GoogleFonts.raleway(
                        fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Container(
                      margin: EdgeInsets.only(bottom: 6),
                      height: 20,
                      child: Image.asset((bottomNavbarIndex == 1)
                          ? "assets/ic_tickets.png"
                          : "assets/ic_tickets_grey.png")),
                  title: Text('MyTickets',
                      style: GoogleFonts.raleway(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ],
              elevation: 0,
              backgroundColor: Colors.transparent,
              selectedItemColor: accentColor1,
              unselectedItemColor: Color(0xffe5e5e5),
              currentIndex: bottomNavbarIndex,
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
