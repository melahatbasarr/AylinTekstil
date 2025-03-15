class Profile {
  String firstName;
  String lastName;
  String profilePictureUrl;
  List<String> addresses;
  List<String> orders;
  String? phoneNumber; 

  Profile({
    required this.firstName,
    required this.lastName,
    required this.profilePictureUrl,
    required this.addresses,
    required this.orders,
    this.phoneNumber, 
  });
}
