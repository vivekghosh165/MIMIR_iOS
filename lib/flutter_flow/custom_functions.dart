import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

String? todayDate() {
  // write a code to display current day
  var now = new DateTime.now();
  var formatter = new DateFormat('dd-MM-yyyy');
  String formatted = formatter.format(now);
  return formatted;
}
