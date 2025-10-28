# wincare_modules

Wincare modules

## Getting Started

Build the project using the following command:

#### For code generator
```
flutter packages pub run build_runner build --delete-conflicting-outputs

For android:

```flutter build aar --output-dir=path_to_build directory```

for example:

build to native repo:

```flutter build aar --output-dir=/Users/uytb/Documents/projects/Wincare.Android/app/modules```

build to libs repo:

```flutter build aar --output-dir=/Users/uytb/Documents/projects/wincare-libs/android```


for ios:

```flutter build ios-framework --output=../MyiOSNativeApp/Flutter/```
```If add new package, add it to FlutterPluginRegistrant.podspec first```
```Add and Signed its to Frameworks and Libraries in Xcode```
```Then run pod install in native ios repo```

for example:

```flutter build ios-framework --output=/Users/uytb/Documents/projects/test-embed-flutter/Flutter```

build to native repo with only release:

```flutter build ios-framework --release --no-debug --no-profile --output=/Users/uytb/Documents/projects/test-embed-flutter/Flutter```

build to libs repo with only release:

```flutter build ios-framework --release --no-debug --no-profile --output=/Users/uytb/Documents/projects/wincare-libs/ios```
