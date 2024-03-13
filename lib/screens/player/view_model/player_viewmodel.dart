import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:downloadeble_videoplayer/utils/app_navigation.dart';
import 'package:downloadeble_videoplayer/widgets/refracted_text_widget.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:open_apps_settings/open_apps_settings.dart';
import 'package:open_apps_settings/settings_enum.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class PlayerProvider extends ChangeNotifier {
  late FlickManager flickManager;
  int currentVedioIndex = 0;
  bool isVedioDownloading = false;
  int count = 0;
  ThemeMode themeMode = ThemeMode.light;

  List<String> driveUploadedVediosList = [
    'https://drive.google.com/uc?id=1COsT44G70i0a7XtzumUQ9Xe-hrCnHlJu&export=download',
    'https://drive.google.com/uc?id=1NXff20YfZt4wQjqxlaklT0gdNbBP3jat&export=download',
    'https://drive.google.com/uc?id=1GKdK3lBf9Ko7VgvF52qckyPLOGdeUFdK&export=download',
    'https://drive.google.com/uc?id=15uhz-jrPDCXcA3P9TGtC77XL2j_sIhn2&export=download',
    'https://drive.google.com/uc?id=1aDc7bWTsTURrSb_KTdgcqPig5uf3JCK0&export=download',
  ];

  chnageThemeModel() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    log(themeMode.toString());
  }

  void initializeVideo() async {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(driveUploadedVediosList[0]),
      ),
    );
  }

  Future<void> handleNextOrPrev({required int vedioIndex}) async {
    try {
      currentVedioIndex = vedioIndex;
      notifyListeners();
      final internalStoragePath = await getDownloadPath();
      if (await File('$internalStoragePath/$currentVedioIndex.mp4').exists()) {
        flickManager.handleChangeVideo(VideoPlayerController.file(
          File('$internalStoragePath/$currentVedioIndex.mp4'),
        ));
      } else {
        log(currentVedioIndex.toString());
        flickManager.handleChangeVideo(VideoPlayerController.networkUrl(
          Uri.parse(driveUploadedVediosList[currentVedioIndex]),
        ));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> downloadAndEncryptVideo({required String vedioUrl}) async {
    try {
      final storageStatus = await getStorageStatus();
      if (storageStatus.isGranted) {
        isVedioDownloading = true;
        notifyListeners();
        final dio = Dio();

        final response = await dio.get(
          vedioUrl,
          options: Options(responseType: ResponseType.bytes),
        );
        final videoBytes = response.data;

        final internalStoragePath = await getDownloadPath();
        log(internalStoragePath.toString());

        final file = File('$internalStoragePath/$currentVedioIndex.mp4');
        await file.writeAsBytes(videoBytes);
      } else {
        getPermission().then((value) async {
          final storageStatus = await getStorageStatus();
          if (storageStatus.toString() == "PermissionStatus.denied") {
            count++;
            notifyListeners();
            if (count >= 3) {
              showDialog(
                context: AppNavigation.navigatorKey.currentState!.context,
                builder: (context) {
                  return AlertDialog(
                    title: const RefractedTextWidget(
                      text: "Allow to Access Storage",
                      maxLines: 2,
                      textWeight: FontWeight.bold,
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(24, 10, 20, 20),
                    content: const RefractedTextWidget(
                      text: "Will use your storage to download vedio",
                      textSize: 13,
                      maxLines: 3,
                    ),
                    actionsPadding: const EdgeInsets.all(0),
                    actions: [
                      const Divider(
                        color: Colors.grey,
                      ),
                      GestureDetector(
                        onTap: () async {
                          AppNavigation.pop(context);
                          goToAppSettings();
                        },
                        child: const Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: RefractedTextWidget(
                                text: "GO TO APP SETTINGS",
                                textColor: Color.fromARGB(255, 90, 147, 233),
                                textWeight: FontWeight.bold,
                              ),
                            )),
                      )
                    ],
                  );
                },
              );
            }
          }
          log(storageStatus.toString());
          if (storageStatus.isGranted) {
            downloadAndEncryptVideo(vedioUrl: vedioUrl);
          }
        });
      }
    } catch (e) {
      isVedioDownloading = false;
      notifyListeners();
      log(e.toString());
    }
    isVedioDownloading = false;
    notifyListeners();
  }

  Future<String?> getDownloadPath() async {
    try {
      if (Platform.isIOS) {
        final filePath = await getApplicationDocumentsDirectory();
        if (await filePath.exists()) {
          return filePath.path;
        } else {
          await filePath.create(recursive: true);
          return filePath.path;
        }
      } else {
        final filePath = await getExternalStorageDirectory();
        log(filePath!.path.toString());
        if (await filePath.exists()) {
          return filePath.path;
        } else {
          await filePath.create(recursive: true);
          return filePath.path;
        }
      }
    } catch (err) {
      log(err.toString());
    }
    return null;
  }

  Future<PermissionStatus> getStorageStatus() async {
    if (Platform.isAndroid) {
      return await Permission.mediaLibrary.status;
    } else {
      return await Permission.storage.status;
    }
  }

  Future<void> getPermission() async {
    print("getPermission");

    if (Platform.isAndroid) {
      log('message');
      await Permission.mediaLibrary.request();
    } else {
      await Permission.storage.request();
    }
  }

  void goToAppSettings() async {
    await OpenAppsSettings.openAppsSettings(
      settingsCode: SettingsCode.APP_SETTINGS,
    );
  }
}
