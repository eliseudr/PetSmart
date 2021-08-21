import 'package:http_interceptor/http_interceptor.dart';
import 'package:pet_smart/app/helpers/shared_prefs.dart';

class Interceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    // print(data);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    if (data.statusCode == 401) {
      // print('esse metodo faz o refresh');
      // SharedPrefs().saveUsuarioLogado();
    }
    return data;
  }
}
