import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:image/image.dart' as imgUtils;
import 'package:path_provider/path_provider.dart';
import 'package:foodage/ui/camera/camera_option_button.dart';

class CameraPreviewFrame extends StatefulWidget {

  CameraPreviewFrame({ Key? key }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CameraPreviewFrameState();
  }
}

class CameraPreviewFrameState extends State<CameraPreviewFrame> {
  ValueNotifier<CameraFlashes> _switchFlash = ValueNotifier(CameraFlashes.NONE);
  ValueNotifier<double> _zoomNotifier = ValueNotifier(0);
  ValueNotifier<Size> _photoSize = ValueNotifier(Size.zero);
  ValueNotifier<Sensors> _sensor = ValueNotifier(Sensors.BACK);
  ValueNotifier<CaptureModes> _captureMode = ValueNotifier(CaptureModes.PHOTO);

  PictureController _pictureController = new PictureController();

  late List<Size> _availableSizes;

  double? _previousScale;

  @override
  void dispose() {
    _photoSize.dispose();
    _switchFlash.dispose();
    _sensor.dispose();
    _zoomNotifier.dispose();
    _captureMode.dispose();
    super.dispose();
  }

  //TODO: Permissions request
  void _onPermissionsResult(bool? granted) {
    if (granted != null && granted) {
      setState(() {});
    } else {
      AlertDialog alert = AlertDialog(
        title: Text('Error'),
        content:
        Text('It seems you doesn\'t authorized some permissions. Please check on your settings and try again.'),
        actions: [
          FlatButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
          child: Center(
            child: GestureDetector(
              onScaleStart: (ScaleStartDetails details) {
                _previousScale = _zoomNotifier.value + 1;
              },
              onScaleUpdate: (ScaleUpdateDetails details) {
                double result = _previousScale! * details.scale - 1;
                if (result < 1 && result > 0) {
                  changeZoom(result);
                }
              },
              child: CameraAwesome(
                onPermissionsResult: _onPermissionsResult,
                selectDefaultSize: (availableSizes) {
                  this._availableSizes = availableSizes;
                  return availableSizes[0];
                },
                captureMode: _captureMode,
                photoSize: _photoSize,
                sensor: _sensor,
                switchFlashMode: _switchFlash,
                zoom: _zoomNotifier,
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 30,
            right: 20,
            child: Container(
              child: Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: _switchFlash, builder: (context, flash, widget) => changeFlashButton(),),
                  SizedBox(width: 20.0),
                  ValueListenableBuilder(
                    valueListenable: _switchFlash, builder: (context, flash, widget) => changeCameraButton(),)
                ],
              ),
            )
        )
      ],
    );
  }
}

extension CameraControlActions on CameraPreviewFrameState {
  void changeZoom(double newZoom) => _zoomNotifier.value = newZoom;

  void changeSensor(Sensors sensors) => _sensor.value = sensors;

  void changeSize(Size size) => _photoSize.value = size;

  void changeCameraFlashes(CameraFlashes cameraFlashes) => _switchFlash.value = cameraFlashes;
}

extension CameraControlOptionBuilders on CameraPreviewFrameState {

  IconData _getFlashIcon() {
    switch (_switchFlash.value) {
      case CameraFlashes.NONE:
        return Icons.flash_off;
      case CameraFlashes.ON:
        return Icons.flash_on;
      case CameraFlashes.AUTO:
        return Icons.flash_auto;
      case CameraFlashes.ALWAYS:
        return Icons.highlight;
      default:
        return Icons.flash_off;
    }
  }

  Widget changeFlashButton() {
    return CameraOptionButton(
      icon: _getFlashIcon(),
      onTapCallback: () {
        switch (_switchFlash.value) {
          case CameraFlashes.NONE:
            _switchFlash.value = CameraFlashes.ON;
            break;
          case CameraFlashes.ON:
            _switchFlash.value = CameraFlashes.AUTO;
            break;
          case CameraFlashes.AUTO:
            _switchFlash.value = CameraFlashes.ALWAYS;
            break;
          case CameraFlashes.ALWAYS:
            _switchFlash.value = CameraFlashes.NONE;
            break;
        }
      },
    );
  }

  Widget changeCameraButton() {
    return CameraOptionButton(
      icon: Icons.switch_camera,
      onTapCallback: () {
        if (_sensor.value == Sensors.FRONT) {
          _sensor.value = Sensors.BACK;
        } else {
          _sensor.value = Sensors.FRONT;
        }
      },
    );
  }

  Future<File> capture() async {
    final Directory extDir = await getTemporaryDirectory();
    final testDir =
        await Directory('${extDir.path}/test').create(recursive: true);
    final String filePath = '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    await _pictureController.takePicture(filePath);
    // lets just make our phone vibrate
    HapticFeedback.mediumImpact();
    print("----------------------------------");
    print("TAKE PHOTO CALLED");
    final file = File(filePath);
    print("==> hastakePhoto : ${file.exists()} | path : $filePath");
    final img = imgUtils.decodeImage(file.readAsBytesSync());
    if (img != null) {
      print("==> img.width : ${img.width} | img.height : ${img.height}");
    } else {
      print("Image info was null");
    }
    print("----------------------------------");
    return file;
  }

}