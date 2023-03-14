import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_media.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'edit_class_model.dart';
export 'edit_class_model.dart';

class EditClassWidget extends StatefulWidget {
  const EditClassWidget({
    Key? key,
    this.classes,
  }) : super(key: key);

  final DocumentReference? classes;

  @override
  _EditClassWidgetState createState() => _EditClassWidgetState();
}

class _EditClassWidgetState extends State<EditClassWidget>
    with TickerProviderStateMixin {
  late EditClassModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  final animationsMap = {
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
    _model = createModel(context, () => EditClassModel());
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
      stream: ClassesRecord.getDocument(widget.classes!),
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
        final editClassClassesRecord = snapshot.data!;
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
              'EDIT CLASSROOM',
              style: FlutterFlowTheme.of(context).title2.override(
                    fontFamily: 'Aldrich',
                    color: Colors.white,
                    fontSize: 22.0,
                    useGoogleFonts: false,
                  ),
            ),
            actions: [],
            centerTitle: true,
            elevation: 2.0,
          ),
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Form(
                      key: _model.formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 20.0, 20.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
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
                                    child: InkWell(
                                      onTap: () async {
                                        final selectedMedia =
                                            await selectMediaWithSourceBottomSheet(
                                          context: context,
                                          allowPhoto: true,
                                        );
                                        if (selectedMedia != null &&
                                            selectedMedia.every((m) =>
                                                validateFileFormat(
                                                    m.storagePath, context))) {
                                          setState(() =>
                                              _model.isMediaUploading = true);
                                          var selectedUploadedFiles =
                                              <FFUploadedFile>[];
                                          var downloadUrls = <String>[];
                                          try {
                                            showUploadMessage(
                                              context,
                                              'Uploading file...',
                                              showLoading: true,
                                            );
                                            selectedUploadedFiles =
                                                selectedMedia
                                                    .map((m) => FFUploadedFile(
                                                          name: m.storagePath
                                                              .split('/')
                                                              .last,
                                                          bytes: m.bytes,
                                                          height: m.dimensions
                                                              ?.height,
                                                          width: m.dimensions
                                                              ?.width,
                                                        ))
                                                    .toList();

                                            downloadUrls = (await Future.wait(
                                              selectedMedia.map(
                                                (m) async => await uploadData(
                                                    m.storagePath, m.bytes),
                                              ),
                                            ))
                                                .where((u) => u != null)
                                                .map((u) => u!)
                                                .toList();
                                          } finally {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                            _model.isMediaUploading = false;
                                          }
                                          if (selectedUploadedFiles.length ==
                                                  selectedMedia.length &&
                                              downloadUrls.length ==
                                                  selectedMedia.length) {
                                            setState(() {
                                              _model.uploadedLocalFile =
                                                  selectedUploadedFiles.first;
                                              _model.uploadedFileUrl =
                                                  downloadUrls.first;
                                            });
                                            showUploadMessage(
                                                context, 'Success!');
                                          } else {
                                            setState(() {});
                                            showUploadMessage(context,
                                                'Failed to upload media');
                                            return;
                                          }
                                        }
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        child: Image.network(
                                          valueOrDefault<String>(
                                            editClassClassesRecord.image,
                                            'https://www.htmlcsscolor.com/preview/gallery/090F13.png',
                                          ),
                                          width: 100.0,
                                          height: 200.0,
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
                                  0.0, 10.0, 0.0, 10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _model.textController1 ??=
                                          TextEditingController(
                                        text: editClassClassesRecord.name,
                                      ),
                                      onChanged: (_) => EasyDebounce.debounce(
                                        '_model.textController1',
                                        Duration(milliseconds: 2000),
                                        () => setState(() {}),
                                      ),
                                      autofocus: true,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Name',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Aldrich',
                                              color: Colors.white,
                                              useGoogleFonts: false,
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .background,
                                            width: 3.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF646464),
                                            width: 3.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x5BFFFFFF),
                                            width: 3.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x5BFFFFFF),
                                            width: 3.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .customColor4,
                                        suffixIcon: _model.textController1!.text
                                                .isNotEmpty
                                            ? InkWell(
                                                onTap: () async {
                                                  _model.textController1
                                                      ?.clear();
                                                  setState(() {});
                                                },
                                                child: Icon(
                                                  Icons.clear,
                                                  color: Color(0xFF757575),
                                                  size: 22.0,
                                                ),
                                              )
                                            : null,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Aldrich',
                                            color: Colors.white,
                                            useGoogleFonts: false,
                                          ),
                                      keyboardType: TextInputType.name,
                                      validator: _model.textController1Validator
                                          .asValidator(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _model.textController2 ??=
                                          TextEditingController(
                                        text:
                                            editClassClassesRecord.description,
                                      ),
                                      onChanged: (_) => EasyDebounce.debounce(
                                        '_model.textController2',
                                        Duration(milliseconds: 2000),
                                        () => setState(() {}),
                                      ),
                                      autofocus: true,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Description',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Aldrich',
                                              color: Color(0xFFF3F3F3),
                                              useGoogleFonts: false,
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF1D2429),
                                            width: 3.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF646464),
                                            width: 3.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x5BFFFFFF),
                                            width: 3.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x5BFFFFFF),
                                            width: 3.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .customColor4,
                                        suffixIcon: _model.textController2!.text
                                                .isNotEmpty
                                            ? InkWell(
                                                onTap: () async {
                                                  _model.textController2
                                                      ?.clear();
                                                  setState(() {});
                                                },
                                                child: Icon(
                                                  Icons.clear,
                                                  color: Color(0xFF757575),
                                                  size: 22.0,
                                                ),
                                              )
                                            : null,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Aldrich',
                                            color: Colors.white,
                                            useGoogleFonts: false,
                                          ),
                                      keyboardType: TextInputType.multiline,
                                      validator: _model.textController2Validator
                                          .asValidator(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 5.0, 0.0, 10.0),
                                  child: Text(
                                    'SELECT SUBJECT',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Aldrich',
                                          color: FlutterFlowTheme.of(context)
                                              .white,
                                          letterSpacing: 3.0,
                                          useGoogleFonts: false,
                                          lineHeight: 2.0,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: FlutterFlowDropDown<String>(
                                      initialOption: _model.dropDownValue ??=
                                          editClassClassesRecord.category,
                                      options: [
                                        'MATH',
                                        'AOA',
                                        'OS',
                                        'MUP',
                                        'DBMS'
                                      ],
                                      onChanged: (val) => setState(
                                          () => _model.dropDownValue = val),
                                      width: 180.0,
                                      height: 50.0,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Aldrich',
                                            color: Colors.white,
                                            letterSpacing: 2.0,
                                            useGoogleFonts: false,
                                          ),
                                      hintText: 'SELECT',
                                      fillColor: FlutterFlowTheme.of(context)
                                          .customColor4,
                                      elevation: 2.0,
                                      borderColor: Color(0xFF1D2429),
                                      borderWidth: 3.0,
                                      borderRadius: 50.0,
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          25.0, 0.0, 10.0, 0.0),
                                      hidesUnderline: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 5.0, 0.0, 10.0),
                                  child: Text(
                                    'SELECT START & END DATE',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Aldrich',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                          letterSpacing: 3.0,
                                          useGoogleFonts: false,
                                          lineHeight: 2.0,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 8.0, 0.0),
                                    child: InkWell(
                                      onTap: () async {
                                        final _datePicked1Date =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: getCurrentTimestamp,
                                          firstDate: getCurrentTimestamp,
                                          lastDate: DateTime(2050),
                                        );

                                        TimeOfDay? _datePicked1Time;
                                        if (_datePicked1Date != null) {
                                          _datePicked1Time =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.fromDateTime(
                                                getCurrentTimestamp),
                                          );
                                        }

                                        if (_datePicked1Date != null &&
                                            _datePicked1Time != null) {
                                          setState(() {
                                            _model.datePicked1 = DateTime(
                                              _datePicked1Date.year,
                                              _datePicked1Date.month,
                                              _datePicked1Date.day,
                                              _datePicked1Time!.hour,
                                              _datePicked1Time.minute,
                                            );
                                          });
                                        }
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .customColor4,
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Color(0xFF1D2429),
                                            width: 3.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 5.0, 12.0, 5.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                valueOrDefault<String>(
                                                  dateTimeFormat(
                                                      'M/d h:mm a',
                                                      editClassClassesRecord
                                                          .startDate),
                                                  'Start',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily:
                                                              'Lexend Deca',
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                              Icon(
                                                Icons.date_range_outlined,
                                                color: Colors.white,
                                                size: 24.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 20.0, 0.0, 0.0),
                                        child: InkWell(
                                          onTap: () async {
                                            final _datePicked2Date =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: getCurrentTimestamp,
                                              firstDate: getCurrentTimestamp,
                                              lastDate: DateTime(2050),
                                            );

                                            TimeOfDay? _datePicked2Time;
                                            if (_datePicked2Date != null) {
                                              _datePicked2Time =
                                                  await showTimePicker(
                                                context: context,
                                                initialTime:
                                                    TimeOfDay.fromDateTime(
                                                        getCurrentTimestamp),
                                              );
                                            }

                                            if (_datePicked2Date != null &&
                                                _datePicked2Time != null) {
                                              setState(() {
                                                _model.datePicked2 = DateTime(
                                                  _datePicked2Date.year,
                                                  _datePicked2Date.month,
                                                  _datePicked2Date.day,
                                                  _datePicked2Time!.hour,
                                                  _datePicked2Time.minute,
                                                );
                                              });
                                            }
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            height: 50.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .customColor4,
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              border: Border.all(
                                                color: Color(0xFF1D2429),
                                                width: 3.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 5.0, 12.0, 5.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    valueOrDefault<String>(
                                                      dateTimeFormat(
                                                          'M/d h:mm a',
                                                          editClassClassesRecord
                                                              .endDate),
                                                      'End',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily:
                                                              'Lexend Deca',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .white,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                3.0, 0.0),
                                                    child: Icon(
                                                      Icons.date_range_outlined,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .white,
                                                      size: 24.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 20.0),
                                  child: Container(
                                    width: 140.0,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
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
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        if (_model.datePicked1! <
                                            _model.datePicked2!) {
                                          context.pushNamed(
                                            'Home',
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType
                                                        .rightToLeft,
                                                duration:
                                                    Duration(milliseconds: 300),
                                              ),
                                            },
                                          );

                                          final classesUpdateData =
                                              createClassesRecordData(
                                            name: _model.textController1.text,
                                            startDate: _model.datePicked1,
                                            endDate: _model.datePicked2,
                                            image: _model.uploadedFileUrl,
                                            category: _model.dropDownValue,
                                          );
                                          await editClassClassesRecord.reference
                                              .update(classesUpdateData);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'The start date cannot be greater than the end date.',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                            ),
                                          );
                                        }
                                      },
                                      text: 'SAVE',
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 60.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .customColor4,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily: 'Aldrich',
                                              color: Color(0xFF59FF92),
                                              letterSpacing: 10.0,
                                              useGoogleFonts: false,
                                            ),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                    ),
                                  ).animateOnPageLoad(animationsMap[
                                      'containerOnPageLoadAnimation']!),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
