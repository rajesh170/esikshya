import 'package:get/get.dart';

class OurVideoPlayerController extends GetxController {
  // late VideoPlayerController videoPlayerController;
  // ChewieController? chewieController;
  // late YoutubePlayerController controller;
  // late TextEditingController _idController;
  // late TextEditingController _seekToController;

  // late PlayerState _playerState;
  // late YoutubeMetaData _videoMetaData;
  // double _volume = 100;
  // bool _muted = false;
  // bool _isPlayerReady = false;
  @override
  void onInit() {
 
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // videoPlayerController.dispose();
    // chewieController?.dispose();
    // controller.dispose();
    super.onClose();
  }

  // Future<void> initializePlayer() async {
    // var url = "https://www.youtube.com/watch?v=vQehygKHks0";

    // videoPlayerController = VideoPlayerController.network(url);
    // await Future.wait([videoPlayerController.initialize()]);
    // chewieController = ChewieController(
    //   videoPlayerController: videoPlayerController,
    //   autoPlay: true,
    //   looping: true,
    //   materialProgressColors: ChewieProgressColors(
    //     playedColor: AppColors.lightPink,
    //     handleColor: AppColors.darkBlue,
    //     backgroundColor: AppColors.red,
    //     bufferedColor: AppColors.lightYellow,
    //   ),
    //   placeholder: Container(
    //     color: AppColors.lightGreen,
    //   ),
    //   autoInitialize: true,
    // );
    // controller = YoutubePlayerController(
    //   initialVideoId: "zn2GwbPG-tc",
    //   flags: const YoutubePlayerFlags(
    //     mute: false,
    //     autoPlay: true,
    //     disableDragSeek: false,
    //     loop: false,
    //     isLive: false,
    //     forceHD: false,
    //     enableCaption: true,
    //   ),
    // )..addListener(listener);
    // _idController = TextEditingController();
    // _seekToController = TextEditingController();
    // _videoMetaData = const YoutubeMetaData();
    // _playerState = PlayerState.unknown;
  // }

  // void listener() {
  //   if (_isPlayerReady && !controller.value.isFullScreen) {
  //     _playerState = controller.value.playerState;
  //     _videoMetaData = controller.metadata;
  //   }
  // }
}
