import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDiorError(DioError e) {
    switch (e.type) {
      case DioErrorType.connectionTimeout:
        return ServerFailure('Connection timeout with API server');
      case DioErrorType.sendTimeout:
        return ServerFailure('Send timeout with API server');
      case DioErrorType.receiveTimeout:
        return ServerFailure('Receive timeout with API server');
      case DioErrorType.badCertificate:
        return ServerFailure('Bad certificate with API server');
      case DioErrorType.badResponse:
        if (e.response != null && e.response?.statusCode != null) {
          return ServerFailure.fromResponse(
            e.response!.statusCode!,
            e.response!.data,
          );
        } else {
          return ServerFailure('Received invalid response from server');
        }
      case DioErrorType.cancel:
        return ServerFailure('Request to API server was cancelled');
      case DioErrorType.connectionError:
        return ServerFailure('No internet connection');
      case DioErrorType.unknown:
        return ServerFailure('Oops! There was an error, please try again');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 404) {
      return ServerFailure('Your request was not found, please try later');
    } else if (statusCode == 500) {
      return ServerFailure(
        'There is a problem with the server, please try later',
      );
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      if (response is Map &&
          response['error'] is Map &&
          response['error']['message'] is String) {
        return ServerFailure(response['error']['message']);
      } else {
        return ServerFailure('Authentication error, please try again');
      }
    } else {
      return ServerFailure('There was an error, please try again');
    }
  }
}
