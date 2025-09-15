import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:toastification/toastification.dart';

import '../app_theme.dart';


class LogHandler {
  final talker = Talker();
  
  String scID = "fltt_el_";
  String scIDSeparator = "|";

  success({required String message, dynamic longMessage, String? callingFunctionLogID, bool showToast = false}) {
    showToast ? toast(type: ToastificationType.success, title: message) : {};
    talker.info("${callingFunctionLogID != null? "$callingFunctionLogID $scIDSeparator " : ""}${message.toString()}${longMessage != null? "\n\nlongMessage: ${_handleLongMessage(longMessage)}" : ""}");

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

  error({required e, StackTrace? stackTrace, dynamic longMessage, String? callingFunctionLogID, bool showToast = true}) {
    showToast ? toast(type: ToastificationType.error, title: e.toString()) : {};
    talker.error("${callingFunctionLogID != null? "$callingFunctionLogID $scIDSeparator " : ""}$e${longMessage != null? "\n\nlongMessage: ${_handleLongMessage(longMessage)}" : ""}\n\nStackTrace: $stackTrace");

    return e.toString();
  }




  _handleLongMessage(dynamic longMessage) {
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

  toast({required ToastificationType type, required String title, String? description, Duration? durationOverride, bool? neverExpires}) {
    Toastification().show(type: type, title: Text(title), description: description != null ? Text(description) : null, autoCloseDuration: neverExpires == null ? durationOverride ?? Duration(seconds: 3) : null );
  }
}