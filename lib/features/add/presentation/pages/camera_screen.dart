import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late List<CameraDescription> cameras;
  late final Future<void> future = startCamera();

  bool isCapturing = false;
  //for switching camera
  int _selectedCameraIndex = 0;
  bool _isFrontCamera = false;
  //For flash
  bool _isFlashOn = false;
  //For focusing
  Offset? _focusPoint;
  //For zoom
  double _currentZoom = 1.0;
  File? _captureImage;

  //For making sound
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> startCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(
      cameras[_selectedCameraIndex],
      ResolutionPreset.max,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    await _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: FutureBuilder<void>(
          future: future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Stack(
                    children: [
                      Positioned(
                        top: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(color: Colors.black45),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    context.pop();
                                  },
                                  child: Icon(Icons.clear, color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _toggleFlashLight();
                                  },
                                  child: Icon(
                                    _isFlashOn
                                        ? Icons.flash_on_outlined
                                        : Icons.flash_off_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned.fill(
                        top: 50,
                        bottom: _isFrontCamera == false ? 0 : 150,
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: GestureDetector(
                            onTapDown: (TapDownDetails details) {
                              final Offset tapPosition = details.localPosition;
                              final Offset relativeTapPosition = Offset(
                                tapPosition.dx / constraints.maxWidth,
                                tapPosition.dy / constraints.maxHeight,
                              );
                              _setFocusPoint(relativeTapPosition);
                            },
                            child: CameraPreview(_controller),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 50,
                        right: 10,
                        child: SfSlider.vertical(
                          max: 5.0,
                          min: 1.0,
                          activeColor: Colors.white,
                          value: _currentZoom,
                          onChanged: (dynamic value) {
                            setState(() {
                              zoomCamera(value);
                            });
                          },
                        ),
                      ),

                      if (_focusPoint != null)
                        Positioned.fill(
                          top: 50,
                          child: Align(
                            alignment: Alignment(
                              _focusPoint!.dx * 2 - 1,
                              _focusPoint!.dy * 2 - 1,
                            ),
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),

                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: _isFrontCamera == false
                                ? Colors.black45
                                : Colors.black,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Video',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Photo',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Pro Mode',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              _captureImage != null
                                                  ? SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child: Image.file(
                                                        _captureImage!,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),

                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              capturePhoto();
                                            },
                                            child: Center(
                                              child: Container(
                                                height: 70,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                    width: 4,
                                                    color: Colors.white,
                                                    style: BorderStyle.solid,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              _switchCamera();
                                            },
                                            child: Icon(
                                              Icons.cameraswitch_sharp,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  void _toggleFlashLight() {
    if (_isFlashOn) {
      _controller.setFlashMode(FlashMode.off);
      setState(() {
        _isFlashOn = false;
      });
    } else {
      _controller.setFlashMode(FlashMode.torch);
      setState(() {
        _isFlashOn = true;
      });
    }
  }

  void _switchCamera() async {
    if (_controller.value.isInitialized) {
      // Dispose the current controller to release the camera resource
      await _controller.dispose();
    }

    // Increment or reset the selected camera index
    _selectedCameraIndex = (_selectedCameraIndex + 1) % cameras.length;

    // Initialize the new camera
    _initCamera(_selectedCameraIndex);
  }

  Future<void> _initCamera(int cameraIndex) async {
    _controller = CameraController(cameras[cameraIndex], ResolutionPreset.high);

    try {
      await _controller.initialize();
      setState(() {
        if (cameraIndex == 0) {
          _isFrontCamera = false;
        } else {
          _isFrontCamera = true;
        }
      });
    } catch (e) {
      log('Error message: $e');
    }

    if (mounted) {
      setState(() {});
    }
  }

  void capturePhoto() async {
    if (!_controller.value.isInitialized) return;

    final Directory appDir = await path_provider
        .getApplicationSupportDirectory();
    final String capturePath = path.join(appDir.path, '${DateTime.now()}.jpg');

    if (_controller.value.isTakingPicture) return;

    try {
      setState(() {
        isCapturing = true;
      });

      final XFile captureImage = await _controller.takePicture();
      String imagePath = captureImage.path;
      await GallerySaver.saveImage(imagePath);
      log('Photo captured and saved to the gallery');

      //Play a sound effect
      await _audioPlayer.play(AssetSource('music/camerassound.mp3'));

      final String filePath =
          '$capturePath/${DateTime.now().millisecondsSinceEpoch}.jpg';

      _captureImage = File(captureImage.path);
      _captureImage!.renameSync(filePath);
    } catch (e) {
      log('Error capturing photo: $e');
    } finally {
      setState(() {
        isCapturing = false;
      });
    }
  }

  void zoomCamera(value) {
    setState(() {
      _currentZoom = value;
      _controller.setZoomLevel(value);
    });
  }

  Future<void> _setFocusPoint(Offset point) async {
    if (_controller.value.isInitialized) {
      try {
        final double x = point.dx.clamp(0.0, 1.0);
        final double y = point.dy.clamp(0.0, 1.0);
        await _controller.setFocusPoint(Offset(x, y));
        await _controller.setFocusMode(FocusMode.auto);
        setState(() {
          _focusPoint = Offset(x, y);
        });

        //Reset _focusPoint after a short delay to remove the square
        await Future.delayed(Duration(seconds: 2));
        setState(() {
          _focusPoint = null;
        });
      } catch (e) {
        log('Failed to set focus');
      }
    }
  }
}
