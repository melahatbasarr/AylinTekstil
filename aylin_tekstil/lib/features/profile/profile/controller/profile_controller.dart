import 'package:aylin/features/profile/profile/model/profile_model.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var profile = Profile(
    firstName: 'Lütfi',
    lastName: 'Kara',
    profilePictureUrl: 'assets/images/default_profile.png',
    addresses: ['KONYA', 'MERAM'],
    orders: ['Order #1', 'Order #2'],
    phoneNumber: '+90 523 456 7890', 
  ).obs;

  void updateProfile(Profile updatedProfile) {
    profile.value = updatedProfile;
  }
}
