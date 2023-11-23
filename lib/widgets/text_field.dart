import 'package:tickets/exports/exports.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.textEditingController,
    this.readOnly = false,
    this.validator,
  });
  final String label;
  final String hint;
  final TextEditingController? textEditingController;
  final bool readOnly;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      readOnly: readOnly,
      validator: validator,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(label),
        hintText: hint,
      ),
    );
  }
}
