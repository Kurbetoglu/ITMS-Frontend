class GetAllDebitsResponse {
  bool success;
  List<DebitRecord> records;
  int dataCount;
  int pageCount;

  GetAllDebitsResponse({this.success, this.records, this.dataCount, this.pageCount});

  factory GetAllDebitsResponse.fromJson(Map<String, dynamic> json) {
    var list = json['recordList'] as List;
    List<DebitRecord> recordList = list.map((json) => DebitRecord.fromJson(json)).toList();
    return GetAllDebitsResponse(
      success: json['success'],
      records: recordList,
      dataCount: json['dataCount'],
      pageCount: json['pageCount'],
    );
  }
}

class DebitRecord {
  int id;
  int assetId;
  String assigner;
  String user;
  String assetType;
  String assetName;
  String assetDescription;
  String cause;
  String startDate;
  String endDate;
  String createdDate;
  String editedDate;
  bool isDelivered;

  DebitRecord({
    this.id,
    this.assetId,
    this.assigner,
    this.user,
    this.assetType,
    this.assetName,
    this.assetDescription,
    this.cause,
    this.startDate,
    this.endDate,
    this.createdDate,
    this.editedDate,
    this.isDelivered,
  });

  factory DebitRecord.fromJson(Map<String, dynamic> json) {
    return DebitRecord(
      id: json['id'],
      assetId: json['assetId'],
      assigner: json['assigner'],
      user: json['user'],
      assetType: json['assetType'],
      assetName: json['assetName'],
      assetDescription: json['assetDescription'],
      cause: json['cause'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      createdDate: json['createdDate'],
      editedDate: json['editedDate'],
      isDelivered: json['isDelivered'],
    );
  }
}