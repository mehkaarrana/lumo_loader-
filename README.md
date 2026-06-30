# 🚀 Lumo Loader

<p align="center">
  <img src="https://img.shields.io/pub/v/lumo_loader.svg" alt="Pub Version">
  <img src="https://img.shields.io/pub/likes/lumo_loader" alt="Pub Likes">
  <img src="https://img.shields.io/pub/points/lumo_loader" alt="Pub Points">
  <img src="https://img.shields.io/pub/popularity/lumo_loader" alt="Popularity">
  <img src="https://img.shields.io/badge/Flutter-3.x-blue.svg">
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-success">
  <img src="https://img.shields.io/badge/License-MIT-green.svg">
</p>

<p align="center">
Beautiful, modern and highly customizable loading animations for Flutter.
</p>

---

## ✨ Features

- 🎨 Beautiful modern loaders
- ⚡ Smooth 60 FPS animations
- 🚀 Lightweight
- 📱 Responsive
- ❤️ Easy API
- 🎛 Highly customizable
- 🌙 Dark mode friendly
- 💯 Production ready

---

# 📦 Included Loaders

| Loader | Status |
|---------|--------|
| Circle Loader | ✅ |
| Bar Loader | ✅ |
| Cube Loader | ✅ |
| Dots Loader | ✅ |
| Orbit Loader | ✅ |
| Pulse Loader | ✅ |
| Ring Loader | ✅ |
| Spinner Loader | ✅ |
| Wave Loader | ✅ |

More loaders are coming soon...

---

# 📥 Installation

Add dependency

```yaml
dependencies:
  lumo_loader: ^1.0.0
```

Run

```bash
flutter pub get
```

---

# 📚 Import

```dart
import 'package:lumo_loader/lumo_loader.dart';
```

---

# 🚀 Usage

## Circle Loader

```dart
Center(
  child: LumoLoader.circle(),
)
```

Custom

```dart
LumoLoader.circle(
  size: 60,
  color: Colors.blue,
  duration: Duration(milliseconds: 1000),
)
```

---

## Bar Loader

```dart
LumoLoader.bar()
```

```dart
LumoLoader.bar(
  width: 70,
  height: 45,
  color: Colors.red,
)
```

---

## Cube Loader

```dart
LumoLoader.cube()
```

```dart
LumoLoader.cube(
  size: 60,
  color: Colors.green,
)
```

---

## Dots Loader

```dart
LumoLoader.dots()
```

```dart
LumoLoader.dots(
  size: 50,
  color: Colors.orange,
)
```

---

## Orbit Loader

```dart
LumoLoader.orbit()
```

```dart
LumoLoader.orbit(
  size: 60,
  color: Colors.purple,
)
```

---

## Pulse Loader

```dart
LumoLoader.pulse()
```

```dart
LumoLoader.pulse(
  size: 70,
  color: Colors.red,
)
```

---

## Ring Loader

```dart
LumoLoader.ring()
```

```dart
LumoLoader.ring(
  size: 60,
  color: Colors.teal,
)
```

---

## Spinner Loader

```dart
LumoLoader.spinner()
```

```dart
LumoLoader.spinner(
  size: 55,
  color: Colors.amber,
)
```

---

## Wave Loader

```dart
LumoLoader.wave()
```

```dart
LumoLoader.wave(
  size: 70,
  color: Colors.indigo,
  barCount: 8,
)
```

---

# ⚙️ Customization

Most loaders support the following properties.

| Property | Description |
|-----------|-------------|
| size | Loader size |
| color | Loader color |
| duration | Animation duration |

Some loaders also support:

| Property | Description |
|-----------|-------------|
| width | Bar width |
| height | Bar height |
| barCount | Number of bars |

---

# 📱 Preview

## Circle

> Add GIF here

```
circle_loader.gif
```

---

## Bar

> Add GIF here

```
bar_loader.gif
```

---

## Cube

> Add GIF here

```
cube_loader.gif
```

---

## Dots

> Add GIF here

```
dots_loader.gif
```

---

## Orbit

> Add GIF here

```
orbit_loader.gif
```

---

## Pulse

> Add GIF here

```
pulse_loader.gif
```

---

## Ring

> Add GIF here

```
ring_loader.gif
```

---

## Spinner

> Add GIF here

```
spinner_loader.gif
```

---

## Wave

> Add GIF here

```
wave_loader.gif
```

---

# 🎯 Example

```dart
import 'package:flutter/material.dart';
import 'package:lumo_loader/lumo_loader.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: LumoLoader.circle(
          size: 60,
          color: Colors.white,
        ),
      ),
    );
  }
}
```

---

# ❤️ Why Lumo Loader?

- Easy API
- Beautiful Animations
- Lightweight
- Optimized
- Flutter Friendly
- Modern Design
- Production Ready
- Open Source

---

# 🛣 Roadmap

### Version 1.0

- ✅ Circle Loader
- ✅ Bar Loader
- ✅ Cube Loader
- ✅ Dots Loader
- ✅ Orbit Loader
- ✅ Pulse Loader
- ✅ Ring Loader
- ✅ Spinner Loader
- ✅ Wave Loader

### Upcoming

- ⏳ DNA Loader
- ⏳ Infinity Loader
- ⏳ Ripple Loader
- ⏳ Liquid Loader
- ⏳ Neon Loader
- ⏳ Gradient Loader
- ⏳ Hexagon Loader
- ⏳ Shimmer Loader
- ⏳ Morph Loader
- ⏳ Particle Loader

---

# 🤝 Contributing

Contributions are welcome!

If you find a bug or have a feature request, please open an issue or submit a pull request.

---

# ⭐ Support

If you like this package:

⭐ Star the GitHub repository

👍 Like it on pub.dev

🐛 Report issues

🚀 Happy Coding!

---

# 📄 License

MIT License © Mehkaar Rana