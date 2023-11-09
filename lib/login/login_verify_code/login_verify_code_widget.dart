import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'login_verify_code_model.dart';
export 'login_verify_code_model.dart';

class LoginVerifyCodeWidget extends StatefulWidget {
  const LoginVerifyCodeWidget({super.key});

  @override
  _LoginVerifyCodeWidgetState createState() => _LoginVerifyCodeWidgetState();
}

class _LoginVerifyCodeWidgetState extends State<LoginVerifyCodeWidget>
    with TickerProviderStateMixin {
  late LoginVerifyCodeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 400.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'textOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 400.ms,
          begin: const Offset(0.0, 10.0),
          end: const Offset(0.0, 0.0),
        ),
      ],
    ),
    'textOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 400.ms,
          begin: const Offset(0.0, 10.0),
          end: const Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginVerifyCodeModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();
    final lottieAnimationController = AnimationController(vsync: this);
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0.00, 1.00),
                            child: ClipRRect(
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0x61000000),
                                      Colors.black,
                                      Colors.black
                                    ],
                                    stops: [0.0, 0.6, 1.0],
                                    begin: AlignmentDirectional(0.0, -1.0),
                                    end: AlignmentDirectional(0, 1.0),
                                  ),
                                ),
                                alignment: const AlignmentDirectional(0.00, 1.00),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(-1.00, 0.00),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            32.0, 56.0, 0.0, 26.0),
                                        child: FlutterFlowIconButton(
                                          borderColor: const Color(0x00CEF138),
                                          borderRadius: 20.0,
                                          borderWidth: 1.0,
                                          buttonSize: 40.0,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                          icon: Icon(
                                            Icons.chevron_left_sharp,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 24.0,
                                          ),
                                          onPressed: () async {
                                            context.safePop();
                                          },
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(-1.00, 0.00),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          'VERIFICATION',
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                fontFamily: 'Figtree',
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ).animateOnPageLoad(animationsMap[
                                            'textOnPageLoadAnimation1']!),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(-1.00, 0.00),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            20.0, 16.0, 0.0, 80.0),
                                        child: Text(
                                          'Check your email. We’ve sent you the PIN at your email.',
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                fontFamily: 'Figtree',
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ).animateOnPageLoad(animationsMap[
                                            'textOnPageLoadAnimation2']!),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 32.0),
                                        child: Form(
                                          key: _model.formKey,
                                          autovalidateMode:
                                              AutovalidateMode.disabled,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: const BoxDecoration(
                                                  color: Color(0x0014181B),
                                                ),
                                              ),
                                              PinCodeTextField(
                                                autoDisposeControllers: false,
                                                appContext: context,
                                                length: 6,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .override(
                                                          fontFamily: 'Figtree',
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                enableActiveFill: false,
                                                autoFocus: true,
                                                enablePinAutofill: true,
                                                errorTextSpace: 14.0,
                                                showCursor: true,
                                                cursorColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                obscureText: false,
                                                hintCharacter: '●',
                                                keyboardType:
                                                    TextInputType.number,
                                                pinTheme: PinTheme(
                                                  fieldHeight: 60.0,
                                                  fieldWidth: 44.0,
                                                  borderWidth: 2.0,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                  shape: PinCodeFieldShape
                                                      .underline,
                                                  activeColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  inactiveColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                  selectedColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  activeFillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  inactiveFillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                  selectedFillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                ),
                                                controller:
                                                    _model.pinCodeController,
                                                onChanged: (_) {},
                                                autovalidateMode:
                                                    AutovalidateMode.disabled,
                                                validator: _model
                                                    .pinCodeControllerValidator
                                                    .asValidator(context),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: Color(0x0014181B),
                                                  ),
                                                ),
                                              ),
                                              Lottie.asset(
                                                'assets/lottie_animations/Animation_-_1699023258395_(1).json',
                                                width: 100.0,
                                                height: 100.0,
                                                fit: BoxFit.cover,
                                                frameRate: FrameRate(60.0),
                                                controller:
                                                    lottieAnimationController,
                                                onLoaded: (composition) =>
                                                    lottieAnimationController
                                                            .duration =
                                                        Duration(
                                                            seconds: composition
                                                                    .durationFrames ~/
                                                                60.0),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: Color(0x0014181B),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: const AlignmentDirectional(
                                                    0.00, 0.00),
                                                child: Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 20.0, 0.0, 32.0),
                                                  child: Text(
                                                    'Try another way',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineMedium
                                                        .override(
                                                          fontFamily: 'Figtree',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          fontSize: 13.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: const AlignmentDirectional(
                                                    1.00, 0.00),
                                                child: Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 0.0, 16.0, 0.0),
                                                  child: FFButtonWidget(
                                                    onPressed: () async {
                                                      await lottieAnimationController
                                                          .forward();
                                                      lottieAnimationController
                                                          .reset();
                                                      await Future.delayed(
                                                          const Duration(
                                                              milliseconds:
                                                                  1500));

                                                      context.pushNamed(
                                                          'loginDefault');
                                                    },
                                                    text: 'Send',
                                                    options: FFButtonOptions(
                                                      width: double.infinity,
                                                      height: 40.0,
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  24.0,
                                                                  13.0,
                                                                  24.0,
                                                                  13.0),
                                                      iconPadding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineLarge
                                                              .override(
                                                                fontFamily:
                                                                    'Figtree',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                fontSize: 17.0,
                                                              ),
                                                      elevation: 3.0,
                                                      borderSide: const BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              48.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ).animateOnPageLoad(
                                animationsMap['containerOnPageLoadAnimation']!),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
