class GetAssetsByTypeResponse {
  bool success;
  List<Record> records;
  int dataCount;
  int pageCount;

  GetAssetsByTypeResponse({this.success, this.records, this.dataCount, this.pageCount});

  factory GetAssetsByTypeResponse.fromJson(Map<String, dynamic> json) {
    var list = json['recordList'] as List;
    List<Record> recordList = list.map((json) => Record.fromJson(json)).toList();
    return GetAssetsByTypeResponse(
      success: json['success'],
      records: recordList,
      dataCount: json['dataCount'],
      pageCount: json['pageCount'],
    );
  }
}

class Record {
  int id;
  String type;
  String name;
  String description;
  String addedDate;
  bool isAssigned;
  String expiryDate;
  String personName;
  String personSurname;
  String personEmail;

  Record({
    this.id,
    this.type,
    this.name,
    this.description,
    this.addedDate,
    this.isAssigned,
    this.expiryDate,
    this.personName,
    this.personSurname,
    this.personEmail
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      description: json['description'],
      addedDate: json['addedDate'],
      isAssigned: json['isAssigned'],
      expiryDate: json['expiryDate'],
      personName: json['personName'],
      personSurname: json['personSurname'],
      personEmail: json['personEmail'],
    );
  }
}