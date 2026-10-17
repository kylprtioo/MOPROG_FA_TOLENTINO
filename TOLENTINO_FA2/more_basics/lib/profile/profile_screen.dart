import 'package:flutter/material.dart';
import 'package:more_basics/commons/styled_button.dart';
import 'package:more_basics/commons/styled_text.dart';
import 'package:more_basics/data/profile_data.dart';
import 'package:more_basics/model/profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.onExit, required this.onFinish});

  final void Function() onExit;
  final void Function(List<String>) onFinish;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var profileIndex = 0;
  final List<String> selectedAnswers = [];

  void infoClick(String selectedInfo) {
    setState(() {
      selectedAnswers.add(selectedInfo);
      if (profileIndex < profileData.length - 1) {
        profileIndex++;
      } else {
        widget.onFinish(selectedAnswers);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Profile currentProfile = profileData[profileIndex];
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 15,
          children: [
            StyledText(currentProfile.text, 30, color: Colors.white),
            ...currentProfile.getShuffledList().map(
              (info) => StyledButton(
                text: info,
                onPressed: () {
                  infoClick(info);
                },
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: widget.onExit,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.exit_to_app),
              label: StyledText('Exit', 15, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}