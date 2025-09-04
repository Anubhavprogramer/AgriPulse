# AgriPulse

A Flutter app for monitoring soil temperature and moisture using a Bluetooth-enabled device, with Firebase integration and offline caching.

---

## Features

- **Bluetooth Integration:** Scan and connect to a soil sensor device (mocked if hardware is unavailable).
- **Live Readings:** Fetch and display real-time temperature (°C) and moisture (%) readings.
- **Firebase Integration:** Store readings securely in Firestore, with user authentication (email/password).
- **Reports & History:** View the latest reading and a history of past readings, including a graph.
- **Offline Caching:** Last reading is available even without internet.
- **Modern UI:** Clean, responsive interface with tab navigation.

---

## Setup Instructions

### 1. Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Firebase Project](https://console.firebase.google.com/)
- Android Studio or VS Code

### 2. Clone the Repository

```sh
git clone https://github.com/yourusername/soil_health_app.git
cd soil_health_app
````

### 3. Install Dependencies

```sh
flutter pub get
```

### 4. Firebase Setup

* Create a Firebase project in the [Firebase Console](https://console.firebase.google.com/).
* Add an Android app (and/or iOS app) to your Firebase project.
* Download `google-services.json` (Android) or `GoogleService-Info.plist` (iOS).
* Place `google-services.json` in `android/app/` and/or `GoogleService-Info.plist` in `ios/Runner/`.
* Make sure your `android/build.gradle` and `android/app/build.gradle` are configured for Firebase (see [FlutterFire docs](https://firebase.flutter.dev/docs/overview)).

### 5. Run the App

```sh
flutter run
```

---

## Usage

* **Login/Signup:** Register or sign in with your email and password.
* **Dashboard:** Use the "Test" button to fetch a new reading (mocked if no device is connected). Use "Reports" to view the latest reading.
* **History:** View a graph and list of all past readings.
* **Offline:** The last reading is cached and shown if offline.

---

## Bluetooth Integration

The app uses a `BluetoothService` abstraction to read data from a soil sensor.
Currently, the following assumptions are made:

* `isConnected` is always set to `false`, meaning no real hardware is connected.
* If a real Bluetooth device is available, you can change `isConnected` to `true` and implement the `TODO` in `getReading()`.
* When no device is connected, the app generates **mock readings** using `dart:math` and `DateTime` to simulate variation in temperature and moisture values.

  ```dart
  return {
    'temperature': 24 + (5 * (0.5 - (now % 10) / 10)),
    'moisture': 35 + (10 * (0.5 - (now % 10) / 10)),
  };
  ```
* This ensures the app can be fully tested without hardware.

When you integrate with a real device, replace the mock logic with actual Bluetooth read operations using [flutter\_blue](https://pub.dev/packages/flutter_blue).

---

## Project Structure

```
lib/
  models/           # Data models (e.g., Reading)
  screens/          # UI screens (Dashboard, History, Login, Signup, etc.)
  services/         # Firebase, Bluetooth, and Cache services
  widgets/          # Reusable widgets
```

---

## Dependencies

* [firebase\_core](https://pub.dev/packages/firebase_core)
* [firebase\_auth](https://pub.dev/packages/firebase_auth)
* [cloud\_firestore](https://pub.dev/packages/cloud_firestore)
* [flutter\_blue](https://pub.dev/packages/flutter_blue) (Bluetooth)
* [shared\_preferences](https://pub.dev/packages/shared_preferences) (Offline cache)
* [fl\_chart](https://pub.dev/packages/fl_chart) (Charts)

---

**For any issues or questions, please open an issue on GitHub.**


