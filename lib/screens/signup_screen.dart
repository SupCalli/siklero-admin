import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Image(
                        image: AssetImage('images/siklero-logo.png'),
                      ),
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
                                  'Sign Up',
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
                                      // validator: (email) =>
                                      // email != null && !EmailValidator.validate(email)
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
                                            value != null && value.length < 6
                                                ? 'Enter min. 6 character'
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
                                    onPressed: () {}, //signUp,
                                    style: ElevatedButton.styleFrom(
                                        shape: StadiumBorder(),
                                        foregroundColor: Colors.white,
                                        backgroundColor: Color(0xffe45f1e)),
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700),
                                    )),
                                // child: _buildSignUpButton(emailController,
                                //     passwordController, context, formKey),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      'Already have an account?',
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
    ;
  }
}

Widget _buildTextButton(BuildContext context) {
  return TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text(
        'Sign In',
        style: TextStyle(
            fontFamily: 'OpenSans', fontSize: 17, color: Color(0xff581d00)),
      ));
}
