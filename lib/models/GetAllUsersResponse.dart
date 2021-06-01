class GetAllUsersResponse {
  bool success;
  List<UserRecord> records;
  int dataCount;
  int pageCount;

  GetAllUsersResponse({this.success, this.records, this.dataCount, this.pageCount});

  factory GetAllUsersResponse.fromJson(Map<String, dynamic> json) {
    var list = json['recordList'] as List;
    List<UserRecord> recordList = list.map((json) => UserRecord.fromJson(json)).toList();
    return GetAllUsersResponse(
      success: json['success'],
      records: recordList,
      dataCount: json['dataCount'],
      pageCount: json['pageCount'],
    );
  }
}

class UserRecord {
  int id;
  String name;
  String surname;
  String email;
  String telephoneNumber;

  UserRecord({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.telephoneNumber,
  });

  factory UserRecord.fromJson(Map<String, dynamic> json) {
    return UserRecord(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      telephoneNumber: json['telephoneNumber'],
    );
  }
}