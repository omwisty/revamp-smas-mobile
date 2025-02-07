# Revamp SMAS Mobile Applications

This application is revamp from previous applications

## Stack

This application build from Scratch with :

-   Flutter Version `2.8.1`
-   Dart `2.15.1`

### Platform

-   Android
-   iOS

### Dependencies

Core dependencies using :

-   [GetX](https://pub.dev/packages/get) : High-performance state management, intelligent dependency injection, and route management quickly and practically
-   [Hive](https://pub.dev/packages/hive) : Lightweight and blazing fast key-value database
-   [Dio](https://pub.dev/packages/dio) : A powerful Http client for Dart, which supports Interceptors, Global configuration, FormData, Request Cancellation
-   [Material Design](https://material.io/design) : Material is a design system created by Google

Another dependencies :

see detail at `pubscpec.yaml`

### Environment

-   Development
-   Staging
-   Production

### How to run

-   Run with env development:
    ```
    flutter run --flavor dev -t lib/env/main_development.dart
    ```

-   Run with env staging:
    ```
    flutter run --flavor dev -t lib/env/main_staging.dart
    ```

-   Run with env production:
    ```
    flutter run --flavor prod -t lib/env/main_prod.dart
    ```

If You are using `Android Studio` create configuration at the top bar

### How to build applications

-   Android

    Create APK :

    ```
    flutter build apk --flavor {ENVIRONMENT} -t lib/env/main_{ENVIRONMENT}.dart
    ```

    Create App Bundle :

    ```
    flutter build appbundle --flavor {ENVIRONMENT} -t lib/env/main_{ENVIRONMENT}.dart
    ```

-   iOS

    using xcode

## Flutter Documentation

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
