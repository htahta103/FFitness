// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:math';

class WeightPickerWidget extends StatefulWidget {
  const WeightPickerWidget({
    Key? key,
    this.width,
    this.height,
    required this.minValue,
    required this.maxValue,
    required this.initialValue,
    this.extraText,
    this.rebuildPageAction,
  }) : super(key: key);

  final double? width;
  final double? height;
  final int minValue;
  final int maxValue;
  final int initialValue;
  final String? extraText;
  final Future<dynamic> Function()? rebuildPageAction;

  @override
  _WeightPickerWidgetState createState() => _WeightPickerWidgetState();
}

class _WeightPickerWidgetState extends State<WeightPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return SpinnerPicker(
      initialValue: widget.initialValue,
      minValue: widget.minValue,
      maxValue: widget.maxValue,
      height: 13,
      width: 150,
      onChanged: (i) {
        FFAppState().selectedWeight = i;
        widget.rebuildPageAction?.call();
        print('SIU - ' + i.toString());
      },
      axis: Axis.horizontal,
      padding: 20,
      otherItemsDecoration: BoxDecoration(border: Border()),
      pickedItemDecoration: BoxDecoration(border: Border()),
    );
  }
}

class SpinnerPicker extends StatefulWidget {
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
  final Color? color;

  /// Decoration to apply to picked number where the selected value is placed
  final BoxDecoration? pickedItemDecoration;

  /// Decoration to apply non-picked numbers
  final BoxDecoration? otherItemsDecoration;

  /// Style of picked number. If null, it uses Theme's headline5 with primaryColor
  final TextStyle? pickedItemTextStyle;

  /// Style of non-picked numbers. If null, it uses Theme's bodyText2
  final TextStyle? otherItemsTextStyle;

  const SpinnerPicker(
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
      this.color})
      : assert(initialValue < maxValue),
        assert(initialValue >= minValue),
        assert(minValue < maxValue),
        super(key: key);

  @override
  State<SpinnerPicker> createState() => _SpinnerPickerState();
}

class _SpinnerPickerState extends State<SpinnerPicker> {
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

    return RotatedBox(
      quarterTurns: -1,
      child: Container(
          child: ListWheelScrollView.useDelegate(
        controller: _controller,
        onSelectedItemChanged: ((value) {
          widget.onChanged(value + widget.minValue);
          setState(() {
            returnValue = value;
          });
        }),
        physics: const FixedExtentScrollPhysics(),
        // perspective: 0.01,
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
                    angle: pi,
                    child: Center(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: widget.width,
                          height: 3,
                          color:
                              widget.color ?? Color.fromRGBO(208, 253, 62, 1),
                          // margin: EdgeInsets.only(right: 10),
                        ),
                      ),
                    ),
                  ))
              : Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: widget.padding ?? 0),
                  width: widget.width ?? 40,
                  decoration: widget.otherItemsDecoration ?? otherItemsStyle,
                  child: Transform.rotate(
                    angle: widget.axis == Axis.vertical || widget.axis == null
                        ? 0
                        : pi,
                    child: Center(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: i % 5 == 0 ? 50 : 30,
                          height: 3,
                          color:
                              widget.color ?? Color.fromRGBO(208, 253, 62, 1),
                          margin: EdgeInsets.only(right: i % 5 == 0 ? 10 : 20),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      )),
    );
  }
}
