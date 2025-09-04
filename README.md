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
```

### 3. Install Dependencies

```sh
flutter pub get
```

### 4. Firebase Setup

- Create a Firebase project in the [Firebase Console](https://console.firebase.google.com/).
- Add an Android app (and/or iOS app) to your Firebase project.
- Download `google-services.json` (Android) or `GoogleService-Info.plist` (iOS).
- Place `google-services.json` in `android/app/` and/or `GoogleService-Info.plist` in `ios/Runner/`.
- Make sure your `android/build.gradle` and `android/app/build.gradle` are configured for Firebase (see [FlutterFire docs](https://firebase.flutter.dev/docs/overview)).

### 5. Run the App

```sh
flutter run
```

---

## Usage

- **Login/Signup:** Register or sign in with your email and password.
- **Dashboard:** Use the "Test" button to fetch a new reading (mocked if no device is connected). Use "Reports" to view the latest reading.
- **History:** View a graph and list of all past readings.
- **Offline:** The last reading is cached and shown if offline.

---

## Bluetooth Integration

- The app uses a `BluetoothService` abstraction.
- If no hardware is available, mock data is used.
- When you have a real device, update `BluetoothService` to scan, connect, and read from your sensor.

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

- [cupertino_icons: ^1.0.8](https://pub.dev/packages/cupertino_icons)
- [fl_chart: ^0.66.0](https://pub.dev/packages/fl_chart)
- [firebase_core: ^2.0.0](https://pub.dev/packages/firebase_core)
- [firebase_auth: ^4.0.0](https://pub.dev/packages/firebase_auth)
- [cloud_firestore: ^4.0.0](https://pub.dev/packages/cloud_firestore)
- [intl: ^0.19.0](https://pub.dev/packages/intl)
- [flutter_blue_plus: ^1.32.0](https://pub.dev/packages/flutter_blue_plus) (Bluetooth)
- [shared_preferences](https://pub.dev/packages/shared_preferences) (Offline cache)

---
**For any issues or questions, please open an issue on GitHub.**
