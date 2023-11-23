import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tickets/exports/exports.dart';

part 'ticket_controller.g.dart';

@riverpod
class TicketController extends _$TicketController {
  @override
  FutureOr<void> build() {}

  Future<void> addTicket(TicketModel ticketModel) async {
    final ticketRepository = ref.read(ticketRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ticketRepository.postNewTicket(ticketModel));
  }
}
