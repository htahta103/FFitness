import '/flutter_flow/flutter_flow_util.dart';
import 'training_detail_widget.dart' show TrainingDetailWidget;
import 'package:flutter/material.dart';

class TrainingDetailModel extends FlutterFlowModel<TrainingDetailWidget> {
  ///  Local state fields for this page.

  int? currentTab = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
