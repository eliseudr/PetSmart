import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text('Login PetSmart', style: TextStyle(fontSize: 24,
                        color: Colors.black54.withOpacity(0.5)
                    ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
