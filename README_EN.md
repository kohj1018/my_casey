# My Casey - Camp Casey & Hovey Bus App

[🇰🇷 한국어](README.md) | [🇺🇸 English](README_EN.md)

![My Casey App](https://img.notionusercontent.com/s3/prod-files-secure%2F0ec83f0d-0bf0-4877-bb09-68a1391c59b3%2Fbb7e39a6-7fb1-4abc-9986-511f86ad0151%2Funnamed.webp/size/w=2000?exp=1753033565&sig=Isf2D_XYYDhXagDE94Mca29Na4BjglrBtFeSQji57tA&id=1cc1b47a-3bd0-806e-9dd6-fd6bd0211181&table=block)

**[📱 View App Introduction](https://kbwportfolio.notion.site/My-Casey-1cc1b47a3bd0806e9dd6fd6bd0211181)**

A Flutter mobile application that provides bus schedules and facility operating hours for Camp Casey & Hovey bases.

## 🚌 Key Features

### Bus Schedule
- **3 Bus Routes**: H221, HOVEY, TMC
- **Real-time Information**: Shows next/previous bus times based on current time
- **Weekday/Weekend Distinction**: Automatically applies appropriate schedules
- **Timetable Version**: Toggle between latest and old timetables
- **Detailed Information**: View complete timetables for each bus route

### 📅 Schedule Management
- **Memo Feature**: Write, edit, and delete memos by date
- **Time Setting**: Set reminder times for memos
- **Local Storage**: Data persists after app restart
- **Sorting**: Automatic memo sorting by time

### 🏢 Operating Hours
- **Various Facilities**: DFAC, KATUSA PX, CAC, USO, Barber Shop
- **Real-time Status**: Shows current operating status
- **Weekday/Weekend Distinction**: Automatically applies appropriate operating hours
- **Detailed Information**: View detailed operating hours for each facility

## 🎨 UI/UX Features

- **Modern Design**: Material 3 design system implementation
- **Intuitive Interface**: Card-based layout
- **Color Coding**: Quick recognition through color-coded states
- **Multi-language Support**: Korean/English support
- **Real-time Updates**: Time information updates every second

## 🛠️ Tech Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: StatefulWidget + Stream
- **Local Storage**: SharedPreferences
- **Internationalization**: easy_localization
- **Calendar**: table_calendar
- **Fonts**: Google Fonts (Inter)

## 📱 Main Pages

### Main Screen
- Bus schedule tab
- Real-time bus information
- Automatic weekday/weekend detection

### Calendar Screen
- Date-based memo management
- Time setting functionality
- Intuitive UI

### Operating Hours Screen
- Facility-specific operating status
- Real-time information display
- Detailed information provision

## 📁 Project Structure

```
lib/
├── component/          # Reusable UI components
│   ├── bus_time_card.dart
│   ├── opening_hours_card.dart
│   └── ...
├── const/             # Constant data
│   ├── bus_time.dart      # Bus timetable data
│   ├── colors.dart        # Color constants
│   └── weekend_list.dart  # Weekend list
├── function/          # Business logic
│   ├── checkNearestBusTimes.dart
│   ├── isTodayWeekend.dart
│   └── ...
├── screen/            # Screen-specific UI
│   ├── home_screen.dart
│   ├── bus_schedule_screen.dart
│   ├── calendar_screen.dart
│   └── opening_hours_screen.dart
├── theme/             # App theme
│   └── app_theme.dart
└── main.dart          # App entry point
```

## 🔧 Key Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  intl: ^0.20.2
  table_calendar: ^3.0.9
  shared_preferences: ^2.2.1
  easy_localization: ^3.0.3
  google_fonts: ^6.1.0
```

## 🌟 Detailed Key Features

### Bus Time Calculation Algorithm
- Automatically calculates nearest bus times based on current time
- Automatic weekday/weekend detection and appropriate timetable application
- Real-time display of remaining time

### Memo System
- JSON-based local storage
- Time-settable memos
- Date-based memo management
- Intuitive edit/delete functionality

### Operating Hours Management
- Facility-specific operating hours data management
- Real-time operating status display
- Automatic weekday/weekend distinction

## 🤝 Contributing

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is distributed under the MIT License. See the `LICENSE` file for details.

## 📞 Contact

For questions about the project or bug reports, please submit them through issues.

---

**My Casey** - Essential app for Camp Casey & Hovey bases 🚌✨ 