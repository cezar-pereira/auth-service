// ignore_for_file: overridden_fields

import 'dart:developer' as dev;

abstract class Failure {
  final String errorMessage;
  final String label;

  Failure({
    StackTrace? stackTrace,
    dynamic exception,
    this.label = '',
    this.errorMessage = '',
  }) {
    if (stackTrace != null) {
      dev.log(errorMessage,
          error: exception, stackTrace: stackTrace, name: label);
    }
  }
}

class ConnectionError extends Failure {
  ConnectionError() : super(errorMessage: 'no-connection-internet');
}

class ErrorExpirationToken extends Failure {
  ErrorExpirationToken() : super(errorMessage: 'expired-token');
}

class UnknownError extends Failure {
  @override
  final String errorMessage;
  @override
  final String label;
  final dynamic exception;
  final StackTrace? stackTrace;

  UnknownError({
    this.errorMessage = 'Unknown Error',
    this.label = '',
    this.exception,
    this.stackTrace,
  }) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
        );
}
