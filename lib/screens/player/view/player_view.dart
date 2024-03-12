import 'package:downloadeble_videoplayer/screens/player/view_model/player_viewmodel.dart';
import 'package:downloadeble_videoplayer/screens/player/widgets/custom_player_control_widget.dart';
import 'package:downloadeble_videoplayer/utils/refracted_util_widgets.dart';
import 'package:downloadeble_videoplayer/widgets/refracted_svg_widget.dart';
import 'package:downloadeble_videoplayer/widgets/refracted_text_widget.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({super.key});

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  @override
  void initState() {
    final playerPro = Provider.of<PlayerProvider>(context, listen: false);
    playerPro.initializeVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerProvider>(builder: (context, playerPro, _) {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FlickVideoPlayer(
              flickManager: playerPro.flickManager,
              systemUIOverlay: const [],
              flickVideoWithControls: const FlickVideoWithControls(
                controls: CustomPlayerControlWidget(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  3,
                  (index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: index == 1
                          ? InkWell(
                              onTap: playerPro.isVedioDownloading
                                  ? null
                                  : () {
                                      playerPro.downloadAndEncryptVideo(
                                          vedioUrl:
                                              playerPro.driveUploadedVediosList[
                                                  playerPro.currentVedioIndex]);
                                    },
                              child: Row(
                                children: [
                                  playerPro.isVedioDownloading
                                      ? UtilWidgets.refractedLoadingWidget()
                                      : const RefractedSvgWidgte(
                                          svgPath: 'assets/images/Vector 3.svg',
                                        ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.w),
                                    child: RefractedTextWidget(
                                      text: playerPro.isVedioDownloading
                                          ? 'Downloading..'
                                          : 'Download',
                                      textWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                if (index == 0 &&
                                    playerPro.currentVedioIndex != 0) {
                                  playerPro.handleNextOrPrev(
                                      vedioIndex:
                                          playerPro.currentVedioIndex - 1);
                                }

                                if (index == 2 &&
                                    playerPro.currentVedioIndex <
                                        playerPro.driveUploadedVediosList
                                                .length -
                                            1) {
                                  playerPro.handleNextOrPrev(
                                      vedioIndex:
                                          playerPro.currentVedioIndex + 1);
                                }
                              },
                              child: Icon(
                                index == 0
                                    ? Icons.arrow_back_ios_new_rounded
                                    : Icons.arrow_forward_ios_rounded,
                                size: 30.sp,
                                color: index == 0 &&
                                        playerPro.currentVedioIndex == 0
                                    ? Colors.grey
                                    : index == 2 &&
                                            playerPro.currentVedioIndex ==
                                                playerPro
                                                        .driveUploadedVediosList
                                                        .length -
                                                    1
                                        ? Colors.grey
                                        : null,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
