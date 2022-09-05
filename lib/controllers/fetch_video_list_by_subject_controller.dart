import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:esikshya/db/network/network_calls.dart';
import 'package:esikshya/models/network_models/response/videos_response/fectch_videos_by_class_response.dart';
import 'package:esikshya/models/network_models/response/videos_response/youtube_details_response.dart';
import 'package:esikshya/utils/app_widgets.dart';

class FetchVideoListBySubjectController extends GetxController {
  final NetworkCalls _networkCalls = NetworkCalls();
  var youtubeID = [];
  var youtubeUrl = [];

  var youtubeIdToShow = [].obs;
  var youtubeUrlToshow = [].obs;
  var temp = [].obs;

  @override
  void onClose() {
    youtubeID = [];
    youtubeUrl = [];
    youtubeUrlToshow.value = [];
    youtubeIdToShow.value = [];
    temp.value = [];
    super.onClose();
  }

  Future<List<FetchVideoByClassResponse>?> fetchVideosBySubject(
      BuildContext context, String subjectName, int grade) async {
    try {
      var _response =
          await _networkCalls.fetchVideosBySubjectName(grade, subjectName);
      for (var element in _response) {
        if (youtubeUrl.length != _response.length) {
          youtubeUrl.add(element.url.toString());
        }
      }
      if (youtubeID.length != _response.length) {
        for (var e in youtubeUrl) {
          youtubeID.add(convertUrlToId(e.toString()));
        }
      }
      youtubeIdToShow.value = youtubeID;
      youtubeUrlToshow.value = youtubeUrl;
      if (temp.length != _response.length) {
        for (var e in youtubeUrl) {
          temp.add(await getYoutubeVideoDetails(e.toString()));
        }
      }
      return _response;
    } catch (e) {
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  String? convertUrlToId(var url, {bool trimWhitespaces = true}) {
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }

  getYoutubeVideoDetails(String userUrl) async {
    var _response = await _networkCalls.getYoutubeDetails(userUrl);
    var _responses = YoutubeDetailsResponse.fromJson(_response);
    return _responses;
  }
}
