import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'onboarding_gender_model.dart';
export 'onboarding_gender_model.dart';

class OnboardingGenderWidget extends StatefulWidget {
  const OnboardingGenderWidget({Key? key}) : super(key: key);

  @override
  _OnboardingGenderWidgetState createState() => _OnboardingGenderWidgetState();
}

class _OnboardingGenderWidgetState extends State<OnboardingGenderWidget> {
  late OnboardingGenderModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardingGenderModel());
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

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 80.0, 0.0, 0.0),
                    child: Text(
                      'TELL US ABOUT YOURSELF!',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'Figtree',
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                    child: Text(
                      'TO GIVE YOU A BETTER EXPERIENCE WE NEED\nTO KNOW YOUR GENDER',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Figtree',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 44.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              setState(() {
                                FFAppState().selectedGender = 'male';
                              });
                            },
                            child: Container(
                              width: 140.0,
                              height: 140.0,
                              decoration: BoxDecoration(
                                color: FFAppState().selectedGender == 'male'
                                    ? FlutterFlowTheme.of(context).primary
                                    : FlutterFlowTheme.of(context).alternate,
                                shape: BoxShape.circle,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.male_rounded,
                                    color: FFAppState().selectedGender == 'male'
                                        ? FlutterFlowTheme.of(context).info
                                        : FlutterFlowTheme.of(context)
                                            .primaryText,
                                    size: 48.0,
                                  ),
                                  Text(
                                    'Male',
                                    style: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .override(
                                          fontFamily: 'Figtree',
                                          color: FFAppState().selectedGender ==
                                                  'male'
                                              ? FlutterFlowTheme.of(context)
                                                  .info
                                              : FlutterFlowTheme.of(context)
                                                  .primaryText,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            setState(() {
                              FFAppState().selectedGender = 'female';
                            });
                          },
                          child: Container(
                            width: 140.0,
                            height: 140.0,
                            decoration: BoxDecoration(
                              color: FFAppState().selectedGender == 'female'
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).alternate,
                              shape: BoxShape.circle,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.female_rounded,
                                  color: FFAppState().selectedGender == 'female'
                                      ? FlutterFlowTheme.of(context).info
                                      : FlutterFlowTheme.of(context)
                                          .primaryText,
                                  size: 48.0,
                                ),
                                Text(
                                  'Female',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        fontFamily: 'Figtree',
                                        color: FFAppState().selectedGender ==
                                                'female'
                                            ? FlutterFlowTheme.of(context).info
                                            : FlutterFlowTheme.of(context)
                                                .primaryText,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 16.0, 16.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      context.pushNamed(
                        'onboardingAge',
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.rightToLeft,
                          ),
                        },
                      );
                    },
                    text: 'Next',
                    options: FFButtonOptions(
                      width: 110.0,
                      height: 50.0,
                      padding: EdgeInsetsDirectional.fromSTEB(
                          24.0, 13.0, 24.0, 13.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Figtree',
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(48.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
