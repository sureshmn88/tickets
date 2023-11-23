import 'package:tickets/exports/exports.dart';

class ImageSelecterField extends StatelessWidget {
  const ImageSelecterField({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10),
            child: Text(text),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                border: Border.all(
                  color: Colors.redAccent,
                ),
                color: Colors.redAccent,
              ),
              alignment: Alignment.center,
              child: const Text(
                'Browse',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
