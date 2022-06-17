import 'package:app_datn_2022/model/aqi_datn.dart';

extension ToStatus on State {
  String get getName {
    switch(this) {
      case State.GOOD:
        return 'Tốt';
        break;
      case State.MODERATE:
        // TODO: Handle this case.
        return 'Trung bình';
        break;
      case State.UNHEALTHYGROUP:
        // TODO: Handle this case.
        return 'Xấu';
        break;
      case State.UNHEALTHY:
        // TODO: Handle this case.
        return 'Kém';
        break;
      case State.VERYUNHEALTHY:
        // TODO: Handle this case.
        return 'Rất kém';
        break;
      case State.HAZARDOUS:
        // TODO: Handle this case.
        return 'Nguy hại';
        break;
    }
  }
}