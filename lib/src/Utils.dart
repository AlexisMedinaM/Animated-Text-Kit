import 'package:flutter/material.dart';

class Utils {

  static String fromRichTextToPlainText(final Widget widget) {
    if (widget is RichText) {
      if (widget.text is TextSpan) {
        final buffer = StringBuffer();
        (widget.text as TextSpan).computeToPlainText(buffer);
        return buffer.toString();
      }
    }
    return '';
  }

  static RichText createAnimatedRichText(final RichText richText, final String text) {
      var dataText = text;
      if (richText.text is TextSpan) {
        TextSpan generalTextSpan = richText.text as TextSpan;
        String textSpanText = generalTextSpan.text ?? '';
        if(dataText.contains(textSpanText)) {
          dataText = dataText.replaceFirst(textSpanText, '');
          return RichText(
            text: TextSpan(
              text: textSpanText,
              style: generalTextSpan.style,
              children: dataText.isNotEmpty ? Utils.deepTextSpansfromTextSpan(generalTextSpan, dataText) : []
            ),
            textAlign: richText.textAlign,
          );
          
        } else {
          return RichText(
            text: TextSpan(
              text: dataText,
              style: richText.text.style
            ),
            textAlign: richText.textAlign,
          );
        }
      }
      return richText;
  }

  static List<TextSpan> deepTextSpansfromTextSpan(TextSpan textSpan, String text) {
    var currentTextSpans = (textSpan.children ?? []);
    List<TextSpan> newTextSpans = [];
    if(currentTextSpans.isNotEmpty) {
      for (var item in currentTextSpans) {
        var itemTextSpan = item as TextSpan;
        String itemText = itemTextSpan.text ?? '';
        if(text.isNotEmpty && text.contains(itemText)) {
          text = text.replaceFirst(itemText, "");
          newTextSpans.add(
            TextSpan(
              text: itemText,
              style: itemTextSpan.style,
              children: itemTextSpan.children?.isNotEmpty ?? false ? deepTextSpansfromTextSpan(itemTextSpan, text) : []
            )
          );
          text = Utils.removedTextFromTextSpan(itemTextSpan, text);
        } else {
          if(text.isNotEmpty) {
            newTextSpans.add(
              TextSpan(
                text: text,
                style: itemTextSpan.style
              )
            );
          }
          break;
        }
      }

      return newTextSpans;
    }
    return [];
  }

  static String removedTextFromTextSpan(TextSpan textSpan, String text) {
    var currentTextSpans = (textSpan.children ?? []);
    if(currentTextSpans.isNotEmpty) {
      for (var item in currentTextSpans) {
        var itemTextSpan = item as TextSpan;
        String itemText = itemTextSpan.text ?? '';
        if(text.isNotEmpty && text.contains(itemText)) {
          text = text.replaceFirst(itemText, "");
          text = removedTextFromTextSpan(itemTextSpan, text);
        } else {
          if(text.isNotEmpty) {
            text = "";
          }
          break;
        }
      }

      return text;
    }
    return text;
  }

}