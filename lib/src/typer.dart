import 'package:characters/characters.dart';
import 'package:flutter/material.dart';
import 'animated_text.dart';
import 'Utils.dart';

/// Animated Text that displays a [Text] element as if it is being typed one
/// character at a time.
///
/// ![Typer example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/typer.gif)
class TyperAnimatedText extends AnimatedText {
  /// The [Duration] of the delay between the apparition of each characters
  ///
  /// By default it is set to 40 milliseconds.
  final Duration speed;

  /// The [Curve] of the rate of change of animation over time.
  ///
  /// By default it is set to Curves.linear.
  final Curve curve;

  TyperAnimatedText(
    RichText richText, {
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    this.speed = const Duration(milliseconds: 40),
    this.curve = Curves.linear,
  }) : super(
          text: '',
          richText: richText,
          textAlign: textAlign,
          textStyle: textStyle,
          duration: speed * Utils.fromRichTextToPlainText(richText).characters.length,
        );

  late Animation<double> _typingText;

  @override
  Duration get remaining => speed * (Utils.fromRichTextToPlainText(richText!).characters.length - _typingText.value);

  @override
  void initAnimation(AnimationController controller) {
    _typingText = CurveTween(
      curve: curve,
    ).animate(controller);
  }

  /// Widget showing partial text, up to [count] characters
  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    /// Output of CurveTween is in the range [0, 1] for majority of the curves.
    /// It is converted to [0, textCharacters.length].
    final count =
        (_typingText.value.clamp(0, 1) * Utils.fromRichTextToPlainText(richText!).characters.length).round();

    assert(count <= Utils.fromRichTextToPlainText(richText!).characters.length);
    return textWidget(Utils.fromRichTextToPlainText(richText!).characters.take(count).toString());
  }
}

/// Animation that displays [text] elements, as if they are being typed one
/// character at a time.
///
/// ![Typer example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/typer.gif)
@Deprecated('Use AnimatedTextKit with TyperAnimatedText instead.')
class TyperAnimatedTextKit extends AnimatedTextKit {
  TyperAnimatedTextKit({
    Key? key,
    required List<String> text,
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    Duration speed = const Duration(milliseconds: 40),
    Duration pause = const Duration(milliseconds: 1000),
    bool displayFullTextOnTap = false,
    bool stopPauseOnTap = false,
    VoidCallback? onTap,
    void Function(int, bool)? onNext,
    void Function(int, bool)? onNextBeforePause,
    VoidCallback? onFinished,
    bool isRepeatingAnimation = true,
    bool repeatForever = true,
    int totalRepeatCount = 3,
    Curve curve = Curves.linear,
  }) : super(
          key: key,
          animatedTexts:
              _animatedTexts(text, textAlign, textStyle, speed, curve),
          pause: pause,
          displayFullTextOnTap: displayFullTextOnTap,
          stopPauseOnTap: stopPauseOnTap,
          onTap: onTap,
          onNext: onNext,
          onNextBeforePause: onNextBeforePause,
          onFinished: onFinished,
          isRepeatingAnimation: isRepeatingAnimation,
          repeatForever: repeatForever,
          totalRepeatCount: totalRepeatCount,
        );

  static List<AnimatedText> _animatedTexts(
    List<String> text,
    TextAlign textAlign,
    TextStyle? textStyle,
    Duration speed,
    Curve curve,
  ) =>
      text
          .map((_) => TyperAnimatedText(
                RichText(text: TextSpan(text: _),),
                textAlign: textAlign,
                textStyle: textStyle,
                speed: speed,
                curve: curve,
              ))
          .toList();
}
