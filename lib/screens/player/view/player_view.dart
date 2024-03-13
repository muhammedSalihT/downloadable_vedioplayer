import 'dart:developer';
import 'dart:io';

import 'package:downloadeble_videoplayer/constents/app_colors.dart';
import 'package:downloadeble_videoplayer/screens/player/view_model/player_viewmodel.dart';
import 'package:downloadeble_videoplayer/screens/player/widgets/custom_player_control_widget.dart';
import 'package:downloadeble_videoplayer/screens/profile/view/profile_view.dart';
import 'package:downloadeble_videoplayer/screens/profile/viewmodel/profile_provider.dart';
import 'package:downloadeble_videoplayer/services/secure_store_service.dart';
import 'package:downloadeble_videoplayer/utils/app_navigation.dart';
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
    final profilePro = Provider.of<ProfileProvider>(context, listen: false);
    profilePro.getProfileData();
    playerPro.initializeVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerProvider>(builder: (context, playerPro, _) {
      return Scaffold(
        key: AppNavigation.drawerKey,
        drawer: const CustomDrawerWidget(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                FlickVideoPlayer(
                  flickManager: playerPro.flickManager,
                  systemUIOverlay: const [],
                  flickVideoWithControls: const FlickVideoWithControls(
                    controls: CustomPlayerControlWidget(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      log('message');
                      AppNavigation.drawerKey.currentState?.openDrawer();
                    },
                    child: const RefractedSvgWidgte(
                      svgPath: 'assets/images/Group 1.svg',
                    ),
                  ),
                ),
                Consumer<ProfileProvider>(builder: (context, profilePro, _) {
                  return Positioned(
                      right: 0,
                      child: InkWell(
                        onTap: () => AppNavigation.push(
                            context: context,
                            newRoute: AppNavigation.createCustomRoute(
                                page: const ProfileView(),
                                transitionType: TransitionType.slideRight)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: profilePro.fileImage?.path != ''
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.file(
                                    File(profilePro.fileImage?.path ?? ''),
                                    height: 35.h,
                                    width: 35.h,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(
                                  Icons.account_circle_rounded,
                                  size: 30.sp,
                                ),
                        ),
                      ));
                })
              ],
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
                        color: playerPro.themeMode == ThemeMode.light
                            ? AppColors.appWhite
                            : AppColors.appBlack),
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
                                        : playerPro.themeMode == ThemeMode.light
                                            ? AppColors.appBlack
                                            : AppColors.appMainColor,
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

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 100.w),
      child: Scaffold(
        appBar: AppBar(
            title: const RefractedTextWidget(
              text: 'Menu',
            ),
            automaticallyImplyLeading: false,
            centerTitle: true),
        body: Consumer<PlayerProvider>(builder: (context, playerPro, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: CustomMenuTileWidget(
                      text: "Theme",
                      onTap: () {
                        playerPro.chnageThemeModel();
                      },
                      themeIcon: Icon(
                        playerPro.themeMode == ThemeMode.light
                            ? Icons.light_mode
                            : Icons.dark_mode,
                        size: 35.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: CustomMenuTileWidget(
                      text: "Profile",
                      onTap: () {
                        AppNavigation.push(
                            context: context,
                            newRoute: AppNavigation.createCustomRoute(
                                page: const ProfileView(),
                                transitionType: TransitionType.slideRight));
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30.0,
                    ),
                    child: CustomMenuTileWidget(
                      text: "Logout",
                      onTap: () async {
                        await SecureStoreService.logOutUser();
                        UtilWidgets.getToast(showText: 'Logout Successfully');
                        // UtilWidgets.refractedOpenDialogBox(
                        //   context: context,
                        //   child: const RefractedLogoutDeleteDialogWidget(
                        //       title: 'Are you sure want to logout ?',
                        //       buttonTitle: 'Logout'),
                        // );
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 30.0, bottom: 20),
                  //   child: CustomMenuTileWidget(
                  //     text: "Delete Account",
                  //     onTap: () {
                  //       UtilWidgets.refractedOpenDialogBox(
                  //         context: context,
                  //         child: const RefractedLogoutDeleteDialogWidget(
                  //             title: 'Are you sure want to delete account ?',
                  //             buttonTitle: 'Delete'),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class CustomMenuTileWidget extends StatelessWidget {
  const CustomMenuTileWidget({
    Key? key,
    required this.text,
    this.onTap,
    this.themeIcon,
  }) : super(key: key);

  final String text;
  final Function()? onTap;
  final Widget? themeIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RefractedTextWidget(
            text: text,
            isSubText: true,
          ),
          themeIcon ??
              Icon(
                Icons.arrow_circle_right_outlined,
                color: AppColors.appMainColor,
                size: 35.sp,
              ),
        ],
      ),
    );
  }
}
