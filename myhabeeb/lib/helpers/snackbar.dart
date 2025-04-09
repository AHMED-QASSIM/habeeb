import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showStyledSnackbar({
  required String title,
  required String message,
  Color backgroundColor = Colors.green,
  IconData icon = Icons.check_circle,
}) {
  Get.snackbar(
    title, // Title
    message, // Message
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: backgroundColor, // Background color
    colorText: Colors.white, // Text color
    borderRadius: 10, // Rounded corners
    margin: EdgeInsets.all(10), // Margin around the snackbar
    icon: Icon(icon, color: Colors.white), // Icon
    duration: Duration(seconds: 3), // Duration the snackbar is visible
    padding: EdgeInsets.symmetric(
      vertical: 8,
      horizontal: 15,
    ), // Reduce height
    titleText: Text(
      title,
      textAlign: TextAlign.right, // Align title to the right
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
        fontFamily: 'Cairo', // Use the same font as the message
      ),
    ),
    messageText: Text(
      message,
      textAlign: TextAlign.right, // Align message to the right
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontFamily: 'Cairo', // Use the same font as the title
      ),
    ),
  );
}