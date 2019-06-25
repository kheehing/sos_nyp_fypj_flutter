# sosnyp

## Problem Statement:

There are many cases of special needs students with physical disabilities, especially children, being neglected during emergency drills. This could lead to major issue in a real emergency when no proper help is abailable. Technology has been and continue to be an advantage to people with disabilities. Hence, employing Apps and other digital tools is very beneficial for the special needs in time of emergency.

## Objective:

To create a mobile application that provides assistance for special needs students with physical disabilities in time of emergency

## Accounts created for the app

### Admin

#### UserName & Password:

admin@gmail.com 123456

### User

#### UserName & Password:

testing@gmail.com 123qwe

## Getting Started With Flutter

This project is a starting point for a Flutter application.
A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
  For help getting started with Flutter, view our
  [online documentation](https://flutter.dev/docs), which offers tutorials,
  samples, guidance on mobile development, and a full API reference.

### [Flutter Packages](https://pub.dev/flutter)

- I couldn't access via chrome when using school's Internet/Wifi so i'm usig Tor browser when finding the packages update.

### [Flutter Documentation](https://flutter.dev/docs)

### [Android Developers](https://developer.android.com/)

## Dependencies (pubspec.yaml)

- cloud_firestore: 0.12.5+2
- firebase_auth: 0.11.1+7
- firebase_storage: 3.0.2
- intl: 0.15.8
- rflutter_alert: 1.0.2
- url_launcher: 5.0.3
- location: ^2.3.5
- provider: ^3.0.0
- permission_handler: 3.1.0
- cached_network_image: ^0.8.0
- image_picker: 0.6.0+10

## Build.gradle (android)

dependencies {<br />
classpath 'com.android.tools.build:gradle:3.2.1'<br />
classpath 'com.google.gms:google-services:4.2.0'<br />
}<br />

- Sometimes, when adding dependencies on pubspec.yaml the dependencies have to be changed to a different version. e.g. (classpath 'com.android.tools.build:gradle:3.2.1' => classpath 'com.android.tools.build:gradle:3.3.0') this might cause some error

## Build.gradle (android/app)

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

## Permissions (AndroidManifest.xml / info.plist)

- Android uses [AndroidManifest.xml](https://developer.android.com/guide/topics/manifest/manifest-intro) (android/app/src/main/AndroidManifest.xml)
- Ios uses [info.plist](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/AboutInformationPropertyListFiles.html) (ios/runner/info.plist)

refer to the links, google or some other youtube videos on which permissions you need from the device.
