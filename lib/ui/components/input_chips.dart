import 'dart:async';
import 'package:flutter/material.dart';

class EditableChipField<T> extends StatefulWidget {
  const EditableChipField({
    super.key,
    required this.values,
    required this.suggestionCallback,
    required this.onValuesChanged,
    required this.chipBuilder,
    required this.hintText,
    this.icon = Icons.search,
    this.suggestionBuilder,
  });

  final List<T> values;
  final FutureOr<List<T>> Function(String) suggestionCallback;
  final ValueChanged<List<T>> onValuesChanged;
  final Widget Function(BuildContext context, T data) chipBuilder;
  final String hintText;
  final IconData icon;
  final Widget Function(BuildContext context, T suggestion, ValueChanged<T>)?
      suggestionBuilder;

  @override
  EditableChipFieldState<T> createState() => EditableChipFieldState<T>();
}

class EditableChipFieldState<T> extends State<EditableChipField<T>> {
  final TextEditingController _controller = TextEditingController();
  List<T> _values = [];
  List<T> _suggestions = [];

  @override
  void initState() {
    super.initState();
    _values = List<T>.from(widget.values);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ChipsInput<T>(
            values: _values,
            decoration: InputDecoration(
              prefixIcon: Icon(widget.icon),
              hintText: widget.hintText,
              fillColor: Colors.red,
              filled: true
            ),
            chipBuilder: widget.chipBuilder,
            onChanged: _onValuesChanged,
            onTextChanged: _onSearchChanged,
            onSubmitted: _onSubmitted,
          ),
        ),
        if (_suggestions.isNotEmpty)
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: ListView.builder(
              itemCount: _suggestions.length,
              itemBuilder: (BuildContext context, int index) {
                final T suggestion = _suggestions[index];
                return widget.suggestionBuilder != null
                    ? widget.suggestionBuilder!(
                        context,
                        suggestion,
                        _addChip,
                      )
                    : ListTile(
                        key: ObjectKey(suggestion),
                        title: Text(suggestion.toString()),
                        onTap: () => _addChip(suggestion),
                      );
              },
            ),
          ),
      ],
    );
  }

  Future<void> _onSearchChanged(String value) async {
    final List<T> results = await widget.suggestionCallback(value);
    setState(() {
      _suggestions = results.where((T suggestion) => !_values.contains(suggestion)).toList();
    });
  }

  void _onValuesChanged(List<T> newValues) {
    setState(() {
      _values = List<T>.from(newValues);
      widget.onValuesChanged(_values);
    });
  }

  void _onChipDeleted(String value) {
    setState(() {
      _values.remove(value);
    });
  }

  void _onSubmitted(String value) {
    if (value.trim().isNotEmpty) {
      _addChip(value as T);
    }
    _controller.clear();
  }

  void _addChip(T value) {
    setState(() {
      if (!_values.contains(value)) {
        _values.add(value);
        widget.onValuesChanged(_values);
      }
      _suggestions = [];
    });
  }

}

class ChipsInput<T> extends StatefulWidget {
  const ChipsInput({
    super.key,
    required this.values,
    this.decoration = const InputDecoration(),
    this.style,
    this.strutStyle,
    required this.chipBuilder,
    required this.onChanged,
    this.onChipTapped,
    this.onSubmitted,
    this.onTextChanged,
  });

  final List<T> values;
  final InputDecoration decoration;
  final TextStyle? style;
  final StrutStyle? strutStyle;

  final ValueChanged<List<T>> onChanged;
  final ValueChanged<T>? onChipTapped;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onTextChanged;

  final Widget Function(BuildContext context, T data) chipBuilder;

  @override
  ChipsInputState<T> createState() => ChipsInputState<T>();
}

class ChipsInputState<T> extends State<ChipsInput<T>> {
  @visibleForTesting
  late final ChipsInputEditingController<T> controller;

  String _previousText = '';
  TextSelection? _previousSelection;

  @override
  void initState() {
    super.initState();

    controller = ChipsInputEditingController<T>(
      <T>[...widget.values],
      widget.chipBuilder,
    );
    controller.addListener(_textListener);
  }

  @override
  void dispose() {
    controller.removeListener(_textListener);
    controller.dispose();

    super.dispose();
  }

  void _textListener() {
    final String currentText = controller.text;

    if (_previousSelection != null) {
      final int currentNumber = countReplacements(currentText);
      final int previousNumber = countReplacements(_previousText);

      final int cursorEnd = _previousSelection!.extentOffset;
      final int cursorStart = _previousSelection!.baseOffset;

      final List<T> values = <T>[...widget.values];

      // If the current number and the previous number of replacements are different, then
      // the user has deleted the InputChip using the keyboard. In this case, we trigger
      // the onChanged callback. We need to be sure also that the current number of
      // replacements is different from the input chip to avoid double-deletion.
      if (currentNumber < previousNumber && currentNumber != values.length) {
        if (cursorStart == cursorEnd) {
          values.removeRange(cursorStart - 1, cursorEnd);
        } else {
          if (cursorStart > cursorEnd) {
            values.removeRange(cursorEnd, cursorStart);
          } else {
            values.removeRange(cursorStart, cursorEnd);
          }
        }
        widget.onChanged(values);
      }
    }

    _previousText = currentText;
    _previousSelection = controller.selection;
  }

  static int countReplacements(String text) {
    return text.codeUnits
        .where(
            (int u) => u == ChipsInputEditingController.kObjectReplacementChar)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    controller.updateValues(<T>[...widget.values]);

    return TextField(
      minLines: 1,
      maxLines: 10,
      textInputAction: TextInputAction.done,
      style: widget.style,
      strutStyle: widget.strutStyle,
      controller: controller,
      onChanged: (String value) =>
          widget.onTextChanged?.call(controller.textWithoutReplacements),
      onSubmitted: (String value) =>
          widget.onSubmitted?.call(controller.textWithoutReplacements),
      decoration: InputDecoration(
          hintStyle: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.4),
          ),
          fillColor: const Color.fromRGBO(255, 255, 255, 0.06),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
    );
  }
}

class ChipsInputEditingController<T> extends TextEditingController {
  ChipsInputEditingController(this.values, this.chipBuilder)
      : super(
          text: String.fromCharCode(kObjectReplacementChar) * values.length,
        );

  // This constant character acts as a placeholder in the TextField text value.
  // There will be one character for each of the InputChip displayed.
  static const int kObjectReplacementChar = 0xFFFE;

  List<T> values;

  final Widget Function(BuildContext context, T data) chipBuilder;

  /// Called whenever chip is either added or removed
  /// from the outside the context of the text field.
  void updateValues(List<T> values) {
    if (values.length != this.values.length) {
      final String char = String.fromCharCode(kObjectReplacementChar);
      final int length = values.length;
      value = TextEditingValue(
        text: char * length,
        selection: TextSelection.collapsed(offset: length),
      );
      this.values = values;
    }
  }

  String get textWithoutReplacements {
    final String char = String.fromCharCode(kObjectReplacementChar);
    return text.replaceAll(RegExp(char), '');
  }

  String get textWithReplacements => text;

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    final Iterable<WidgetSpan> chipWidgets =
        values.map((T v) => WidgetSpan(child: chipBuilder(context, v)));

    return TextSpan(
      style: style,
      children: <InlineSpan>[
        ...chipWidgets,
        if (textWithoutReplacements.isNotEmpty)
          TextSpan(text: textWithoutReplacements)
      ],
    );
  }
}
