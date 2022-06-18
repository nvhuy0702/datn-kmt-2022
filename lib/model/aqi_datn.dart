import 'package:app_datn_2022/colors/datn_colors.dart';
import 'package:flutter/material.dart';

enum State {
  GOOD,
  MODERATE,
  UNHEALTHYGROUP,
  UNHEALTHY,
  VERYUNHEALTHY,
  HAZARDOUS
}

class aqiDATN {
  final Color? color;
  final State state;
  final String? pathAvatar;
  aqiDATN({this.color, required this.state, this.pathAvatar});
  factory aqiDATN.initializeFromRange({required double range}) {
    if (range >= 0 && range <= 50) {
      return aqiDATN(
          state: State.GOOD,
          color: DATNColors.good,
          pathAvatar: 'assets/images/1.png');
    } else if (range >= 51 && range <= 100) {
      return aqiDATN(
          state: State.MODERATE,
          color: DATNColors.moderate,
          pathAvatar: 'assets/images/2.png');
    } else if (range >= 101 && range <= 150) {
      return aqiDATN(
          state: State.UNHEALTHYGROUP,
          color: DATNColors.unhealthyForSensitiveGr,
          pathAvatar: 'assets/images/3.png');
    } else if (range >= 151 && range <= 200) {
      return aqiDATN(
          state: State.UNHEALTHY,
          color: DATNColors.unhealthy,
          pathAvatar: 'assets/images/4.png');
    } else if (range >= 201 && range <= 300) {
      return aqiDATN(
          state: State.VERYUNHEALTHY,
          color: DATNColors.veryUnhealthy,
          pathAvatar: 'assets/images/5.png');
    }
    return aqiDATN(
        state: State.HAZARDOUS,
        color: DATNColors.hazardous,
        pathAvatar: 'assets/images/6.png');
  }
}
class CO {
  final Color color;
  CO({required this.color});
  factory CO.initializeFromRange({required double value}) {
    if (value >= 0 && value <= 10000) {
      return CO(
          color: DATNColors.good,);
    } else if (value >= 10001 && value <= 30000) {
      return CO(
          color: DATNColors.moderate,
         );
    } else if (value >= 30001 && value <= 45000) {
      return CO(
          color: DATNColors.unhealthyForSensitiveGr,
      );
    } else if (value >= 450001 && value <= 60000) {
      return CO(
          color: DATNColors.unhealthy,
          );
    } else if (value >= 60001 && value <= 90000) {
      return CO(
          color: DATNColors.veryUnhealthy,
      );
    }
    return CO(
        color: DATNColors.hazardous);
  }
}
class PM10 {
  final Color color;
  PM10({required this.color});
  factory PM10.initializeFromRange({required double value}) {
    if (value >= 0 && value <= 50) {
      return PM10(
        color: DATNColors.good,);
    } else if (value >= 51 && value <= 150) {
      return PM10(
        color: DATNColors.moderate,
      );
    } else if (value >= 151 && value <= 250) {
      return PM10(
        color: DATNColors.unhealthyForSensitiveGr,
      );
    } else if (value >= 251 && value <= 350) {
      return PM10(
        color: DATNColors.unhealthy,
      );
    } else if (value >= 351 && value <= 420) {
      return PM10(
        color: DATNColors.veryUnhealthy,
      );
    }
    return PM10(
        color: DATNColors.hazardous);
  }
}