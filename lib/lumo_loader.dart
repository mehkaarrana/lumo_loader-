library lumo_loader;

import 'package:flutter/material.dart';
import 'package:lumo_loader/src/loaders/pulse_loader.dart';
import 'package:lumo_loader/src/loaders/ring_loader.dart';
import 'package:lumo_loader/src/loaders/spinner_loader.dart';
import 'package:lumo_loader/src/loaders/wave_loader.dart';

import 'src/loaders/circle_loader.dart';
import 'src/loaders/bar_loader.dart';
import 'src/loaders/cube_loader.dart';
import 'src/loaders/dots_loader.dart';
import 'src/loaders/orbit_loader.dart';

export 'src/loaders/circle_loader.dart';
export 'src/loaders/bar_loader.dart';
export 'src/loaders/cube_loader.dart';
export 'src/loaders/dots_loader.dart';
export 'src/loaders/orbit_loader.dart';

class LumoLoader {
  const LumoLoader._();

  static Widget circle({
    Key? key,
    double size = 56.0,
    Color color = Colors.white,
    Duration duration = const Duration(milliseconds: 1200),
  }) => CircleLoader(key: key, size: size, color: color, duration: duration);

  static Widget bar({
    Key? key,
    double width = 56.0,
    double height = 48.0,
    Color color = Colors.white,
    Duration duration = const Duration(milliseconds: 900),
  }) => BarLoader(
    key: key,
    width: width,
    height: height,
    color: color,
    duration: duration,
  );

  static Widget cube({
    Key? key,
    double size = 56.0,
    Color color = Colors.white,
    Duration duration = const Duration(milliseconds: 1400),
  }) => CubeLoader(key: key, size: size, color: color, duration: duration);

  static Widget dots({
    Key? key,
    double size = 56.0,
    Color color = Colors.white,
    Duration duration = const Duration(milliseconds: 1100),
  }) => DotsLoader(key: key, size: size, color: color, duration: duration);

  static Widget orbit({
    Key? key,
    double size = 56.0,
    Color color = Colors.white,
    Duration duration = const Duration(milliseconds: 1300),
  }) => OrbitLoader(key: key, size: size, color: color, duration: duration);
  static Widget pulse({
    Key? key,
    double size = 72.0,
    Color color = Colors.white,
    Duration duration = const Duration(milliseconds: 1400),
  }) => PulseLoader(key: key, size: size, color: color, duration: duration);

  static Widget ring({
    Key? key,
    double size = 64.0,
    Color color = Colors.white,
    Duration duration = const Duration(milliseconds: 1200),
  }) => RingLoader(key: key, size: size, color: color, duration: duration);
  static Widget spinner({
    Key? key,
    double size = 56.0,
    Color color = Colors.white,
    Duration duration = const Duration(milliseconds: 900),
  }) =>
      SpinnerLoader(key: key, size: size, color: color, duration: duration);

  static Widget wave({
    Key? key,
    double size = 64.0,
    Color color = Colors.white,
    Duration duration = const Duration(milliseconds: 1000),
    int barCount = 6,
  }) =>
      WaveLoader(key: key, size: size, color: color, duration: duration, barCount: barCount);
}
