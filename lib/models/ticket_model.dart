import 'package:tickets/exports/exports.dart';

class TicketModel {
  String title;
  String description;
  String location;
  Timestamp reportedDate;
  String attachment;
  FilePickerResult? filePickerResult;

  TicketModel({
    required this.title,
    required this.description,
    required this.location,
    required this.reportedDate,
    required this.attachment,
    this.filePickerResult,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'location': location,
      'reportedDate': reportedDate,
      'attachment': attachment,
    };
  }

  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
      title: map['title'] as String,
      description: map['description'] as String,
      location: map['location'] as String,
      reportedDate: map['reportedDate'],
      attachment: map['attachment'] ?? "",
    );
  }
}
