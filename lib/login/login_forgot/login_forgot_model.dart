import '/flutter_flow/flutter_flow_util.dart';
import 'login_forgot_widget.dart' show LoginForgotWidget;
import 'package:flutter/material.dart';

class LoginForgotModel extends FlutterFlowModel<LoginForgotWidget> {
  ///  Local state fields for this page.

  String email = '';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for Email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailController;
  String? Function(BuildContext, String?)? emailControllerValidator;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    emailFocusNode?.dispose();
    emailController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
