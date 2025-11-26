# Wincare modules

Flutter modules for Wincare app

## Check list for building module and embed to Wincare app

#### 1. Check ENV and Method channel
    A. Check ENV (DEV, UAT, PRO) in main.dart -> Update based on target
    B. Check setupChannelHandler is called 
#### 2. Generation code
Run ```flutter packages pub run build_runner build --delete-conflicting-outputs``` for generate code
#### 3. Android build & setup
Run ```flutter build aar --output-dir=/Users/uytb/Documents/projects/tcx_projects/Wincare.Android/app/modules``` for generate aar to folder modules of native repo
#### 4. iOS build & setup
Run ```flutter build ios-framework --cocoapods```

In iOS native project, Podfile -> add below:

    flutter_application_path = '../wincare_modules'
    load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')
    flutter_post_install(installer)

Then run

```pod install```
