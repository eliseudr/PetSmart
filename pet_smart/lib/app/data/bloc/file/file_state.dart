//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class FileState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialFileState extends FileState {}

class FileLoading extends FileState {}

class FileLoaded extends FileState {
  final Uint8List file;
  final String message;

  FileLoaded({this.file, this.message});
}

class FileError extends FileState {
  final Exception e;

  FileError({@required this.e}) : assert(e != null);
}
