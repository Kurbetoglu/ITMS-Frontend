class GetAllAssetsResponse {
  bool success;
  List<AssetRecord> records;
  int dataCount;
  int pageCount;

  GetAllAssetsResponse({this.success, this.records, this.dataCount, this.pageCount});

  factory GetAllAssetsResponse.fromJson(Map<String, dynamic> json) {
    var list = json['recordList'] as List;
    List<AssetRecord> recordList = list.map((json) => AssetRecord.fromJson(json)).toList();
    return GetAllAssetsResponse(
      success: json['success'],
      records: recordList,
      dataCount: json['dataCount'],
      pageCount: json['pageCount'],
    );
  }
}

class AssetRecord {
  int id;
  String type;
  String name;
  String description;
  String addedDate;
  String expiryDate;
  String personName;
  String personSurname;
  String personEmail;
  bool isAssigned;

  AssetRecord({
    this.id,
    this.type,
    this.name,
    this.description,
    this.addedDate,
    this.expiryDate,
    this.personName,
    this.personSurname,
    this.personEmail,
    this.isAssigned,
  });

  factory AssetRecord.fromJson(Map<String, dynamic> json) {
    return AssetRecord(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      description: json['description'],
      addedDate: json['addedDate'],
      expiryDate: json['expiryDate'],
      personName: json['personName'],
      personSurname: json['personSurname'],
      personEmail: json['personEmail'],
      isAssigned: json['isAssigned'],
    );
  }
}