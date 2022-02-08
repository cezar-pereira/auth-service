import 'package:login_service/app/core/error/failure.dart';

class ErrorProduct extends Failure {
  ErrorProduct() : super(errorMessage: 'error-product-api');
}

class ErrorFetchProducts extends Failure {
  ErrorFetchProducts.empty();
  ErrorFetchProducts(
    StackTrace stackTrace,
    String label,
    dynamic exception,
    String errorMessage,
  ) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
          errorMessage: errorMessage,
        );
}
