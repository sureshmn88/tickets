import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tickets/exports/exports.dart';
part 'ticket_repository.g.dart';

class TicketRepository {
  final http.Client client;

  TicketRepository(this.client);

  final CollectionReference _ticketsCollection =
      FirebaseFirestore.instance.collection("tickets");

  Stream<List<TicketModel>> fetchTicketsStream() {
    try {
      return _ticketsCollection
          .orderBy("reportedDate", descending: true)
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return TicketModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> postNewTicket(TicketModel ticket) async {
    bool result = false;
    String? attachmentUrl =
        await uploadAttachmentToStorage(ticket.filePickerResult);
    ticket.attachment = attachmentUrl ?? "";
    await _ticketsCollection
        .add(ticket.toMap())
        .then((value) => result = true)
        .catchError((err) => result = false);
    return result;
  }

  Future<String?>? uploadAttachmentToStorage(FilePickerResult? file) async {
    String storageCollection =
        file?.files.single.name ?? 'attachment@${DateTime.now()}';

    try {
      if (file != null) {
        File uploadFile = File(file.files.single.path!);
        Reference storageRef = FirebaseStorage.instance
            .ref()
            .child('attachments')
            .child(storageCollection);
        UploadTask uploadTask = storageRef.putFile(uploadFile);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        return await taskSnapshot.ref.getDownloadURL();
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}

@riverpod
Stream<List<TicketModel>> ticketsStream(TicketsStreamRef ref) {
  final ticketRepository = ref.watch(ticketRepositoryProvider);
  return ticketRepository.fetchTicketsStream();
}

@riverpod
TicketRepository ticketRepository(TicketRepositoryRef ref) {
  return TicketRepository(http.Client());
}
