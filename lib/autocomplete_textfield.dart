library autocomplete_textfield;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'src/auto_complete_textfield_state.dart';

part 'src/simple_auto_complete_textfield.dart';

typedef Widget AutoCompleteOverlayItemBuilder<T>(
    BuildContext context, T suggestion);

typedef bool Filter<T>(T suggestion, String query);

typedef InputEventCallback<T>(T data);

typedef StringCallback(String data);

class AutoCompleteTextField<T> extends StatefulWidget {
  final List<T> suggestions;
  final Filter<T> itemFilter;
  final Comparator<T> itemSorter;
  final StringCallback textChanged, textSubmitted;
  final ValueSetter<bool> onFocusChanged;
  final InputEventCallback<T> itemSubmitted;
  final AutoCompleteOverlayItemBuilder<T> itemBuilder;
  final int suggestionsAmount;
  final GlobalKey<AutoCompleteTextFieldState<T>> key;
  final bool submitOnSuggestionTap, clearOnSubmit;
  final List<TextInputFormatter> inputFormatters;
  final int minLength;
  final TextDirection textDirection;
  final TextAlign textAlign;
  final InputDecoration decoration;
  final TextStyle style;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextStyle sugTextStyle;
  final FormFieldValidator<String> validator;

  final bool autovalidate;
  final bool clearAfterSelect;

  AutoCompleteTextField({
    @required
        this.itemSubmitted, //Callback on item selected, this is the item selected of type <T>
    @required this.key, //GlobalKey used to enable addSuggestion etc
    @required this.suggestions, //Suggestions that will be displayed
    @required this.itemBuilder, //Callback to build each item, return a Widget
    @required
        this.itemSorter, //Callback to sort items in the form (a of type <T>, b of type <T>)
    @required
        this.itemFilter, //Callback to filter item: return true or false depending on input text
    this.inputFormatters,
    this.style,
    this.autovalidate = false,
    this.textDirection = TextDirection.ltr,
    this.textAlign = TextAlign.start,
    this.decoration: const InputDecoration(),
    this.textChanged, //Callback on input text changed, this is a string
    this.textSubmitted, //Callback on input text submitted, this is also a string
    this.onFocusChanged,
    this.keyboardType: TextInputType.text,
    this.suggestionsAmount:
        5, //The amount of suggestions to show, larger values may result in them going off screen
    this.submitOnSuggestionTap:
        true, //Call textSubmitted on suggestion tap, itemSubmitted will be called no matter what
    this.clearOnSubmit: true, //Clear autoCompleteTextfield on submit
    this.textInputAction: TextInputAction.done,
    this.textCapitalization: TextCapitalization.sentences,
    this.minLength = 1,
    this.controller,
    this.focusNode,
    this.validator,
    this.sugTextStyle,
    this.clearAfterSelect,
  }) : super(key: key);

  void clear() => key.currentState.clear();

  void addSuggestion(T suggestion) =>
      key.currentState.addSuggestion(suggestion);

  void removeSuggestion(T suggestion) =>
      key.currentState.removeSuggestion(suggestion);

  void updateSuggestions(List<T> suggestions) =>
      key.currentState.updateSuggestions(suggestions);

  void triggerSubmitted() => key.currentState.triggerSubmitted();

  void updateDecoration({
    InputDecoration decoration,
    List<TextInputFormatter> inputFormatters,
    TextCapitalization textCapitalization,
    TextStyle style,
    TextDirection textDirection,
    TextAlign textAlign,
    TextInputType keyboardType,
    TextInputAction textInputAction,
    FormFieldValidator<String> validator,
  }) =>
      key.currentState.updateDecoration(
        decoration: decoration,
        inputFormatters: inputFormatters,
        textCapitalization: textCapitalization,
        style: style,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        textDirection: textDirection,
        textAlign: textAlign,
        validator: validator,
      );

  TextFormField get textField => key.currentState.textField;

  @override
  State<StatefulWidget> createState() => new AutoCompleteTextFieldState<T>(
        suggestions: suggestions,
        textChanged: textChanged,
        textSubmitted: textSubmitted,
        onFocusChanged: onFocusChanged,
        itemSubmitted: itemSubmitted,
        itemBuilder: itemBuilder,
        itemSorter: itemSorter,
        itemFilter: itemFilter,
        suggestionsAmount: suggestionsAmount,
        submitOnSuggestionTap: submitOnSuggestionTap,
        clearOnSubmit: clearOnSubmit,
        minLength: minLength,
        inputFormatters: inputFormatters,
        textCapitalization: textCapitalization,
        decoration: decoration,
        style: style,
        clearAfterSelect: clearAfterSelect,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        controller: controller,
        validator: validator,
        focusNode: focusNode,
        textAlign: textAlign,
        textDirection: textDirection,
        autovalidate: autovalidate,
      );
}
