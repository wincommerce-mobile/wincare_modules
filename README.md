# wincare_modules

Wincare modules

## Getting Started

Build the project using the following command:

For android:

```flutter build aar --output-dir=path_to_build directory```

for example:

build to native repo:

```flutter build aar --output-dir=/Users/uytb/Documents/projects/WinCare/app/modules/```

build to libs repo:

```flutter build aar --output-dir=/Users/uytb/Documents/projects/wincare-libs/android```


for ios:

```flutter build ios-framework --output=../MyiOSNativeApp/Flutter/```

for example:

```flutter build ios-framework --output=/Users/uytb/Documents/projects/test-embed-flutter/Flutter```

build to native repo with only release:

```flutter build ios-framework --release --no-debug --no-profile --output=/Users/uytb/Documents/projects/test-embed-flutter/Flutter```

build to libs repo with only release:

```flutter build ios-framework --release --no-debug --no-profile --output=/Users/uytb/Documents/projects/wincare-libs/ios```