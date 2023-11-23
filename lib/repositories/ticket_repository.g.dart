// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ticketsStreamHash() => r'169f5ebc372cf6de3e7ebcb1e2a131a27007e83d';

/// See also [ticketsStream].
@ProviderFor(ticketsStream)
final ticketsStreamProvider =
    AutoDisposeStreamProvider<List<TicketModel>>.internal(
  ticketsStream,
  name: r'ticketsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ticketsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TicketsStreamRef = AutoDisposeStreamProviderRef<List<TicketModel>>;
String _$ticketRepositoryHash() => r'ba2c06af427b3cae5771f1b6e8482e319812dc55';

/// See also [ticketRepository].
@ProviderFor(ticketRepository)
final ticketRepositoryProvider = AutoDisposeProvider<TicketRepository>.internal(
  ticketRepository,
  name: r'ticketRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ticketRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TicketRepositoryRef = AutoDisposeProviderRef<TicketRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
