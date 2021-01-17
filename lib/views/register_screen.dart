import 'package:flutter/material.dart';
import 'package:hilogame/database/firebase.dart';
import 'package:hilogame/shared/loading.dart';
import 'package:hilogame/theme/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<Register> {
  bool loading = false;
  final bool readOnly = false;
  //String error;
  /*  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'; */
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repasswordController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _error = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    /* final logo = Image.asset(
      "asset/logo.jpg",
      height: mq.size.height / 4,
    ); */

    final usernameField = TextFormField(
      // Validate that the field is not empty
      validator: (value) {
        if (value.isEmpty) {
          return 'please enter name';
        }
        return null;
      },
      /*  onSaved: (String name) {        // ___ I think that i don't need that anymore
        name = _usernameController.text;
      }, */
      controller: _usernameController,
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: "Username",
        labelText: "Username",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final ageField = TextFormField(
      // Validate : the field is not empty
      validator: (value) {
        if (value.isEmpty) {
          return 'please enter your age';
        }
        return null;
      },
      keyboardType: TextInputType.number,
      controller: _ageController,
      inputFormatters: [
        // TODO
      ],
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: "Age",
        labelText: "Age",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );
    final emailField = TextFormField(
      // Validate that the field is not empty
      validator: (value) {
        if (value.isEmpty) {
          return 'please enter your email';
        }
        return null;
      },
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: "something@example.com",
        labelText: "Email",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final passwordField = TextFormField(
      // Validate that the field is not empty
      validator: (value) {
        if (value.isEmpty) {
          return 'please enter your password';
        }
        if (value.length < 9) {
          return 'The password must be at least 9 chars';
        }
        /* if (value.contains(new RegExp(r'[A-Z]'))) {  // Try later
          return ' det går inte idiot';
        } */
        return null;
      },

      obscureText: true,
      controller: _passwordController,
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: "password",
        labelText: "Password",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final repasswordField = TextFormField(
      // Validate that the field is not empty
      validator: (value) {
        if (value.isEmpty) {
          return 'please enter the re-password';
        }
        return null;
      },
      obscureText: true,
      controller: _repasswordController,
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: "password",
        labelText: "Re-enter Password",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    // YOU ALREADY HAVE AN ACCOUNT ERROR!!!!!
    // maybe can i find a better way to resolve it then
    final error = TextFormField(
      readOnly: true,
      controller: _error,
      style: TextStyle(
        color: Colors.red,
      ),
      cursorColor: Colors.red,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: "",
        labelText: "",
      ),
    );

    final fields = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //logo,
          usernameField,
          ageField,
          emailField,
          passwordField,
          repasswordField,
          error,
        ],
      ),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.grey[600],
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            setState(() => loading = true);
            // Check if the password and re-password match
            if (_passwordController.text != _repasswordController.text) {
              return _repasswordController.text = "";
            }
            try {
              User user =
                  (await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text,
              ))
                      .user;

              if (user != null) {
                await FirebaseAuth.instance.currentUser
                    .updateProfile(displayName: user.displayName);

                userSetup(_usernameController.text, _ageController.text);

                Navigator.of(context).pushNamed(AppRoutes.menu);
              }
            } catch (e) {
              print(e);

              _usernameController.text = "";
              _passwordController.text = "";
              _repasswordController.text = "";
              _emailController.text = "";
              _ageController.text = "";
              _error.text = ' You already hava an account!';
              print("error");
              setState(() => loading = false);
              // TODO: alertdialog with error
            }
          }
          /* Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('Processing Data'))); */
        },
      ),
    );

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        registerButton,
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Already have an account?",
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.white,
                  ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.authLogin);
              },
              child: Text(
                "Login",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
          ],
        ),
      ],
    );

    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xff8c52ff),
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.grey, Colors.black])),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(36),
                  child: Container(
                    height: mq.size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        //logo,
                        fields,
                        Padding(
                          padding: EdgeInsets.only(bottom: 150),
                          child: bottom,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
