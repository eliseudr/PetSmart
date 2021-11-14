//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_smart/app/data/bloc/file/file.dart';
import 'package:pet_smart/app/data/repositories/arquivo_repository.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  final ArquivoRepository arquivoRepository;

  FileBloc({@required this.arquivoRepository})
      : assert(arquivoRepository != null);

  @override
  FileState get initialState => InitialFileState();

  @override
  Stream<FileState> mapEventToState(FileEvent event) async* {
    if (event is FetchFile) {
      yield FileLoading();
      try {
        final Uint8List file = await arquivoRepository.getFile(
            event.nomePasta, event.nomeArquivo, event.nomeDB, event.token);
        yield FileLoaded(file: file);
      } catch (e) {
        yield FileError(e: e);
      }
    } else if (event is PostFile) {
      yield FileLoading();
      try {
        final String message = await arquivoRepository.sendFile(event.nomePasta,
            event.nomeArquivo, event.base64, event.nomeDB, event.token);
        yield FileLoaded(message: message);
      } catch (e) {
        yield FileError(e: e);
      }
    }
  }
}
