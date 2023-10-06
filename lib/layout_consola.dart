import 'package:flutter/material.dart';

class LayoutConsola extends StatelessWidget {
  final dynamic itemData;

  final Map<String, Color> colorMap = {
    'white': Colors.white,
    'black': Colors.black,
    'purple': Colors.purple,
    'grey': Colors.grey,
  };

  LayoutConsola({Key? key, required this.itemData}) : super(key: key);

  Color getColorFromString(String colorString) {
    return colorMap[colorString.toLowerCase()] ?? Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 100.0,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.asset(
              'assets/images/${itemData["imatge"]}',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${itemData['nom']}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text("Data de llançament: ${itemData['data']}"),
                Text("Procesador: ${itemData['procesador']}"),
                Container(
                  width: 10,
                  height: 10,
                  color: getColorFromString(itemData['color']),
                ),
                const SizedBox(height: 10),
                Text("Unitats venudes: ${itemData['venudes']}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
