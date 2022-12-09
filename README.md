# flutter-client

Course project for CPMDWithF course

## Getting Started

This repository contains the course project for CPMDWithF course.

This project features the implementation of car damage reporting system for car sharing. The user can log in into the app, take photos of the car damage, send selected photos to dedicated car damage analytics server, and get report on detected damage.

The project features login feature connected to Firebase services. At this stage of development, it's not possible to register new acconts, thus, in order to test the projects features, please use already provided email and password!

## Source code structure

The project written entirely in Flutter (Dart). Root of the repository contains built APK for Android systems, called `app-release.apk`. The project contains one legacy package called `before-after`, which is considered as not null safe. Thus, the project was built with `--no-sound-null-safety` flag. We made sure that this package will not negatively affect the stability of the app. This may change in future updates.

The code of this project is divided according to their function within the app. All code responsible for the UI is located in the `lib/ui` directory. The `lib/ui/main_tabs` subdirectory contains three main tabs of the app, which will be described below in the `How To` section. `lib/doman` directory contains logic classes and fucntions used inside the application. For instance, connection to the analysis server is implemented in the `lib/domain/server_connetion.dart` and it is being used by UI elements in `lib/ui/main_tabs/analysis.dart`. `lib/data` folder is used to store custom objects classes, such as the class for storing the damage report data retrived by connecting to the analysis server. `assets` folder in the root directory contains only the icon of the app.

## How To

When the you start the application, first thing you will see is the `Login Screen`. For now, it is only possible to login with provided credentials. The app does not track your login state, thus, you will have to login every time you launh the app.

After you successfully login into the application, the first screen you see will be `Photo Screen` with several tabs at the top. The rightmost button is the switch between `Light Mode` and `Dark mode`. In the `Dark mode` most of the app's features will be darkened. On the `Photo Screen` you can take the photos of the damage on your car from your phone's camera. Each photo taken will be displayed in a nice scrollable grid. Also, next to the `Take a picture!` there is a localization switch button. This button is present on each screen. This button will switch current localization between `English` and `Russian`.

Next screen that you might want to use is the `Gallery Screen`. It contains the same functionality as the `Photo Screen`, but the only difference is that the photo will be taken from your phone's galerry. It is important to note that the photos selected on either screen will be saved in the internal memory and will persist between each screen, allowing you to take photos from both camera and gallery at the same time. However, the selected photos will persist if you relaunch the application.

Final screen of the application is the `Analysis Screen`. Here you can send selected photos to the dedicated analysis server, where they will be analysed and the `Analysis Screen` will generate a report based on the information received from the server. At this screen you will be able to see the highlighted damage and damage types found by the models on the server. Each photo will be displayed in a scrollable difference frame, where you can easily see the difference between the pictures (see the app presentation video for better explanation). At this stage point of development, the server will always return the same results irrespective of the selected images. This a temporary behaviour and it will be changed in the final version of the app.


## Screencast

Demonstration of the work :

<img src="mid_proj_demo.gif" width="300" height="600" />

## Install

All dependencies in : `pubspec.yaml`

This application was succesfully tested on Google Pixel 5 (Android 13)

You can download APK : `app-release.apk` 

