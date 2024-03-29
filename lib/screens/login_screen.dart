import 'package:flutter/material.dart';
import 'package:siklero_admin/screens/home_screen.dart';
import 'package:siklero_admin/screens/signup_screen.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xffed8f5b),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 1, vertical: 30),
                          child: Hero(
                            tag: 'logo',
                            child: Image(
                              image: AssetImage('images/siklero-logo.png'),
                              height: 150,
                            ),
                          ),
                        ),
                        Hero(
                          tag: 'red-ribbon',
                          child: Image(
                            image: AssetImage('images/red-ribbon.png'),
                            height: 30,
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60)),
                        ),
                        child: Form(
                          //key: formKey,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(30),
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontSize: 48,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff581d00)),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: const Text(
                                        'Email',
                                        style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontSize: 24,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffe45f1e)),
                                      ),
                                    ),
                                    TextFormField(
                                      //controller: emailController,
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xffe45f1e)))),
                                      style: const TextStyle(
                                          fontFamily: 'OpenSans', fontSize: 24),
                                      // validator: (email) => email != null &&
                                      //         !EmailValidator.validate(email)
                                      //     ? 'Enter a valid email'
                                      //     : null,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: const Text(
                                        'Password',
                                        style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontSize: 24,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffe45f1e)),
                                      ),
                                    ),
                                    TextFormField(
                                        //controller: passwordController,
                                        obscureText: true,
                                        textInputAction: TextInputAction.done,
                                        decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5),
                                            border: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xffe45f1e)))),
                                        style: const TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontSize: 24),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) =>
                                            value != null && value.isEmpty
                                                ? "Don't leave field empty"
                                                : null),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Container(
                                width: double.infinity,
                                height: 50,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: ElevatedButton(
                                    onPressed: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) => HomeScreen(),
                                      //     ));
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => HomeScreen(),
                                          ),
                                          (route) => false);
                                    }, //signIn,
                                    style: ElevatedButton.styleFrom(
                                        shape: StadiumBorder(),
                                        foregroundColor: Colors.white,
                                        backgroundColor: Color(0xffe45f1e)),
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700),
                                    )),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      'No account yet?',
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontSize: 17,
                                          color: Color(0xffe45f1e)),
                                    ),
                                    _buildTextButton(context)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

Widget _buildTextButton(BuildContext context) {
  //Register Text Button
  return TextButton(
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignUpScreen(),
          )),
      child: const Text(
        'Sign Up',
        style: TextStyle(
            fontFamily: 'OpenSans', fontSize: 17, color: Color(0xff581d00)),
      ));
}

Widget _buildLoginButton(
    TextEditingController emailController,
    TextEditingController passwordController,
    BuildContext context,
    GlobalKey<FormState> formKey) {
  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    // try {
    //   await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: emailController.text.trim(),
    //     password: passwordController.text.trim(),
    //   );
    //
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(
    //         builder:(context) => ReminderScreen(),
    //       ),
    //           (route) => false
    //   );
    // } on FirebaseAuthException catch (e) {
    //   print(e);
    //
    //   Utils.showSnackBar(e.message);
    // }
    //
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  return ElevatedButton(
      onPressed: signIn,
      style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          foregroundColor: Colors.white,
          backgroundColor: Color(0xffe45f1e)),
      child: const Text(
        'Login',
        style: TextStyle(
            fontFamily: 'OpenSans', fontSize: 24, fontWeight: FontWeight.w700),
      ));
}
