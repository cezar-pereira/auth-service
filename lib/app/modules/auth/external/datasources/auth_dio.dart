import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:login_service/app/core/error/failure.dart';
import 'package:login_service/app/modules/auth/domain/entities/token_entity.dart';
import 'package:login_service/app/modules/auth/domain/errors/auth_failures.dart';
import 'package:login_service/app/modules/auth/infra/datasources/auth_datasource.dart';

class AuthDio implements AuthDatasourceInterface {
  final Dio _dio = Dio();

  @override
  Future<TokenEntity> login(
      {required String user, required String password}) async {
    try {
      final result = await _dio.post(
          'http://servicosflex.rpinfo.com.br:9000/v1.1/auth',
          data: {'usuario': user, 'senha': password});
      final response = result.data['response'];
      if (response['status'] == 'ok') {
        return TokenEntity(
            token: response['token'],
            tokenExpiration: DateFormat('dd/MM/yyyy HH:mm')
                .parse(response['tokenExpiration']));
      } else {
        throw ErrorLogin();
      }
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.response) {
        throw ErrorLogin();
      } else {
        throw ConnectionError();
      }
    }
  }
}
