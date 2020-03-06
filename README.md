# SOSNYP

Did This Project for my year 3 FYPJ. There are many cases of special needs students with physical disabilities, especially children, being neglected during emergency drills. This could lead to major issue in a real emergency when no proper help is abailable. Technology has been and continue to be an advantage to people with disabilities. Hence, employing Apps and other digital tools is very beneficial for the special needs in time of emergency.

## Getting Started (Accounts for the application)

### Admin
#### UserName & Password:
admin@mail.com 123456

### User
#### UserName & Password:
-

### Prerequisites

you will need to download flutter. The IDE i'm using is VisualStudio Code.

### Installing

This project is a starting point for a Flutter application.
A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
  For help getting started with Flutter, view our
  [online documentation](https://flutter.dev/docs), which offers tutorials,
  samples, guidance on mobile development, and a full API reference.
### Installing flutter
[Installing with this guide](https://www.youtube.com/watch?v=lBR1jWW8cMc) or you can find other tutorial to your like.
I would reccomand you starting a new project, and try out how how to code in dart with flutter, before resuming on the codes.
You can try to connect to a firebase just to see how it works.

### [Flutter Packages](https://pub.dev/flutter)
I couldn't access via chrome when using school's Internet/Wifi so i'm usig Tor browser when finding the packages update.

### [Flutter Documentation](https://flutter.dev/docs)
- [Get Started](https://flutter.dev/docs/get-started/install) (installing)
- [Widgets Catalog](https://flutter.dev/docs/development/ui/widgets)
- [API Docs](https://api.flutter.dev/)
- [Cookbook](https://flutter.dev/docs/cookbook)
- [Samples](https://github.com/flutter/samples/blob/master/INDEX.md)
- [Videos](https://www.youtube.com/flutterdev)

## Running the app

Ctrl + F5

or in CMD type 
```
flutter run
```

## Dependencies (pubspec.yaml)

  cloud_firestore: ^0.12.5+2
  firebase_auth: ^0.11.1+7
  firebase_core: ^0.4.0+8
  firebase_storage: ^3.0.2
  firebase_messaging: ^5.1.2

  intl: 0.15.8
  rflutter_alert: 1.0.2
  url_launcher: 5.0.3
  location: ^2.3.5
  provider: ^3.0.0
  permission_handler: 3.1.0
  cached_network_image: ^0.8.0
  image_picker: 0.6.0+10
  flutter_screenutil: 0.5.3
  rounded_modal: ^1.0.0
  auto_size_text: ^2.0.1
  clippy_flutter: ^1.1.0
  progress_indicators: ^0.1.4
  flushbar: ^1.8.0
  charts_flutter: ^0.6.0

## Authors

Me

## Noted

### [Flutter Documentation](https://flutter.dev/docs)
- [Get Started](https://flutter.dev/docs/get-started/install) (installing)
- [Widgets Catalog](https://flutter.dev/docs/development/ui/widgets)
- [API Docs](https://api.flutter.dev/)
- [Cookbook](https://flutter.dev/docs/cookbook)
- [Samples](https://github.com/flutter/samples/blob/master/INDEX.md)
- [Videos](https://www.youtube.com/flutterdev)r

### [Flutter Packages](https://pub.dev/flutter)
I couldn't access via chrome when using school's Internet/Wifi so i'm usig Tor browser when finding the packages update.

### Build.gradle (android)

dependencies {<br />
classpath 'com.android.tools.build:gradle:3.2.1'<br />
classpath 'com.google.gms:google-services:4.2.0'<br />
}<br />

- Sometimes, when adding dependencies on pubspec.yaml the dependencies have to be changed to a different version. e.g. (classpath 'com.android.tools.build:gradle:3.2.1' => classpath 'com.android.tools.build:gradle:3.3.0') this might cause some error

### Build.gradle (android/app)

...<br />
dependencies {<br />
testImplementation 'junit:junit:4.12'<br />
implementation 'com.google.firebase:firebase-auth:18.0.0'<br />
implementation "com.google.firebase:firebase-core:17.0.0"<br />
}<br />
apply plugin: 'com.google.gms.google-services'<br />

- Under 'defaultConfig' multiDexEnabled has to be enabled or the app will crash (idk why)
- At the end need to apply plugin: 'com.google.gms.google-services'
- more or less this page need not have to change anything other than adding some dependencies.

### [Android Developers](https://developer.android.com/)
I use this site to seach for dependecies on both Build.gradle.

### Permissions (AndroidManifest.xml / info.plist)

- Android uses [AndroidManifest.xml](https://developer.android.com/guide/topics/manifest/manifest-intro) (android/app/src/main/AndroidManifest.xml)
- Ios uses [info.plist](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/AboutInformationPropertyListFiles.html) (ios/runner/info.plist)


## How the App Works
[click here for image](https://imgur.com/abF2YTW)

## google account
sosnypfypj2019@gmail.com
Nypfypj123
