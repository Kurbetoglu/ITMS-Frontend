class BaseResponse {
  bool success;

  BaseResponse({this.success});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
        success: json['success']
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success
  };
}