# Just Call

> **A gentle way to stay connected with the people who matter.**

Just Call is a relationship-first mobile app designed to help you stay meaningfully connected with your loved ones. Instead of overwhelming you with tasks or constant alerts, Just Call takes a gentle, trust-based approach to reminders, understanding that relationships thrive on intention, not pressure.

---

## 📖 About The App

This is not a task manager for calls. It’s a calm system for maintaining real human relationships.

**The Philosophy:**
- **Zero Guilt:** No "overdue" red text or badge counts that make you feel bad.
- **Intention > Obligation:** Reminders are framed as opportunities to connect, not chores to complete.
- **Quality > Quantity:** Limits notifications to a single, thoughtful nudge per day.

### How It Works
1.  **Morning Summary:** Start your day with a soft summary that helps you set your intention to connect.
2.  **Gentle Nudge:** Throughout the day, you might receive *one* thoughtful reminder—never too many, never at the wrong time.
3.  **Evening Reflection:** Close the day with a quiet moment to reflect on your interactions, reinforcing connection as a habit.
4.  **Seamless Integration:** Just Call integrates with your real call history to stay accurate without manual tracking.

---

## ✨ Key Features

- **Smart Call Logging:** Automatically syncs with your device's call history to track when you last spoke, so you don't have to manually "log" interactions.
- **Intelligent Timing:** Reminders are scheduled to respect your personal time, ensuring you aren't interrupted during deep work or late hours.
- **Privacy First:** Your data stays on your device. We use your call logs solely to help *you* remember, never for ads or tracking.
- **Calm UI:** A design aesthetic that features warm, vibrant colors and smooth animations to feel like a supportive friend, not a productivity tool.

---

## 🛠 Tech Stack

Built with **Flutter** for a beautiful, native performance on Android.

- **State Management:** [Riverpod](https://riverpod.dev/)
- **Local Database:** [Drift](https://drift.simonbinder.eu/) (SQLite)
- **Background Tasks:** [Workmanager](https://pub.dev/packages/workmanager) (for reliable background updates)
- **Notifications:** [Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications)
- **Integration:** 
    - `call_log` for accessing call history
    - `flutter_contacts` for efficient contact management

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.2.3)
- Android Studio / VS Code
- Android Device (Emulator or Physical)

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/carbonanik/call_monitor.git
    cd call_monitor
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the code generator (Drift/Riverpod):**
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

4.  **Run the app:**
    ```bash
    flutter run
    ```

*Note: Since this app relies on Call Logs and specific Android background permissions, testing on a physical device is recommended for the full experience.*

---

## 🔒 Privacy & Permissions

To function correctly, Just Call requires the following permissions:
- **Call Log:** To automatically update your "last spoken" dates so you don't have to.
- **Contacts:** To let you select who matters most.
- **Notifications:** To send those gentle nudges.

**We do not collect this data.** Everything is processed locally on your device.

---

*Stay present. Stay connected.*
