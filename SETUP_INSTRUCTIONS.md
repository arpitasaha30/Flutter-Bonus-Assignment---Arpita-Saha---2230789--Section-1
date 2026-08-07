# Firebase Setup Instructions (CSE464 Assignment) — Realtime Database version

This version of the project uses **Firebase Realtime Database** instead of
Cloud Firestore, because Firestore now requires a billing account (Blaze
plan) to be linked to your Firebase project, while Realtime Database works
on the free Spark plan with no card needed.

All the Flutter/Dart code is already written and included in this project.
The only thing you need to do on **your** machine, with **your** Google
account, is connect the app to a real Firebase project — that step needs
your login. It takes about 5 minutes.

## 1. Create your Firebase project

1. Go to https://console.firebase.google.com
2. Click **Add project**, give it a name (e.g. `cse464-coffee-app`), and
   finish the wizard (you can disable Google Analytics, it isn't needed).

## 2. Enable Realtime Database

1. In the left sidebar of your new project, click **Build → Realtime
   Database**.
2. Click **Create Database**.
3. Pick a location close to you.
4. Choose **Start in test mode** (or locked mode — we'll paste our own
   rules in step 5 either way).

## 3. Install the FlutterFire CLI (one-time, if you don't have it)

```bash
dart pub global activate flutterfire_cli
```

Make sure you're also logged into the Firebase CLI:

```bash
dart pub global activate firebase_tools   # if you don't have it
firebase login
```

## 4. Connect the app to your project

From the root of this project (the folder with `pubspec.yaml`), run:

```bash
flutterfire configure
```

- Select the Firebase project you just created.
- Select the platforms you want (Android/iOS/web/etc.).
- This command **overwrites** `lib/firebase_options.dart` with your real
  project's configuration — replacing the placeholder file included here —
  and registers the native apps automatically (Android/iOS config files,
  etc.).

Then install the packages:

```bash
flutter pub get
```

## 5. Apply the Realtime Database rules

1. In the Firebase console, go to **Realtime Database → Rules**.
2. Replace the contents with what's in `database.rules.json` in this
   project (also shown below), then click **Publish**.

```json
{
  "rules": {
    ".read": true,
    ".write": true
  }
}
```

## 6. Run the app

```bash
flutter run
```

- On the home screen, tap **Order Now** to create a coffee record — it's
  written straight to Realtime Database (node: `coffee_records`).
- Tap **Check Firebase** to open the real-time view — it uses
  `onValue` + `StreamBuilder`, so anything you add/delete shows up
  instantly, including changes made directly in the Firebase console.

## What's already implemented in code

| Requirement | Where |
|---|---|
| Dart data model (quicktype-style `fromJson`/`toJson`, plus Realtime DB `fromMap`/`toMap`) | `lib/models/coffee_records_model.dart` |
| `CoffeeStateManagement` with Firebase CRUD methods | `lib/state_management/coffee_state_management.dart` |
| Sending data to Firebase | `lib/screens/create_coffee_record_screen.dart` → `csm.addCoffeeRecordToFirebase(...)` |
| Real-time view with `onValue` + `StreamBuilder` | `lib/screens/firebase_coffee_records_screen.dart` |
| Realtime Database rules (open read/write) | `database.rules.json` |
| Firebase init in `main()` | `lib/main.dart` |

## Troubleshooting

- **`MissingPluginException` / red screen on startup** → you skipped step 4;
  `lib/firebase_options.dart` still has placeholder `REPLACE_ME` values.
- **`PERMISSION_DENIED` in Realtime Database** → step 5 wasn't published yet,
  or you edited the wrong project's rules.
- **`flutterfire: command not found`** → make sure Dart's global bin folder
  is on your PATH (usually `~/.pub-cache/bin` on macOS/Linux or
  `%APPDATA%\Pub\Cache\bin` on Windows).
