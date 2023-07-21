class CreateError {
  final String error;

  CreateError({required this.error});

  factory CreateError.fromJson(Map<String, dynamic> json) {
    return CreateError(error: json['errorInfo']);
  }
}
