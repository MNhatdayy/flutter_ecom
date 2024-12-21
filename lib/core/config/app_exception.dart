class AppException implements Exception {
  final String? message;
  final String? process;
  final String? url;

  AppException([this.message, this.process, this.url]);

}

class BadRequestException extends AppException
{
  BadRequestException([String? message, String? url]):super(message, 'Bad Request', url);
}
class FetchDataException extends AppException
{
  FetchDataException([String? message, String? url]):super(message, 'Unable to process', url);
}
class ApiNotRespondingException extends AppException
{
  ApiNotRespondingException([String? message, String? url]):super(message, 'API not responding', url);
}
class UnAuthorizedException extends AppException
{
  UnAuthorizedException([String? message, String? url]):super(message, 'Unauthorization', url);
}