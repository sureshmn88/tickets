import 'package:tickets/exports/exports.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketsStream = ref.watch(ticketsStreamProvider);
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddTicketPage(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: Padding(
          padding: EdgeInsets.all(screenSize.width * 0.05),
          child: switch (ticketsStream) {
            AsyncData(:final value) => CustomScrollView(
                slivers: [
                  value.isEmpty
                      ? SliverToBoxAdapter(
                          child: Container(
                            height: screenSize.width,
                            alignment: Alignment.center,
                            child: const Center(
                              child: Text("No Tickets"),
                            ),
                          ),
                        )
                      : SliverList.builder(
                          itemBuilder: (_, index) {
                            return Card(
                              child: Padding(
                                padding:
                                    EdgeInsets.all(screenSize.width * 0.04),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '#${value[index].reportedDate.millisecondsSinceEpoch}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    RowWidget(
                                      objectKey: "Title",
                                      objectValue: value[index].title,
                                    ),
                                    RowWidget(
                                      objectKey: "Description",
                                      objectValue: value[index].description,
                                    ),
                                    RowWidget(
                                      objectKey: "Reported Date",
                                      objectValue: value[index]
                                          .reportedDate
                                          .toDate()
                                          .toString(),
                                    ),
                                    RowWidget(
                                      objectKey: "Location",
                                      objectValue: value[index].location,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Attachment",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        SizedBox(
                                          width: screenSize.width * 0.3,
                                          height: screenSize.width * 0.3,
                                          child: value[index].attachment == ""
                                              ? null
                                              : Image.network(
                                                  value[index].attachment,
                                                ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: value.length,
                        )
                ],
              ),
            AsyncError(:final error) => Text(error.toString()),
            _ => const Center(child: CircularProgressIndicator()),
          }),
    );
  }
}

class RowWidget extends StatelessWidget {
  const RowWidget({
    super.key,
    required this.objectKey,
    required this.objectValue,
  });

  final String objectKey;
  final String objectValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              objectKey,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(objectValue),
            )
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
