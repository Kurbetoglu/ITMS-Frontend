class AdminInfo {
  int adminId;
  String name;
  String surname;
  String email;
  String telephoneNumber;

  AdminInfo({this.adminId, this.name, this.surname, this.email, this.telephoneNumber});

  factory AdminInfo.fromJson(Map<String, dynamic> json) {
    return AdminInfo(
        adminId: json['adminId'],
        name: json['name'],
        surname: json['surname'],
        email: json['email'],
        telephoneNumber: json['telephoneNumber']
    );
  }

  Map<String, dynamic> toJson() => {
    "adminId": adminId,
    "name": name,
    "surname": surname,
    "email": email,
    "telephoneNumber": telephoneNumber,
  };
}

class AdminModel {
  AdminInfo adminInfo;

  AdminModel({this.adminInfo});

  factory AdminModel.fromJson(Map<String, dynamic> json){
    return AdminModel(
      adminInfo: AdminInfo.fromJson(json['adminInfo']),
    );
  }

  Map<String, dynamic> toJson() => {
    "adminInfo": adminInfo.toJson(),
  };
}

class AdminLoginResponse {
  bool success;
  AdminModel adminModel;

  AdminLoginResponse({this.success, this.adminModel});

  factory AdminLoginResponse.fromJson(Map<String, dynamic> json) {
    return AdminLoginResponse(
      success: json['success'],
      adminModel: AdminModel.fromJson(json['adminModel']),
    );
  }

  Map<String, dynamic> toJson() => {
    "adminModel": adminModel.toJson(),
    "success": success,
  };
}



