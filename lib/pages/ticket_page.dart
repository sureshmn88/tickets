import 'package:tickets/exports/exports.dart';

class AddTicketPage extends ConsumerStatefulWidget {
  const AddTicketPage({super.key});

  @override
  ConsumerState<AddTicketPage> createState() => _AddTicketPageState();
}

class _AddTicketPageState extends ConsumerState<AddTicketPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController? _titleController;
  TextEditingController? _descriptionController;
  TextEditingController? _locationController;
  TextEditingController? _dateController;
  DateTime dateTime = DateTime.now();
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _locationController = TextEditingController();
    _dateController = TextEditingController(
        text:
            '${dateTime.day}-${dateTime.month}-${dateTime.year} ${dateTime.hour}:${dateTime.minute}');

    Future.delayed(const Duration(seconds: 3),
        () => NotificationService.instance.initializeNotificationPlugin(ref));
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  pickFile() async {
    FilePickerResult? pickedFile =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    ref.read(pickedFilePathProvider.notifier).state = pickedFile;
    ref.read(pickedFileNameProvider.notifier).state =
        pickedFile?.files.single.name ?? "Choose";
  }

  postTicket() async {
    if (_formKey.currentState!.validate()) {
      TicketModel ticketModel = TicketModel(
        title: _titleController?.text ?? "",
        description: _descriptionController?.text ?? "",
        location: _locationController?.text ?? "",
        reportedDate: Timestamp.now(),
        attachment: "",
        filePickerResult: ref.watch(pickedFilePathProvider),
      );

      ref
          .read(ticketControllerProvider.notifier)
          .addTicket(ticketModel)
          .then((value) {
        Navigator.of(context).pop();
        pushNotification();
      });
    }
  }

  pushNotification() {
    NotificationService.instance.pushNotification(
      ref,
      "Success",
      "Your request has been created",
    );
  }

  fetchLocation() async {
    try {
      String? location = await LocationService.instance.determinePosition();
      ref.read(locationProvider.notifier).state = location;
      _locationController?.text = location;
      ref.read(errorProvider.notifier).state = "";
    } catch (e) {
      switch (e.toString()) {
        case 'Services Disabled':
          ref.read(errorProvider.notifier).state =
              "Turn on device location to fetch";
          break;
        case 'Location Denied':
          ref.read(errorProvider.notifier).state = 'Allow to access Location';
          break;
        default:
          ref.read(errorProvider.notifier).state =
              'Location permanently denied, we can\'t fetch location anymore';
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<void> ticketControllerState =
        ref.watch(ticketControllerProvider);

    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Ticket'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: EdgeInsets.all(screenSize.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomTextField(
                  label: 'Title',
                  hint: 'Enter Problem Title Here',
                  textEditingController: _titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter problem title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenSize.height * 0.03),
                CustomTextField(
                  label: 'Description',
                  hint: 'Enter Problem Description Here',
                  textEditingController: _descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter problem description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenSize.height * 0.03),
                CustomTextField(
                  label: 'Location',
                  hint: 'Enter Your Location Here',
                  textEditingController: _locationController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter location';
                    }
                    return null;
                  },
                ),
                TextButton(
                  onPressed: fetchLocation,
                  child: const Text(
                    'Fetch Automatically',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    ref.watch(errorProvider),
                    style: const TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.03),
                CustomTextField(
                  label: 'ReportedDate',
                  hint: 'Enter Your Location Here',
                  textEditingController: _dateController,
                  readOnly: true,
                ),
                SizedBox(height: screenSize.height * 0.03),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("Attach Document"),
                ),
                SizedBox(height: screenSize.height * 0.01),
                ImageSelecterField(
                  onTap: pickFile,
                  text: ref.watch(pickedFileNameProvider),
                ),
                SizedBox(height: screenSize.height * 0.05),
                Center(
                  child: ticketControllerState.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: postTicket,
                          child: const Text('Submit'),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
