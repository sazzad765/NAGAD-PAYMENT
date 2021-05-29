## Quick Starter Flutter Boilerplate for Easy bKash Integration

[![GitHub license](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)]()  [![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)]() [![Open Source Love svg1](https://badges.frapsoft.com/os/v1/open-source.svg?v=103)](https://github.com/ellerbrock/open-source-badges/) [![made-with-love](https://img.shields.io/badge/Made%20with-Love-1f425f.svg)](https://chayanforyou.github.io/)


An app with a simple easy-to-start boilerplate codebase for integrating bKash with ease. The whole app is developed using flutter with layers-by-features packaging & other standard practices.
Here, I've implemented 2 way to Integrate bKash payment gateway with flutter
1. Through local asset
2. Through web server (PHP)

### local Asset
No need to change anything for local testing purpose.

You must have to use patched version of [webview_flutter](https://pub.dev/packages/webview_flutter) (details discussion [bellow](https://github.com/chayanforyou/bkash-pgwclient-demo-flutter#patched-webview)), or can use [flutter_inappwebview](https://pub.dev/packages/flutter_inappwebview)
I'm working on `flutter_inappwebview` bKash payment integration.

### Web Server
For server side implementation, Keep [bKash_api_sandbox.zip](https://github.com/chayanforyou/bkash-pgwclient-demo-flutter/raw/master/bKash_api_sandbox.zip)
files on your hosting & change the ```config.json``` with __`sandbox`__ credential __`(Not work with live credential)`__ `app_key`, `app_secret`, `username` & `password`. Nothing else needs to change.
Then change the `initialUrl` of `bkash_payment.dart` in line ```initialUrl: 'http://your.hosting.com/bkash/payment.php'``` with your api host or localhost (for testing) link.

```
Note: You can use default webview_flutter plugin. Patched version not required.
```

## Features

* A Simple App with a button to `Checkout`
* Pressing the button initiates bKash payment dialogs
* Returns a screen with success & payment status if the mock payment is successful

## Now you need to put the following implementations in `Android` and `iOS` respectively.

### Android
Make sure to add this line `android:usesCleartextTraffic="true"` in your `<project-directory>/android/app/src/main/AndroidManifest.xml` under `application` like this.
```xml
<application
       android:usesCleartextTraffic="true">
</application>
```

Required Permissions are:
```xml
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

### iOS
Add following code in your `<project-directory>/ios/Runner/Info.plist`
```plist
<key>NSAppTransportSecurity</key>
  <dict>
    <key>NSAllowsArbitraryLoads</key> <true/>
  </dict>
```

## Build Instructions

This project uses the flutter tool. Flutter and Dart plugins have to install in your machine. To run this project, use the `flutter run` command or use "Open Project" in Android Studio.

### Prerequisites

* Android Studio 3.5+. The latest version can be downloaded from [here](https://developer.android.com/studio/)
* Flutter 1.22.6
* Dart 2.10.5
* Build gradle 3.5.0+
* Android SDK 29

### Build an APK

From the command line:
1. Enter cd <app dir>
   (Replace `<app dir>` with your application’s directory.)
2. Run `flutter build apk --split-per-abi`
   (The flutter build command defaults to --release.)

### Install an APK on a device

From the command line:
1. Connect your Android device to your computer with a USB cable.
2. Enter `cd <app dir>` where `<app dir>` is your application directory.
3. Run `flutter install.`


## App Screenshots

<img src="https://github.com/chayanforyou/bkash-pgwclient-demo-flutter/blob/master/screenshots/1.png" height="400" width="200"> <img src="https://github.com/chayanforyou/bkash-pgwclient-demo-flutter/blob/master/screenshots/2.png" height="400" width="200"> <img src="https://github.com/chayanforyou/bkash-pgwclient-demo-flutter/blob/master/screenshots/3.png" height="400" width="200"> <img src="https://github.com/chayanforyou/bkash-pgwclient-demo-flutter/blob/master/screenshots/4.png" height="400" width="200"> <img src="https://github.com/chayanforyou/bkash-pgwclient-demo-flutter/blob/master/screenshots/5.png" height="400" width="200"> <img src="https://github.com/chayanforyou/bkash-pgwclient-demo-flutter/blob/master/screenshots/6.png" height="400" width="200"> <img src="https://github.com/chayanforyou/bkash-pgwclient-demo-flutter/blob/master/screenshots/7.png" height="400" width="200">

## Contributing

### Directory Structure

The following is a high level overview of relevant files and folders.

```
bkash-pgwClient-demo-flutter/
├── android/
│   └── ...
├── assets/
│   └── www/
│       └── css, fonts, js & html files
├── ios/
│   └── ...
├── build/
│   └── ...
├── lib/
│   ├── model/
│   │   └── payment_request.dart
│   ├── pages/
│   │   ├── bkash_payment.dart
│   │   └── home_page.dart
│   ├── utility/
│   │   └── js_interface.dart
│   └── main.dart
├── test/
│   └── widget_test.dart
├── screenshots/
│   └── ...
├── webview_flutter/ (Patched WebView)
│   ├── android/
│   ├── ios/
│   ├── lib/
│   └── pubspec.yaml
├── bKash_api_sandbox.zip
├── local.properties
├── pubspec.lock
├── pubspec.yaml
├── README.md
└── ...

```

### Patched WebView

* The Flutter WebView plugin is in preview and at the moment it only loads URIs.
  It’d be nice if we can load local html (along with Javascript and CSS) files from local assets.
* I followed
  [this](https://medium.com/flutter-community/loading-local-assets-in-webview-in-flutter-b95aebd6edad/)
  blog post made minimal changes to the plugin to provide a way to load asset files.

### Create a branch

1.  `git checkout master` from any folder in your local `bkash_pgwclient_demo_flutter`
    repository
1.  `git pull origin master` to ensure you have the latest main code
1.  `git checkout -b the-name-of-my-branch` (replacing `the-name-of-my-branch`
    with a suitable name) to create a branch

### Make the change

1.  Change/Add the codes
1.  Save the files and check the codes if it has successfl build config.

### Test the change

1.  If possible, test the codes the way you want.

### Push it

1.  `git add -A && git commit -m "My message"` (replacing `My message` with a
    commit message, such as `Fixed App Crash` or `Added App Crash 28 Fix`) to stage and commit
    your changes
1.  `git push my-fork-name the-name-of-my-branch`
1.  Go to the
    [`bkash_pgwclient_demo_flutter`](https://github.com/chayanforyou/bkash-pgwclient-demo-flutter/)
    and you should see recently pushed branches.
1.  Follow GitHub's instructions and open up a pull request.
1.  If possible, include screenshots of visual changes.
