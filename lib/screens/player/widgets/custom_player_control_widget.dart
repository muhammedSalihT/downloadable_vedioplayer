import 'package:downloadeble_videoplayer/constents/app_colors.dart';
import 'package:downloadeble_videoplayer/screens/player/view_model/player_viewmodel.dart';
import 'package:downloadeble_videoplayer/widgets/refracted_svg_widget.dart';
import 'package:downloadeble_videoplayer/widgets/refracted_text_widget.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CustomPlayerControlWidget extends StatelessWidget {
  const CustomPlayerControlWidget(
      {Key? key, this.iconSize = 20, this.fontSize = 12})
      : super(key: key);
  final double iconSize;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    FlickControlManager controlManager =
        Provider.of<FlickControlManager>(context);
    FlickVideoManager videoManager = Provider.of<FlickVideoManager>(context);
    final playerCtr = Provider.of<PlayerProvider>(context);

    double size = 50;
    Color color = Colors.white;

    Widget playWidget = Icon(
      Icons.play_arrow,
      size: size,
      color: color,
    );

    const List<double> examplePlaybackRates = <double>[
      0.25,
      0.5,
      1.0,
      1.5,
      2.0,
      3.0,
      5.0,
      10.0,
    ];
    Widget pauseWidget = Icon(
      Icons.pause,
      size: size,
      color: color,
    );
    Widget replayWidget = Icon(
      Icons.replay,
      size: size,
      color: color,
    );

    Widget child = videoManager.isVideoEnded
        ? replayWidget
        : videoManager.isPlaying
            ? pauseWidget
            : playWidget;
    return Stack(
      children: <Widget>[
        FlickShowControlsAction(
          child: FlickSeekVideoAction(
            child: Center(
              child: FlickVideoBuffer(
                child: FlickAutoHideChild(
                  showIfVideoNotInitialized: false,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      splashColor: const Color.fromRGBO(108, 165, 242, 0.5),
                      key: key,
                      onTap: () {
                        videoManager.isVideoEnded
                            ? controlManager.replay()
                            : controlManager.togglePlay();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: child,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        FlickAutoHideChild(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 10,
                      spreadRadius: 10)
                ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const FlickPlayToggle(
                      size: 55,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: FlickVideoProgressBar(
                                  flickProgressBarSettings:
                                      FlickProgressBarSettings(
                                    height: 6,
                                    handleRadius: 8,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 0,
                                      vertical: 10,
                                    ),
                                    backgroundColor: const Color(0xff525252),
                                    bufferedColor: const Color(0xff525252),
                                    getPlayedPaint: (
                                        {double? handleRadius,
                                        double? height,
                                        double? playedPart,
                                        double? width}) {
                                      return Paint()
                                        ..shader =
                                            const LinearGradient(colors: [
                                          AppColors.appMainColor
                                        ], stops: [
                                          0.0,
                                        ]).createShader(
                                          Rect.fromPoints(
                                            const Offset(0, 0),
                                            Offset(width!, 0),
                                          ),
                                        );
                                    },
                                    getHandlePaint: (
                                        {double? handleRadius,
                                        double? height,
                                        double? playedPart,
                                        double? width}) {
                                      return Paint()
                                        ..shader = const RadialGradient(
                                          colors: [
                                            Color(0xff525252),
                                            AppColors.appMainColor
                                          ],
                                          stops: [0.4, 0.5],
                                          radius: .6,
                                        ).createShader(
                                          Rect.fromCircle(
                                            center: Offset(
                                                playedPart!, height! / 2),
                                            radius: handleRadius!,
                                          ),
                                        );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              FlickCurrentPosition(
                                fontSize: fontSize,
                              ),
                              const RefractedTextWidget(
                                text: '/',
                                textColor: AppColors.appWhite,
                                textSize: 12,
                                isSubText: true,
                              ),
                              FlickTotalDuration(
                                fontSize: fontSize,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      playerCtr.flickManager.handleChangeVideo(
                                          videoManager.videoPlayerController!);
                                    },
                                    child: RefractedSvgWidgte(
                                      svgPath:
                                          'assets/images/previous_icon.svg',
                                      svgHeight: 13.h,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  RefractedSvgWidgte(
                                    svgPath: 'assets/images/next_icon.svg',
                                    svgHeight: 13.h,
                                  ),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  const FlickSoundToggle(
                                    size: 20,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: PopupMenuButton<double>(
                                      initialValue: videoManager
                                          .videoPlayerController!
                                          .value
                                          .playbackSpeed,
                                      tooltip: 'Playback speed',
                                      onSelected: (double speed) {
                                        controlManager.setPlaybackSpeed(speed);
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return <PopupMenuItem<double>>[
                                          for (final double speed
                                              in examplePlaybackRates)
                                            PopupMenuItem<double>(
                                              value: speed,
                                              child: Text('${speed}x'),
                                            )
                                        ];
                                      },
                                      child: RefractedSvgWidgte(
                                        svgPath:
                                            'assets/images/settings_icon.svg',
                                        svgHeight: 13.h,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  FlickFullScreenToggle(
                                    size: iconSize,
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 20,
          top: 10,
          child: GestureDetector(
            onTap: () {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                  overlays: SystemUiOverlay.values);
              SystemChrome.setPreferredOrientations(
                  [DeviceOrientation.portraitUp]);
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.cancel,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
