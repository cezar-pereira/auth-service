import 'package:login_service/app/core/error/failure.dart';

class ErrorLogin extends Failure {
  ErrorLogin() : super(errorMessage: 'unauthorized-login');
}

class ErrorGetToken extends Failure {
  ErrorGetToken.empty();
  ErrorGetToken(
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

class ErrorSaveToken extends Failure {
  ErrorSaveToken.empty();
  ErrorSaveToken(
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

class ErrorLogout extends Failure {
  ErrorLogout.empty();
  ErrorLogout(
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

class ErrorNotExistToken extends Failure {
  ErrorNotExistToken() : super(errorMessage: 'not-exist-token');
}
