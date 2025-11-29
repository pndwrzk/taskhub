class BaseResponse<T> {
  String status;
  String message;
  T data;

  BaseResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return BaseResponse(
      status: json['status'],
      message: json['message'],
      data: fromJsonT(json['data']),
    );
  }
}
