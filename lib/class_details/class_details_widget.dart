import '/auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'class_details_model.dart';
export 'class_details_model.dart';

class ClassDetailsWidget extends StatefulWidget {
  const ClassDetailsWidget({
    Key? key,
    this.clas,
  }) : super(key: key);

  final DocumentReference? clas;

  @override
  _ClassDetailsWidgetState createState() => _ClassDetailsWidgetState();
}

class _ClassDetailsWidgetState extends State<ClassDetailsWidget>
    with TickerProviderStateMixin {
  late ClassDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  final animationsMap = {
    'iconOnPageLoadAnimation': AnimationInfo(
      loop: true,
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        RotateEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 5000.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnPageLoadAnimation': AnimationInfo(
      loop: true,
      reverse: true,
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 2000.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassDetailsModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ClassesRecord>(
      stream: ClassesRecord.getDocument(widget.clas!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 210.0,
              height: 210.0,
              child: SpinKitRipple(
                color: Color(0xFF59FF92),
                size: 210.0,
              ),
            ),
          );
        }
        final classDetailsClassesRecord = snapshot.data!;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).customColor4,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).customColor4,
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () async {
                context.pop();
              },
            ),
            title: Text(
              'CLASS DETAIL\'S',
              style: FlutterFlowTheme.of(context).title2,
            ),
            actions: [],
            centerTitle: true,
            elevation: 2.0,
          ),
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
              child: FutureBuilder<ApiCallResponse>(
                future: (_model.apiRequestCompleter ??=
                        Completer<ApiCallResponse>()..complete(NameCall.call()))
                    .future,
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 210.0,
                        height: 210.0,
                        child: SpinKitRipple(
                          color: Color(0xFF59FF92),
                          size: 210.0,
                        ),
                      ),
                    );
                  }
                  final columnMainContentNameResponse = snapshot.data!;
                  return RefreshIndicator(
                    onRefresh: () async {
                      setState(() => _model.apiRequestCompleter = null);
                      await _model.waitForApiRequestCompleter();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 20.0, 20.0, 0.0),
                                  child: Container(
                                    width: 100.0,
                                    height: 213.3,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .customColor4,
                                      borderRadius: BorderRadius.circular(50.0),
                                      border: Border.all(
                                        color: Color(0xFF1D2429),
                                        width: 3.0,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image.network(
                                        valueOrDefault<String>(
                                          classDetailsClassesRecord.image,
                                          'https://www.htmlcsscolor.com/preview/gallery/090F13.png',
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1.0,
                                        height: 230.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 12.0, 20.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    classDetailsClassesRecord.name!,
                                    style: FlutterFlowTheme.of(context)
                                        .title2
                                        .override(
                                          fontFamily: 'Aldrich',
                                          fontSize: 30.0,
                                          letterSpacing: 2.0,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                ),
                                if (valueOrDefault(
                                        currentUserDocument?.role, '') ==
                                    'Professor')
                                  AuthUserStreamWidget(
                                    builder: (context) => Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (classDetailsClassesRecord
                                                .startDate! <
                                            getCurrentTimestamp)
                                          FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 30.0,
                                            borderWidth: 1.0,
                                            buttonSize: 40.0,
                                            icon: Icon(
                                              Icons.mode_edit,
                                              color: Colors.white,
                                              size: 20.0,
                                            ),
                                            onPressed: () async {
                                              context.pushNamed(
                                                'EditClass',
                                                queryParams: {
                                                  'classes': serializeParam(
                                                    classDetailsClassesRecord
                                                        .reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  kTransitionInfoKey:
                                                      TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                        PageTransitionType.fade,
                                                    duration: Duration(
                                                        milliseconds: 0),
                                                  ),
                                                },
                                              );
                                            },
                                          ),
                                        FlutterFlowIconButton(
                                          borderColor: Colors.transparent,
                                          borderRadius: 30.0,
                                          borderWidth: 1.0,
                                          buttonSize: 40.0,
                                          icon: Icon(
                                            Icons.delete,
                                            color: Color(0xFF59FF92),
                                            size: 20.0,
                                          ),
                                          onPressed: () async {
                                            var confirmDialogResponse =
                                                await showDialog<bool>(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              ' Do You Want To Delete This Class ?'),
                                                          content: Text(
                                                              'You Will Lose The Record'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext,
                                                                      false),
                                                              child: Text(
                                                                  ' Cancel'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext,
                                                                      true),
                                                              child: Text(
                                                                  'Confirm'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ) ??
                                                    false;
                                            if (confirmDialogResponse) {
                                              context.pushNamed(
                                                'Home',
                                                extra: <String, dynamic>{
                                                  kTransitionInfoKey:
                                                      TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                        PageTransitionType
                                                            .bottomToTop,
                                                    duration: Duration(
                                                        milliseconds: 300),
                                                  ),
                                                },
                                              );

                                              await classDetailsClassesRecord
                                                  .reference
                                                  .delete();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 4.0, 20.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 5.0, 0.0),
                                  child: InkWell(
                                    onTap: () async {
                                      context.goNamed(
                                        'teamDetails',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                            duration:
                                                Duration(milliseconds: 600),
                                          ),
                                        },
                                      );
                                    },
                                    child: Icon(
                                      Icons.access_time,
                                      color: FlutterFlowTheme.of(context).white,
                                      size: 24.0,
                                    ),
                                  ).animateOnPageLoad(animationsMap[
                                      'iconOnPageLoadAnimation']!),
                                ),
                                Text(
                                  dateTimeFormat('d/M h:mm a',
                                      classDetailsClassesRecord.startDate!),
                                  style: FlutterFlowTheme.of(context)
                                      .subtitle1
                                      .override(
                                        fontFamily: 'Aldrich',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                        useGoogleFonts: false,
                                      ),
                                ),
                                Text(
                                  ' - ',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Aldrich',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                        useGoogleFonts: false,
                                      ),
                                ),
                                Expanded(
                                  child: Text(
                                    dateTimeFormat('d/M h:mm a',
                                        classDetailsClassesRecord.endDate!),
                                    style: FlutterFlowTheme.of(context)
                                        .subtitle1
                                        .override(
                                          fontFamily: 'Aldrich',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 12.0, 20.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    classDetailsClassesRecord.description!,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'Aldrich',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 12.0, 20.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    classDetailsClassesRecord.category!,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Aldrich',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (classDetailsClassesRecord.startDate! >
                              getCurrentTimestamp)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 12.0, 20.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'The Class Hasn\'t Started Yet !',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Aldrich',
                                            color: Color(0xFF59FF92),
                                            useGoogleFonts: false,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (classDetailsClassesRecord.endDate! <
                              getCurrentTimestamp)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 12.0, 20.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'The Class Has Been Finished !',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Aldrich',
                                            color: FlutterFlowTheme.of(context)
                                                .customColor3,
                                            useGoogleFonts: false,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (!classDetailsClassesRecord.students!
                                  .toList()
                                  .contains(currentUserUid) &&
                              (valueOrDefault(currentUserDocument?.role, '') ==
                                  'Student') &&
                              (classDetailsClassesRecord.endDate! >
                                  getCurrentTimestamp) &&
                              (classDetailsClassesRecord.startDate! <
                                  getCurrentTimestamp))
                            AuthUserStreamWidget(
                              builder: (context) => Container(
                                width: 140.0,
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: Color(0x00090F13),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 200.0,
                                      color: Color(0xFF59FF92),
                                      offset: Offset(0.0, 2.0),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(
                                    color: Color(0xFF59FF92),
                                    width: 3.0,
                                  ),
                                ),
                                child: Visibility(
                                  visible: !classDetailsClassesRecord.students!
                                          .toList()
                                          .contains(currentUserUid) &&
                                      (valueOrDefault(
                                              currentUserDocument?.role, '') ==
                                          'Student') &&
                                      (classDetailsClassesRecord.endDate! >
                                          getCurrentTimestamp) &&
                                      (classDetailsClassesRecord.startDate! <
                                          getCurrentTimestamp),
                                  child: FutureBuilder<ApiCallResponse>(
                                    future: NameCall.call(),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 210.0,
                                            height: 210.0,
                                            child: SpinKitRipple(
                                              color: Color(0xFF59FF92),
                                              size: 210.0,
                                            ),
                                          ),
                                        );
                                      }
                                      final buttonPrimaryNameResponse =
                                          snapshot.data!;
                                      return InkWell(
                                        onDoubleTap: () async {
                                          if (currentUserDisplayName ==
                                              '${getJsonField(
                                                buttonPrimaryNameResponse
                                                    .jsonBody,
                                                r'''$..[2]''',
                                              ).toString()}') {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'the staement is true',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    Color(0x00000000),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'the staement is false',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    Color(0x00000000),
                                              ),
                                            );
                                          }
                                        },
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            final classesUpdateData = {
                                              'students': FieldValue.arrayUnion(
                                                  [currentUserUid]),
                                            };
                                            await classDetailsClassesRecord
                                                .reference
                                                .update(classesUpdateData);

                                            final attendancesCreateData =
                                                createAttendancesRecordData(
                                              studentName:
                                                  currentUserDisplayName,
                                              studentEmail: currentUserEmail,
                                              attendanceTime:
                                                  getCurrentTimestamp,
                                            );
                                            await AttendancesRecord.createDoc(
                                                    classDetailsClassesRecord
                                                        .reference)
                                                .set(attendancesCreateData);
                                          },
                                          text: 'JOIN',
                                          options: FFButtonOptions(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .customColor4,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .title3
                                                    .override(
                                                      fontFamily: 'Aldrich',
                                                      color: Color(0xFF59FF92),
                                                      letterSpacing: 5.0,
                                                      useGoogleFonts: false,
                                                    ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ).animateOnPageLoad(animationsMap[
                                  'containerOnPageLoadAnimation']!),
                            ),
                          if (classDetailsClassesRecord.startDate! <
                              getCurrentTimestamp)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 20.0, 20.0, 5.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Student\'s who attended:',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Aldrich',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                  Text(
                                    classDetailsClassesRecord.students!
                                        .toList()
                                        .length
                                        .toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Aldrich',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                  Text(
                                    '/',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Aldrich',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                  StreamBuilder<List<UsersRecord>>(
                                    stream: queryUsersRecord(
                                      queryBuilder: (usersRecord) =>
                                          usersRecord.where('role',
                                              isEqualTo: 'Estudiante'),
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 210.0,
                                            height: 210.0,
                                            child: SpinKitRipple(
                                              color: Color(0xFF59FF92),
                                              size: 210.0,
                                            ),
                                          ),
                                        );
                                      }
                                      List<UsersRecord> textUsersRecordList =
                                          snapshot.data!;
                                      return Text(
                                        '84',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Aldrich',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBtnText,
                                              fontWeight: FontWeight.bold,
                                              useGoogleFonts: false,
                                            ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          if (classDetailsClassesRecord.startDate! <
                              getCurrentTimestamp)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 20.0, 0.0),
                              child: StreamBuilder<List<AttendancesRecord>>(
                                stream: queryAttendancesRecord(
                                  parent: classDetailsClassesRecord.reference,
                                  queryBuilder: (attendancesRecord) =>
                                      attendancesRecord
                                          .orderBy('attendanceTime'),
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 210.0,
                                        height: 210.0,
                                        child: SpinKitRipple(
                                          color: Color(0xFF59FF92),
                                          size: 210.0,
                                        ),
                                      ),
                                    );
                                  }
                                  List<AttendancesRecord>
                                      columnAttendancesRecordList =
                                      snapshot.data!;
                                  if (columnAttendancesRecordList.isEmpty) {
                                    return EmptyWidget();
                                  }
                                  return SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: List.generate(
                                          columnAttendancesRecordList.length,
                                          (columnIndex) {
                                        final columnAttendancesRecord =
                                            columnAttendancesRecordList[
                                                columnIndex];
                                        return RefreshIndicator(
                                          onRefresh: () async {
                                            setState(() => _model
                                                .apiRequestCompleter = null);
                                            await _model
                                                .waitForApiRequestCompleter();
                                          },
                                          child: ListView(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            children: [
                                              Container(
                                                width: 100.0,
                                                height: 40.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .customColor4,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  5.0,
                                                                  0.0),
                                                      child: Icon(
                                                        Icons.person,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .white,
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                    Text(
                                                      columnAttendancesRecord
                                                          .studentName!,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Aldrich',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBtnText,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                    ),
                                                    Text(
                                                      '  - ',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Aldrich',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBtnText,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                    ),
                                                    Text(
                                                      dateTimeFormat(
                                                          'jms',
                                                          columnAttendancesRecord
                                                              .attendanceTime!),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Aldrich',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBtnText,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
