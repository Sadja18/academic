Map<String, String> confs = {
  '1LO01': 'Login Failed. Wrong Credentials during online session',
  '1LO02': 'Server Error.',
  '1LOZZ': "Network Timeout. Is your intenet connection stable",
  '0LO01':
      'Login Failed. (offline mode but no locally saved credentials found)',
  '0LO02': 'Wrong credentials for offline session',
  '1LO200': 'Login Successful', //online mode
  '0LO200': 'Offline mode Login Successful', //offline mode
  '1DAFP200': 'Fetching of Persistent data from server successful',
  '1DAFP200S': 'Persistent data saved to local system successfully',
  '1DAFA200': 'Fetching of Assessments scheduled for result upload successful'
};

Map<String, String> loginAttemptAlerts = {
  'No Fields': 'User Name and Password fields cannot be empty',
  'No User Name': 'User Name field cannot be empty',
  'No User Password': 'User Password Field cannot be empty',
  'Invalid User Name Format': 'Invalid user name format'
};

RegExp emailRegex = RegExp(
    r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$",
    multiLine: false,
    caseSensitive: false);

RegExp phoneRegex = RegExp(r'^(\+)?(91)?( )?[789]\d{9}$', multiLine: false);
