// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom widgets

import 'dart:math';

class IntergerPickerWidget extends StatefulWidget {
  const IntergerPickerWidget({
    Key? key,
    this.width,
    this.height,
    required this.minValue,
    required this.maxValue,
    required this.initialValue,
    this.extraText,
    this.mode,
  }) : super(key: key);

  final double? width;
  final double? height;
  final int minValue;
  final int maxValue;
  final int initialValue;
  final String? extraText;
  final String? mode;

  @override
  _IntergerPickerWidgetState createState() => _IntergerPickerWidgetState();
}

class _IntergerPickerWidgetState extends State<IntergerPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return IntegerNumberPicker(
      initialValue: widget.initialValue,
      minValue: widget.minValue,
      maxValue: widget.maxValue,
      extraText: widget.extraText,
      height: 80,
      width: 150,
      subColor: Color.fromRGBO(80, 80, 80, 1),
      onChanged: (i) => setState(() {
        if ((widget.mode ?? 'age') == 'age') FFAppState().selectedAge = i;
        if ((widget.mode ?? 'age') == 'height') FFAppState().selectedHeight = i;
      }),
      otherItemsTextStyle: TextStyle(
          fontSize: 43, color: FlutterFlowTheme.of(context).primaryText),
      otherItemsDecoration: BoxDecoration(
          border: Border.all(width: 0, color: Colors.transparent)),
      pickedItemDecoration: BoxDecoration(
          border: Border(
        top: BorderSide(color: Color(0xffd0fd3e), width: 3),
        bottom: BorderSide(color: Color(0xffd0fd3e), width: 3),
      )),
      pickedItemTextStyle: TextStyle(
          fontSize: 58, color: FlutterFlowTheme.of(context).primaryText),
    );
  }
}

class IntegerNumberPicker extends StatefulWidget {
  /// Selected value for Start position - #initialValue cant be bigger than #maxValue and cant be smaller than #minValue
  final int initialValue;

  /// Min value user can pick - #minValue cant be bigger than #initialValue amd #maxValue
  final int minValue;

  /// Max value user can pick
  final int maxValue;

  /// if user interaction picker this methods return selected value
  final ValueChanged<int> onChanged;

  /// Direction of scrolling.
  final Axis? axis;

  /// height and width of single item for vertical.
  final double? height;
  final double? width;
  final double? padding;
  final String? extraText;

  /// Decoration to apply to picked number where the selected value is placed
  final BoxDecoration? pickedItemDecoration;

  /// Decoration to apply non-picked numbers
  final BoxDecoration? otherItemsDecoration;

  /// Style of picked number. If null, it uses Theme's headline5 with primaryColor
  final TextStyle? pickedItemTextStyle;

  /// Style of non-picked numbers. If null, it uses Theme's bodyText2
  final TextStyle? otherItemsTextStyle;
  final Color? subColor;

  const IntegerNumberPicker(
      {Key? key,
      required this.initialValue,
      required this.minValue,
      required this.maxValue,
      required this.onChanged,
      this.axis,
      this.height,
      this.width,
      this.pickedItemDecoration,
      this.otherItemsDecoration,
      this.pickedItemTextStyle,
      this.otherItemsTextStyle,
      this.padding,
      this.extraText,
      this.subColor})
      : assert(initialValue < maxValue),
        assert(initialValue >= minValue),
        assert(minValue < maxValue),
        super(key: key);

  @override
  State<IntegerNumberPicker> createState() => _IntegerNumberPickerState();
}

class _IntegerNumberPickerState extends State<IntegerNumberPicker> {
  late FixedExtentScrollController _controller;
  late int returnValue;

  @override
  void initState() {
    super.initState();
    returnValue = widget.initialValue - widget.minValue;
    _controller = FixedExtentScrollController(initialItem: returnValue);
  }

  @override
  Widget build(BuildContext context) {
    final pickedItemStyle = BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor, width: 3),
        borderRadius: const BorderRadius.all(Radius.circular(360)));

    final otherItemsStyle = BoxDecoration(
        border: Border.all(color: Theme.of(context).unselectedWidgetColor),
        borderRadius: const BorderRadius.all(Radius.circular(360)));

    final pickedItemTextStyle = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(color: FlutterFlowTheme.of(context).primaryText);
    final otherItemsTextStyle = Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(color: Theme.of(context).unselectedWidgetColor);

    return Transform.rotate(
      angle: widget.axis == Axis.vertical || widget.axis == null ? 0 : -pi / 2,
      child: ListWheelScrollView.useDelegate(
        controller: _controller,
        onSelectedItemChanged: ((value) {
          widget.onChanged(value + widget.minValue);
          setState(() {
            returnValue = value;
          });
        }),
        physics: const BouncingScrollPhysics(),
        perspective: 0.005,
        itemExtent: widget.height ?? 40,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: widget.maxValue - widget.minValue,
          builder: (c, i) => i == returnValue
              ? Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: widget.padding ?? 0),
                  width: widget.width ?? 40,
                  decoration: widget.pickedItemDecoration ?? pickedItemStyle,
                  child: Transform.rotate(
                    angle: widget.axis == Axis.vertical || widget.axis == null
                        ? 0
                        : pi / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Center(
                          child: Text((i + widget.minValue).toString(),
                              textAlign: TextAlign.start,
                              style: widget.pickedItemTextStyle ??
                                  pickedItemTextStyle),
                        ),
                        widget.extraText != null
                            ? Container(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Text((widget.extraText).toString(),
                                    textAlign: TextAlign.center,
                                    style: (widget.pickedItemTextStyle ??
                                            pickedItemTextStyle)
                                        .merge(TextStyle(fontSize: 17))),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                )
              : Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: widget.padding ?? 0),
                  width: widget.width ?? 40,
                  decoration: widget.otherItemsDecoration ?? otherItemsStyle,
                  child: Transform.rotate(
                    angle: widget.axis == Axis.vertical || widget.axis == null
                        ? 0
                        : pi / 2,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            (i + widget.minValue).toString(),
                            textAlign: TextAlign.center,
                            style: (widget.otherItemsTextStyle ??
                                    otherItemsTextStyle)
                                .merge(TextStyle(
                                    color: (returnValue - i).abs() > 1
                                        ? widget.subColor
                                        : null)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
