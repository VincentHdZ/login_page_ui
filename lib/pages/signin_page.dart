import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _passwordFocusNode = new FocusNode();
  TextEditingController _emailTextEditingController =
      new TextEditingController();
  TextEditingController _passwordTextEditingController =
      new TextEditingController();
  bool _isRememberMe = false;

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailTextEditingController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _changeRememberMeValue() {
    setState(() {
      _isRememberMe = !_isRememberMe;
    });
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  void _login(BuildContext ctx) {
    if (_formKey.currentState.validate()) {
      String message;
      _formKey.currentState.save();
      if (_emailTextEditingController.text != "username@gmail.com" ||
          _passwordTextEditingController.text != "Soleil") {
        message = "Invalid email or password";
      } else {
        message = "Login in progress...";
      }
      setState(() {
        _emailTextEditingController.text = "";
        _passwordTextEditingController.text = "";
      });
      Scaffold.of(ctx).showSnackBar(SnackBar(
          content: Text(
        message,
        textAlign: TextAlign.center,
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(414, 896), allowFontScaling: false);
    return Scaffold(
      body: LayoutBuilder(
        builder:
            (BuildContext buildContext, BoxConstraints viewportConstraints) {
          return Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x6664b5f6),
                    Color(0x9964b5f6),
                    Color(0xcc64b5f6),
                    Color(0xff64b5f6),
                  ],
                ),
              ),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: ScreenUtil().setHeight(130),
                      ),
                      Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(50),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(60),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "Email",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(16),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _emailTextEditingController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: Colors.blue[300],
                                ),
                                hintText: "Your Email",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter your email";
                              }

                              if (!validateEmail(value)) {
                                return "Invalid email";
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              _passwordFocusNode.requestFocus();
                            },
                            onSaved: (value) {
                              _emailTextEditingController.text = value;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "Password",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(16),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            focusNode: _passwordFocusNode,
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.blue[300],
                                ),
                                hintText: "Your Password",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _passwordTextEditingController.text = value;
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Forgot Password ?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(16),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: _changeRememberMeValue,
                        child: Row(
                          children: [
                            Theme(
                              data: ThemeData(
                                  unselectedWidgetColor: Colors.white),
                              child: Checkbox(
                                  checkColor: Colors.black,
                                  activeColor: Colors.white,
                                  value: (_isRememberMe),
                                  onChanged: (bool value) {
                                    setState(() {
                                      _isRememberMe = value;
                                    });
                                  }),
                            ),
                            Text(
                              "Remember me",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(16),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(25),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            elevation: 15,
                            onPressed: () {
                              _login(buildContext);
                            },
                            padding: const EdgeInsets.only(
                              left: 80.0,
                              top: 10.0,
                              right: 80.0,
                              bottom: 10.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            color: Colors.white,
                            splashColor: Colors.white,
                            highlightColor: Colors.blue[50],
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: ScreenUtil().setSp(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(25),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Don't have an account ?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(16),
                            ),
                          ),
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(16),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
