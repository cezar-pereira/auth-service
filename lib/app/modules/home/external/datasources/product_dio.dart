import 'package:dio/dio.dart';
import 'package:login_service/app/core/error/failure.dart';
import 'package:login_service/app/modules/auth/domain/services/auth_service_interface.dart';
import 'package:login_service/app/modules/home/domain/errors/product_failures.dart';
import 'package:login_service/app/modules/home/infra/datasources/product_datasource.dart';
import 'package:login_service/app/modules/home/infra/models/product_model.dart';

class ProductDio implements ProductDatasourceInterface {
  final Dio _dio = Dio();
  final AuthServiceInterface _service;
  ProductDio({required AuthServiceInterface service}) : _service = service;
  @override
  Future<List<ProductModel>> fetchProducts() async {
    List<ProductModel> list = [];
    try {
      var token = await _service.getToken();
      await token.fold((l) {
        throw l;
      }, (r) async {
        final result = await _dio.get(
            'http://servicosflex.rpinfo.com.br:9000/v2.0/produtounidade/listaprodutos/0/unidade/76387901000140',
            options: Options(headers: {'token': r.token}));
        final response = result.data['response'];

        if (response['status'] == 'ok') {
          var data = result.data['response']['produtos'];
          list = data.map<ProductModel>((product) {
            return ProductModel.fromMap(map: product);
          }).toList();
        } else {
          throw ErrorProduct();
        }
      });
      return list;
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.response) {
        throw ErrorProduct();
      } else {
        throw ConnectionError();
      }
    }
  }
}
