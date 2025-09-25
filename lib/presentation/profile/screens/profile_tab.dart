import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  final String token;
  const ProfileTab({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace with your actual ProfileTab UI
    return Center(child: Text('Profile Tab, token: $token'));
  }
}
