part of "pages.dart";

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;
  SignUpPage(this.registrationData);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: Colors.grey)));
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSplashPage());
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              // PANAH DAN lABEL
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 22),
                height: 56,
                child: Stack(
                  children: [
                    // PANAH
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                          onTap: () {
                            context.bloc<PageBloc>().add(GoToSplashPage());
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          )),
                    ),
                    // AKHIR PANAH
                    // LABEL
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Create New\nAccount',
                        style: blackTextFont.copyWith(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // AKHIR LABEL
                  ],
                ),
              ),
              // AKHIR PANAH DAN LABEL
              // PROFILE PICTURE
              Container(
                width: 90,
                height: 104,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image:
                                (widget.registrationData.profileImage == null)
                                    ? AssetImage("assets/user_pic.png")
                                    : FileImage(
                                        widget.registrationData.profileImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      // BUTTON ADD PHOTO
                      child: GestureDetector(
                        onTap: () async {
                          if (widget.registrationData.profileImage == null) {
                            widget.registrationData.profileImage =
                                await getProfileImage();
                          } else {
                            widget.registrationData.profileImage = null;
                          }
                          setState(() {});
                        },
                        child: Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                  (widget.registrationData.profileImage == null)
                                      ? "assets/btn_add_photo.png"
                                      : "assets/btn_del_photo.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      // AKHIR BUTTON ADD PHOTO
                    )
                  ],
                ),
              ),
              // AKHIR PROFILE PICTURE
              SizedBox(height: 36),
              // FORM NAME
              TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Full Name",
                      hintText: "FullName")),
              // AKHIR FORM NAME
              SizedBox(height: 16),
              // FORM EMAIL
              TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Email",
                      hintText: "Email")),
              // AKHIR FORM EMAIL
              SizedBox(height: 16),
              // FORM PASSWORD
              TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Password",
                      hintText: "Password")),
              // AKHIR FORM PASSWORD
              SizedBox(height: 16),
              // FORM CONFIRM PASSWORD
              TextField(
                  obscureText: true,
                  controller: retypePasswordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Confirm Password",
                      hintText: "Confirm Password")),
              // AKHIR FORM CONFIRM PASSWORD
              SizedBox(height: 30),
              // BUTTON NEXT
              FloatingActionButton(
                onPressed: () {
                  if (!(nameController.text.trim() != "" &&
                      emailController.text.trim() != "" &&
                      passwordController.text.trim() != "" &&
                      retypePasswordController.text.trim() != "")) {
                    Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xffff5c83),
                            message: "Please fill all the fields")
                        .show(context);
                  } else if (passwordController.text !=
                      retypePasswordController.text) {
                    Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xffff5c83),
                            message: "Mismatch password and confirmed password")
                        .show(context);
                  } else if (passwordController.text.length < 6) {
                    Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xffff5c83),
                            message: "Password's length min 6 characters")
                        .show(context);
                  } else if (!EmailValidator.validate(emailController.text)) {
                    Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xffff5c83),
                            message: "Wrong formatted email address")
                        .show(context);
                  } else {
                    widget.registrationData.name = nameController.text;
                    widget.registrationData.email = emailController.text;
                    widget.registrationData.password = passwordController.text;
                  }
                },
                child: Icon(Icons.arrow_forward),
                backgroundColor: mainColor,
                elevation: 0,
              )
              // AKHIR BUTTON NEXT
            ],
          ),
        ),
      ),
    );
  }
}
