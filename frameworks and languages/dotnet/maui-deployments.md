# Maui Deployments

## Android (Google Play Store)

[docu](https://learn.microsoft.com/en-us/dotnet/maui/android/deployment/?view=net-maui-9.0)

- Prepare the App for Release:
  - Set the build configuration to Release.
  - Update the AndroidManifest.xml with the correct version and permissions.
  - Optimize resources (compress images, remove unused code).
- Sign the App:
  - Generate a keystore:
  - `keytool -genkey -v -keystore my-release-key.keystore -alias my-key-alias -keyalg RSA -keysize 2048 -validity 10000`
  - Configure signing in your .csproj file

- Build the App:
  - Generate an APK for sideloading:
  - `dotnet publish -f:net8.0-android -c Release -p:AndroidPackageFormat=apk`
  - Generate an AAB (required for Google Play submission):
  - `dotnet publish -f:net8.0-android -c Release -p:AndroidPackageFormat=bundle`
- Submit to Google Play:
  - Upload the AAB file to the Google Play Console.
  - Fill in store listing details (screenshots, descriptions, pricing).
  - Complete the App Content policy requirements.
  - Submit for review.

## iOS (Apple App Store)

[docu](https://learn.microsoft.com/en-us/dotnet/maui/ios/deployment/?view=net-maui-9.0)

- Prepare the App for Release:
  - Set the build configuration to Release.
  - Update the Info.plist with the correct version and permissions.
  - Optimize resources.
- Sign the App:
  - Sign in with your Apple Developer account in Visual Studio.
  - Use automatic provisioning or manually download certificates from the Apple Developer Portal.
- Build the App:
  - Generate an IPA file:
  - `dotnet publish -f:net8.0-ios -c Release -p:BuildIpa=true`
- Submit to the App Store:
  - Upload the IPA file using Xcode or Transporter.
  - Fill in store listing details (screenshots, descriptions, pricing).
  - Complete the App Privacy policy requirements.
  - Submit for review.

## Pipelines for automated deployment

### Gitlab

```bash
image: mcr.microsoft.com/dotnet/sdk:9.0-alpine

stages:
  - prepare
  - test
  - build
  - deploy

prepare:
  stage: prepare
  script:
    - apk update && apk add openjdk11
    - dotnet workload install maui-android maui-ios
    - dotnet restore

test:
  stage: test
  script:
    - dotnet test --logger trx --results-directory ./TestResults

build:
  stage: build
  script:
    - dotnet publish -f net9.0-android -c Release -o ./publish/android
    - dotnet publish -f net9.0-ios -c Release -o ./publish/ios

sign_android:
  stage: build
  script:
    - jarsigner -verbose -sigalg SHA256withRSA -digestalg SHA-256 -keystore my-release-key.jks ./publish/android/app-release.apk my-key-alias
  dependencies:
    - build

sign_ios:
  stage: build
  script:
    - security import ios_distribution.p12 -P "$CERT_PASSWORD"
    - xcodebuild -exportArchive -archivePath ./publish/ios -exportOptionsPlist exportOptions.plist -exportPath ./signed/ios
  dependencies:
    - build

deploy_android:
  stage: deploy
  script:
    - curl -T ./signed/android/app-release.apk -u "$GOOGLE_PLAY_USER:$GOOGLE_PLAY_PASSWORD" https://play.google.com/upload

deploy_ios:
  stage: deploy
  script:
    - xcrun altool --upload-app -f ./signed/ios/MyApp.ipa --username "$APPLE_ID" --password "$APPLE_PASSWORD"


```

### Github

[Pipeline example](https://github.com/jfversluis/dotnet-maui-pipelines)

[Packaging and Publishing a .NET MAUI Library with GitHub Actions](https://devblogs.microsoft.com/dotnet/dotnet-maui-libraries-github-actions/)

```bash
```
