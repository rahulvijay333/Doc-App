class CreateError {
  final String error;

  CreateError({required this.error});

  factory CreateError.fromJson(Map<String, dynamic> json) {
    return CreateError(error: json['errorInfo']);
  }
}

class DisplayErrorOtp {
  final String errorMessage;

  DisplayErrorOtp({required this.errorMessage});

  factory DisplayErrorOtp.fromJson(Map<String, dynamic> json) {
    return DisplayErrorOtp(errorMessage: json['message']);
  }
}
