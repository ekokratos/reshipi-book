import 'package:equatable/equatable.dart';

/// User model
/// [User.empty] represents an unauthenticated user.
class User extends Equatable {
  const User({
    required this.id,
    this.email,
    this.name,
    this.photo,
  });

  final String? email;
  final String id;
  final String? name;
  final String? photo;

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [email, id, name, photo];
}
