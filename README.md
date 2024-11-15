# Noise Monitoring App

This app provides real-time noise monitoring and logging capabilities, addressing urban noise pollution. Users can track current and average decibel levels on an interactive map, adding markers for data visualization.

---

## 📱 Features
- **Real-time Noise Detection**: Monitors and displays current and average decibel levels.
- **Interactive Map**: Add, view, and delete noise data markers.
- **Cross-Platform**: Compatible with mobile, web, and desktop.

---

# 🛠 Installation Guide (For Developers)

### Prerequisites

Before you begin, ensure you have the following tools installed:

- **Android Studio**: A powerful IDE for Flutter development. [Install Android Studio](https://developer.android.com/studio)
- **Flutter SDK**: The open-source framework for building natively compiled applications. [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Git**: A version control tool to clone the repository. [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Steps to Set Up the Project

1. **Clone the Repository**  
   First, clone the project repository to your local machine using Git:
   
   ```bash
   git clone https://github.com/yourusername/noise-monitoring-app.git
   cd noise-monitoring-app
   ```

2. **Install Dependencies**  
   Next, fetch the necessary dependencies using Flutter’s package manager:
   
   ```bash
   flutter pub get
   ```

3. **Set Up Android Emulator or Device**  
   If you plan to run the app on an Android emulator or a physical device, ensure that Android Studio is properly set up to run emulators or connect your device via USB. You can verify your connected devices with:
   
   ```bash
   flutter devices
   ```

4. **Run the App**  
   To build and run the app on your emulator or device, execute:
   
   ```bash
   flutter run
   ```

5. **Testing the App**  
   If you’re making changes, you can use Flutter’s hot reload feature to see the changes live in your app without restarting it:
   
   ```bash
   flutter hot reload
   ```

6. **Building the App**  
   When you’re ready to create a release build for the app, you can run:
   
   ```bash
   flutter build apk
   ```

   Or, for an iOS build (if applicable):
   
   ```bash
   flutter build ios
   ```

### Troubleshooting

If you encounter any issues during the installation process, consider the following:

- **Ensure all dependencies are up to date**: Run `flutter upgrade` to update Flutter and its dependencies.
- **Check for any missing environment variables**: If Flutter commands aren’t recognized, ensure your system’s PATH includes the Flutter SDK.
- **Emulator Issues**: If you encounter issues with the Android emulator, check if virtualization is enabled in your BIOS/UEFI settings.

### Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Android Studio Setup for Flutter](https://developer.android.com/studio)
- [Git Documentation](https://git-scm.com/doc)

## 📦 Building for Different Platforms
# Web Deployment
To build for the web:
```bash
flutter build web
```
The output will be located in the /build/web directory.

