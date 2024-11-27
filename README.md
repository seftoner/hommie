# Hommie - Flutter client for HomeAssistant
This project aims to create a beautiful client app for Home Assistant (HA) using Dart and Flutter. The client communicates with the Home Assistant instance via WebSocket API

## Motivation
The motivation behind this project is to create a visually appealing and user-friendly client app for Home Assistant that can run on various platforms.

I also love practicing programming and exploring new technologies, making this pet project both a learning experience and a source of fun for me.

## Featueres
Currently, there are not many of them. I want to design a good architecture (skeleton), so I can easily add new features (muscles).
I want to add 'Companion App' functionality in the near future.

- **Authentication**: Users can authenticate and log out securely. This feature has been tested only on a local network.
  - Server Discovery: Automatically discovers available Home Assistant servers on the user’s local network, displaying them as a list for easy selection during authentication.
- **Areas**: List of areas
- **Companion App**: (In Progress): This feature will allow the app to register on the Home Assistant server and send location and other sensor data.

### Platforms
1. iOS - ✅
2. MacOS - ✅
3. Android - ⚠️(Not tested)
4. Windows - ⚠️(Not tested)
5. Linux ⚠️(Not tested)

## Build & Run
1. Get dependencies `flutter pub get` 
2. Run build_runer `dart run build_runner watch`

## Contribution
Contributions to this project are welcome! If you'd like to contribute, please fork the repository, make your changes, and submit a pull request. You can also open an issue to report bugs or suggest new features.

## License
This project is licensed under the [MIT License](LICENSE.txt)
