import 'package:equatable/equatable.dart';

/// Domain layer entity:
/// Pure business object used by the app regardless of data source.
class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.companyName,
    required this.city,
  });

  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final String companyName;
  final String city;

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        email,
        phone,
        website,
        companyName,
        city,
      ];
}
