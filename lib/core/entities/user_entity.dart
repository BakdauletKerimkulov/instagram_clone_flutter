import 'dart:ffi';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String? email;
  final String? username;
  final String? fullname;
  final String? phoneNumber;
  final String? avatarUrl;
  final String? bio;
  final MetaDataEntity? metaData;
  final Long? birthday;

  const UserEntity({
    required this.uid,
    this.username,
    this.phoneNumber,
    this.avatarUrl,
    this.bio,
    this.metaData,
    this.birthday,
    this.email,
    this.fullname,
  });

  @override
  List<Object?> get props => [
    uid,
    email,
    username,
    fullname,
    phoneNumber,
    avatarUrl,
    bio,
    metaData,
    birthday,
  ];
}

class MetaDataEntity extends Equatable {
  final DateTime createdAt;
  final DateTime lastSignIn;

  const MetaDataEntity({required this.createdAt, required this.lastSignIn});

  @override
  List<Object?> get props => [];
}
