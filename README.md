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

### Web Deployment

To build the project for the web, follow these steps:

1. **Ensure Flutter Web is Enabled**  
   Make sure you are on the stable channel and that Flutter Web is enabled. You can check your current Flutter setup with:
   
   ```bash
   flutter doctor
   ```

   If Flutter Web is not enabled, you can run the following command to switch to the appropriate Flutter channel:
   
   ```bash
   flutter channel stable
   flutter upgrade
   ```

2. **Build for Web**  
   To build the project for web deployment, run the following command:
   
   ```bash
   flutter build web
   ```

   This will compile your project into a web application.

3. **Output Location**  
   After the build completes, the output will be located in the `/build/web` directory. This contains the files you can deploy to your web server.

   - `index.html`: The main entry point of your app.
   - `main.dart.js`: The compiled JavaScript file.
   - `flutter_service_worker.js`: The service worker for caching and background services.
   - Other assets: All images, fonts, and other assets required by the app.

4. **Deploying to a Web Server**  
   Once you have the build files, you can deploy them to any static file hosting service or web server. Some common options for hosting include:
   - [Firebase Hosting](https://firebase.google.com/docs/hosting)
   - [Netlify](https://www.netlify.com)
   - [GitHub Pages](https://pages.github.com)

   Simply upload the files from the `/build/web` directory to your chosen platform and your app will be live on the web!

---

### Android Deployment

To build the project for Android, follow these steps:

1. **Ensure Android is Set Up**  
   Make sure you have Android Studio and the required SDKs installed. Verify with:
   
   ```bash
   flutter doctor
   ```

2. **Build for Android**  
   Run the following command to build the APK or App Bundle:
   
   ```bash
   flutter build apk  # For APK file
   flutter build appbundle  # For App Bundle (recommended for Play Store)
   ```

3. **Output Location**  
   The generated APK will be located in the `/build/app/outputs/flutter-apk/` directory. For an App Bundle, it will be in `/build/app/outputs/bundle/release/`.

4. **Deploying to the Google Play Store**  
   If you're ready to deploy, you can upload the APK or App Bundle to the [Google Play Console](https://play.google.com/console).

---

### iOS Deployment

To build the project for iOS, follow these steps:

1. **Ensure iOS Setup**  
   Make sure you have Xcode installed and set up correctly. You can verify your setup with:
   
   ```bash
   flutter doctor
   ```

2. **Build for iOS**  
   To build the project for iOS, use the following command:
   
   ```bash
   flutter build ios
   ```

3. **Output Location**  
   The build files for iOS will be located in the `/build/ios/iphoneos/` directory.

4. **Deploying to the App Store**  
   You can deploy your app to the [App Store](https://developer.apple.com/app-store/) using Xcode or the Transporter app. Make sure to follow Apple's guidelines for app submission.

---

### Windows Deployment

To build the project for Windows, follow these steps:

1. **Ensure Windows Setup**  
   Ensure you have the necessary dependencies for Windows development. You can check with:
   
   ```bash
   flutter doctor
   ```

2. **Build for Windows**  
   To build the project for Windows, run the following command:
   
   ```bash
   flutter build windows
   ```

3. **Output Location**  
   The build files for Windows will be located in the `/build/windows/runner/Release/` directory. The executable file will be named after your project.

4. **Deploying to Windows**  
   After building, you can distribute the `.exe` file or package it as an installer using tools like [Inno Setup](https://jrsoftware.org/isinfo.php) or [NSIS](https://nsis.sourceforge.io/).

---

### Additional Notes

- Refer to the official [Flutter documentation](https://flutter.dev/docs) for more detailed instructions and platform-specific guidelines.
