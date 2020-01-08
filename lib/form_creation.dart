import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class Formcreator extends StatefulWidget {
  @override
  _FormcreatorState createState() => _FormcreatorState();
}

class _FormcreatorState extends State<Formcreator> {
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Form Creator")),
      body: Container(
        child: Builder(
          builder: (context) {
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                      decoration:
                          InputDecoration(hintText: 'Enter your Username'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter some text";
                        }
                        var message = (!isAlpha(value.toString()))
                            ? "Enter a valid username"
                            : null;
                        return message;
                      }),
                  TextFormField(
                      decoration:
                          InputDecoration(hintText: 'Enter your Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter some text";
                        }
                        var message = (!isAlphanumeric(value.toString()))
                            ? "Enter a valid password"
                            : null;
                        return message;
                      }),
                  TextFormField(
                      decoration:
                          InputDecoration(hintText: 'Enter your email ID'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter some text";
                        }
                        String message = !EmailValidator.validate(value)
                            ? "Not a valid email"
                            : null;
                        return message;
                      }),
                  TextFormField(
                      decoration:
                          InputDecoration(hintText: 'Enter your Mobile Number'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter some text";
                        }
                        var message = (!isNumeric(value.toString()))
                            ? "Enter a valid mobile number"
                            : null;
                        return message;
                      }),
                  TextFormField(
                      decoration:
                          InputDecoration(hintText: 'Enter your Address'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter some text";
                        }
                        var message = (!isAlphanumeric(value.toString()))
                            ? "Enter a valid Address"
                            : null;
                        return message;
                      }),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Processing data")));
                                }
                              },
                              child: Text('Submit'),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: RaisedButton(
                              onPressed: () {
                                _formKey.currentState.reset();
                              },
                              child: Text('Clear'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
