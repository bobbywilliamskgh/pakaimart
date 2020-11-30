import 'package:pakai_mart/models/woman_overview.dart';

class UserReciever {
  final String name;
  final String userNumber;
  final String userAtmNumber;
  final String address;
  final List<WomanOverview> setOfClothes;
  final List<int> totalPerId;
  final int totalPayment;

  UserReciever(
      {this.name,
      this.userNumber,
      this.userAtmNumber,
      this.address,
      this.setOfClothes,
      this.totalPerId,
      this.totalPayment});
}
