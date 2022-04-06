import '../models/message_config.dart';

String? loginCredentialsValidation(String userName, String userPassword) {
  if (userName.isNotEmpty && userPassword.isNotEmpty) {
    if (phoneRegex.hasMatch(userName)) {
      return loginAttemptAlerts['Invalid User Name Format'];
    } else {
      if (emailRegex.hasMatch(userName)) {
        return 'valid';
      } else {
        return loginAttemptAlerts['Invalid User Name Format'];
      }
    }
  } else {
    if (userName.isEmpty && userPassword.isEmpty) {
      return loginAttemptAlerts['No Fields'];
    } else {
      if (userName.isEmpty && userPassword.isNotEmpty) {
        return loginAttemptAlerts['No User Name'];
      } else {
        return loginAttemptAlerts['No User Password'];
      }
    }
  }
}
