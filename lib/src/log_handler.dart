import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:talker/talker.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:toastification/toastification.dart';

import '../jlt_app_log_handler.dart';

class Success extends TalkerLog {
  Success(super.message);


  /// Log title
  static String get getTitle => 'success';

  /// Log key
  static String get getKey => 'success';

  /// Log color
  static AnsiPen get getPen => AnsiPen()..green();

  /// The following overrides are required because the base class expects instance getters,
  /// but we use static getters to allow for easy customization and reuse of colors, titles, and keys.
  /// This approach works around limitations in the base class API, which does not support passing custom values
  /// directly to the constructor or as parameters, so we override the instance getters to return the static values.
  @override
  String get title => getTitle;

  @override
  String get key => getKey;

  @override
  AnsiPen get pen => getPen;
}

class LogHandler {
  LogHandler._internal();

  static final LogHandler _instance = LogHandler._internal();

  /// Use `LogHandler()` or `LogHandler.instance` to get the singleton.
  factory LogHandler() => _instance;
  static LogHandler get instance => _instance;


  final talker = TalkerFlutter.init();

  String scID = "fltt_el_";
  String scIDSeparator = "|";

  String success({required String message, dynamic longMessage, String? callingFunctionLogID, bool showToast = false}) {
    showToast ? toast(type: ToastificationType.success, title: message) : {};
    talker.logCustom(Success("${callingFunctionLogID != null? "$callingFunctionLogID $scIDSeparator " : ""}${message.toString()}${longMessage != null? "\n\nlongMessage: ${_handleLongMessage(longMessage)}" : ""}"));

    return message;
  }

  String info({required String message, dynamic longMessage, String? callingFunctionLogID, bool showToast = false}) {
    showToast ? toast(type: ToastificationType.info, title: message) : {};
    talker.info("${callingFunctionLogID != null? "$callingFunctionLogID $scIDSeparator " : ""}${message.toString()}${longMessage != null? "\n\nlongMessage: ${_handleLongMessage(longMessage)}" : ""}");

    return message;
  }

  String debug({required String message, dynamic longMessage, String? callingFunctionLogID, bool showToast = false}) {
    showToast ? toast(type: ToastificationType.info, title: message) : {};
    kDebugMode ? talker.debug("${callingFunctionLogID != null? "$callingFunctionLogID $scIDSeparator " : ""}${message.toString()}${longMessage != null? "\n\nlongMessage: ${_handleLongMessage(longMessage)}" : ""}") : {};

    return message;
  }

  String error({required e, StackTrace? stackTrace, dynamic longMessage, String? callingFunctionLogID, bool showToast = true}) {
    showToast ? toast(type: ToastificationType.error, title: e.toString()) : {};
    talker.error("${callingFunctionLogID != null? "$callingFunctionLogID $scIDSeparator " : ""}$e${longMessage != null? "\n\nlongMessage: ${_handleLongMessage(longMessage)}" : ""}\n\nStackTrace: $stackTrace");

    return e.toString();
  }

  String _handleLongMessage(dynamic longMessage) {
    if (longMessage is String) {
      return longMessage;
    } else if (longMessage is Map || longMessage is List) {
      return _prettyJson(longMessage);
    } else if (longMessage != null) {
      return longMessage.toString();
    }
    return "";
  }

  String _prettyJson(dynamic json) {
    var spaces = ' ' * 4;
    var encoder = JsonEncoder.withIndent(spaces);
    return encoder.convert(json);
  }

  void toast({required ToastificationType type, required String title, String? description, Duration? durationOverride, bool? neverExpires}) {
    Toastification().show(type: type, title: Text(title), description: description != null ? Text(description) : null, autoCloseDuration: neverExpires == null ? durationOverride ?? Duration(seconds: 3) : null );
  }
}