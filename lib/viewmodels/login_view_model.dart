// Import required packages and files.
import 'package:flutter/material.dart';
import '../data/models/login_response.dart';
import '../data/repositories/login_repository.dart';

// Create the LoginViewModel class and extend it with ChangeNotifier to enable state management.
class LoginViewModel with ChangeNotifier {
  // Instance of the LoginRepository class to interact with the user login data.
  final LoginRepository userRepository;

  // Constructor to initialize the LoginViewModel with the LoginRepository instance.
  LoginViewModel({required this.userRepository});

  // Private variables to store response and error data from the login process.
  String? _response; // Response from the login API call.
  String? get response => _response; // Getter to access the login response.

  String? _loginError; // Error message in case the login process fails.
  bool _isLoading = false; // A flag to track the loading state during the login process.

  // Getters to access the error message and loading state.
  String? get loginError => _loginError;
  bool get isLoading => _isLoading;

  // Method to handle the login process asynchronously.
  Future<void> login(Map<dynamic, dynamic> req) async {
    // Set the isLoading flag to true to indicate that the login process is ongoing.
    _isLoading = true;
    // Notify the listeners (usually UI elements) that the state has changed.
    notifyListeners();

    try {
      // Call the login method from the userRepository to initiate the login process.
      _response = await userRepository.login(req);
      // If the login is successful, set the loginError to null.
      _loginError = null;
    } catch (e) {
      // If an error occurs during the login process, catch the error and set the loginError with the error message.
      _loginError = e.toString();
    }

    // Set the isLoading flag back to false to indicate that the login process has completed.
    _isLoading = false;
    // Notify the listeners that the state has changed after completing the login process.
    notifyListeners();
  }
}
