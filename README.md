<!-- Animated Header -->
<h1 align="center">
  🧠 Habit Tracker App
</h1>

<p align="center">
  <b>Build better habits. Track progress. Stay consistent.</b>
</p>

<p align="center">
  <img src="https://readme-typing-svg.herokuapp.com?size=22&duration=3000&color=36BCF7&center=true&vCenter=true&width=600&lines=Track+Your+Daily+Habits;Visualize+Progress+with+Heatmaps;Clean+Architecture+Flutter+App;Responsive+%2B+Dark+Mode+Support" />
</p>

---

## 🚀 Overview

A **beautiful and intuitive Habit Tracking application** built with **Flutter**.
It helps users build and maintain positive habits using:

- 📅 Calendar heatmaps
- ✅ Daily habit checklists
- 📊 Progress statistics
- 📱 Fully responsive UI
- 🌙 Dark mode support

---

## ✨ Features

- ✅ **Daily Habits** – Check off completed habits each day
- 📅 **Heatmap Calendar** – Color-coded visualization of consistency
- 📊 **Progress Statistics** – Track completion percentage
- ✏️ **Edit & Delete Habits**
- 🔔 **Reminders** *(Optional)*
- 🎨 **Clean Material UI**
- 🌓 **Dark & Light Theme Support**
- 📱 **Responsive Layout (Mobile + Tablet + Web)**
- 💾 **Offline First – Local Storage using Hive**

---

## 📸 Screenshots

> Replace these with your actual screenshots or GIFs

| Light Mode | Dark Mode |
|------------|------------|
| ![light](screenshots/light.png) | ![dark](screenshots/dark.png) |

🎥 You can also add a demo GIF:

```
![Demo](screenshots/demo.gif)
```

---

## 🛠️ Tech Stack

| Technology | Purpose |
|------------|----------|
| **Flutter** | UI Framework |
| **Dart** | Programming Language |
| **GetX** | State Management + Routing |
| **Hive** | Local NoSQL Database |
| **flutter_heatmap_calendar** | Habit Heatmap |
| **flutter_slidable** | Swipe Actions |
| **intl** | Date Formatting |
| **flutter_local_notifications** | Reminders (Optional) |

---

## 🧱 Project Architecture

This project follows **Clean Architecture** principles:

```
lib/
├── main.dart
├── core/
│   └── utils/
│       └── date_time_helper.dart
├── data/
│   ├── datasources/
│   │   └── local/
│   │       └── habit_local_datasource.dart
│   ├── models/
│   │   ├── habit.dart
│   │   └── daily_summary.dart
│   └── repositories/
│       └── habit_repository_impl.dart
├── domain/
│   └── repositories/
│       └── habit_repository.dart
└── presentation/
    ├── controllers/
    │   └── habit_controller.dart
    ├── pages/
    │   └── home_page.dart
    ├── widgets/
    │   ├── responsive_layout.dart
    │   ├── habit_tile.dart
    │   ├── monthly_summary.dart
    │   ├── my_alert_box.dart
    │   └── my_fab.dart
    └── theme/
```

---

## ⚙️ How It Works

1. **Habits** are stored locally using Hive.
2. Each habit tracks daily completion.
3. A **daily summary** calculates completion percentage.
4. The **heatmap** visualizes consistency over time.
5. **GetX** ensures reactive UI updates.
6. The layout automatically adapts for:
   - 📱 Mobile (Vertical layout)
   - 💻 Web/Tablet (Side-by-side layout)

---

## 📦 Installation

### 🔹 Prerequisites

- Flutter 3.0+
- Dart 2.18+
- Android Studio / VS Code
- Xcode (for iOS)

---

### 🔹 Clone Repository

```bash
git clone https://github.com/yourusername/habit_tracker.git
cd habit_tracker
```

---

### 🔹 Install Dependencies

```bash
flutter pub get
```

---

### 🔹 Generate Hive Adapters

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

### 🔹 Run the App

```bash
flutter run
```

---

## 📚 Dependencies

Add this inside your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.6
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  flutter_heatmap_calendar: ^1.0.5
  flutter_slidable: ^4.0.3
  intl: ^0.20.2
  flutter_local_notifications: ^17.2.3

dev_dependencies:
  flutter_test:
    sdk: flutter
  hive_generator: ^1.1.3
  build_runner: ^2.1.11
```

---

## ⚙️ Platform Configuration

### 🤖 Android
No special setup required.
For notifications, configure permissions in:

```
android/app/src/main/AndroidManifest.xml
```

---

### 🍎 iOS
Enable notification capabilities in Xcode if using reminders.

---

### 🌐 Web
Fully supported.
Responsive layout adapts automatically to browser width.

---

## 🤝 Contributing

Contributions are welcome!

```bash
git checkout -b feature/AmazingFeature
git commit -m "Add AmazingFeature"
git push origin feature/AmazingFeature
```

Then open a Pull Request 🚀

---

## 📄 License

This project is licensed under the **MIT License**.
See `LICENSE` file for details.

---

## 🙏 Acknowledgements

- Flutter Team
- GetX
- Hive
- flutter_heatmap_calendar
- All open-source contributors ❤️

---

<p align="center">
  ⭐ If you like this project, don't forget to star the repository!
</p>