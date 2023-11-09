// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom widgets

import 'dart:math';

class TextPickerWidget extends StatefulWidget {
  const TextPickerWidget({
    Key? key,
    this.width,
    this.height,
    required this.initialValue,
    this.extraText,
    required this.rebuildPageAction,
    required this.data,
    this.mode,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String initialValue;
  final String? extraText;
  final Future<dynamic> Function() rebuildPageAction;
  final List<String> data;
  final String? mode;

  @override
  _TextPickerWidgetState createState() => _TextPickerWidgetState();
}

class _TextPickerWidgetState extends State<TextPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return TextPicker(
      initialValue: widget.initialValue,
      data: widget.data,
      extraText: widget.extraText,
      height: 80,
      width: double.maxFinite,
      subColor: Color.fromRGBO(80, 80, 80, 1),
      onChanged: (i) => setState(() {
        print(i);
        if ((widget.mode ?? 'goal') == 'goal') {
          FFAppState().goal = i;
        }
        if ((widget.mode ?? 'goal') == 'activity') {
          FFAppState().activityLevel = i;
        }
      }),
      otherItemsTextStyle: TextStyle(
          fontSize: 24, color: FlutterFlowTheme.of(context).primaryText),
      otherItemsDecoration: BoxDecoration(
          border: Border.all(width: 0, color: Colors.transparent)),
      pickedItemDecoration: BoxDecoration(border: Border()),
      pickedItemTextStyle: TextStyle(
          fontSize: 28, color: FlutterFlowTheme.of(context).primaryText),
    );
  }
}

class TextPicker extends StatefulWidget {
  /// Selected value for Start position - #initialValue cant be bigger than #maxValue and cant be smaller than #minValue
  final String? initialValue;

  /// if user interaction picker this methods return selected value
  final ValueChanged<String> onChanged;

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
  final List<String> data;

  const TextPicker(
      {Key? key,
      required this.initialValue,
      required this.data,
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
      : super(key: key);

  @override
  State<TextPicker> createState() => _TextPickerState();
}

class _TextPickerState extends State<TextPicker> {
  late FixedExtentScrollController _controller;
  late String returnValue;
  late List<String> data;
  @override
  void initState() {
    super.initState();
    data = widget.data;
    returnValue = widget.initialValue ?? widget.data[0];
    int inititalIndex = widget.data.indexOf(returnValue);
    _controller = FixedExtentScrollController(
        initialItem: inititalIndex == -1 ? 0 : inititalIndex);
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
          widget.onChanged(data[value]);
          setState(() {
            returnValue = data[value];
          });
        }),
        physics: const BouncingScrollPhysics(),
        perspective: 0.005,
        itemExtent: widget.height ?? 40,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: data.length,
          builder: (c, i) => i == data.indexOf(returnValue)
              ? Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: widget.padding ?? 0),
                  width: widget.width ?? 40,
                  decoration: widget.pickedItemDecoration ?? pickedItemStyle,
                  child: Transform.rotate(
                    angle: widget.axis == Axis.vertical || widget.axis == null
                        ? 0
                        : pi / 2,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            color: Color(0xffd0fd3e),
                            width: 247,
                            height: 3,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text((data[i]).toString(),
                                    textAlign: TextAlign.center,
                                    style: widget.pickedItemTextStyle ??
                                        pickedItemTextStyle),
                                widget.extraText != null
                                    ? Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Text(
                                            (widget.extraText).toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 17)),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                          Container(
                            color: Color(0xffd0fd3e),
                            width: 247,
                            height: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Stack(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: widget.padding ?? 0),
                      width: widget.width ?? 40,
                      decoration:
                          widget.otherItemsDecoration ?? otherItemsStyle,
                      child: Transform.rotate(
                        angle:
                            widget.axis == Axis.vertical || widget.axis == null
                                ? 0
                                : pi / 2,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                (data[i]).toString(),
                                textAlign: TextAlign.center,
                                style: (widget.otherItemsTextStyle ??
                                        otherItemsTextStyle)
                                    .merge(TextStyle(
                                        color: (data.indexOf(returnValue) - i)
                                                    .abs() >
                                                1
                                            ? widget.subColor
                                            : null)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
