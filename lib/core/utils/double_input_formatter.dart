import 'package:flutter/services.dart';

class DoubleInputFormatter extends TextInputFormatter {
  final bool isIndianRupee;

  DoubleInputFormatter({this.isIndianRupee = false});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow empty input
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Check if the input is a valid double
    final doubleValue = double.tryParse(newValue.text);
    if (doubleValue != null) {
      if(doubleValue == 0) {
        return TextEditingValue(text: "0");
      }
      return newValue;
    }

    // Prevent more than one dot
    if (newValue.text.split('.').length - 1 > 1) {
      return oldValue;
    }

    // Reject invalid input
    return oldValue;
  }
}

class DoubleInputFormatterWithFixedText extends TextInputFormatter {

  final String fixedText;

  DoubleInputFormatterWithFixedText({required this.fixedText});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow empty input
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Check if the input is a valid double
    final doubleValue = double.tryParse(newValue.text.replaceAll(fixedText, ""));
    if (doubleValue != null) {
      return newValue;
    }

    // Prevent more than one dot
    if (newValue.text.split('.').length - 1 > 1) {
      return oldValue;
    }

    if (newValue.text.startsWith(fixedText)) {
      return newValue;
    } else {
      return oldValue;
    }

    // Reject invalid input
    return oldValue;
  }
}

