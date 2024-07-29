# Travel Life
This product aims to help users arrange their road trips and keep them connected and well-informed about the events of their journey.

![Travel_Life](https://github.com/tanzeelRehman/travel-life/blob/main/travelLifeCover.jpg)

# Installation
- Updated to Flutter 3.22.2 Now!
- Dart SDK 3.4.3 with Sound Null Safety

```bash
flutter clean
flutter pub get
dart setup/setup.dart --packageName=com.starter.project --dartBundleName=starter --appName=Starter
flutter pub get
```

# Main Features
- Vehicle Registration / Accessories / Operating Costs
- Vehicle Accessories
- Event creation
- Event Groups
- Group Chat
- Live navigation on the road
- Event Money Manager

# Technologies
- Flutter with STACKED Architecture
- SUPABASE for backend
- Open route service for maps

# API Information
- All API keys are removed because database access is restricted


### AppBundle:
`flutter build appbundle --release --flavor prod -t lib/main_prod.dart`


## Build Runner Build

`flutter packages pub run build_runner build --delete-conflicting-outputs
