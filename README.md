# Teacher Class Overview

A Flutter application designed for teachers to view and manage their class schedules and student performance.

## 🚀 Setup Instructions

1. **Prerequisites**: Make sure you have the [Flutter SDK](https://flutter.dev/docs/get-started/install) installed and added to your system path.
2. **Clone the repository**: Navigate to your workspace and clone the project.
3. **Install Dependencies**:
   Open your terminal in the project root (`exg_parent`) and run:
   ```bash
   flutter pub get
   ```
4. **Run the App**:
   Ensure you have an emulator running or a physical device connected, then execute:
   ```bash
   flutter run
   ```

## 📁 Folder Structure

The application is built with a highly modular and decoupled architecture, separating data, state orchestration, and presentation logic. All source code is located within the `lib/` directory.

```text
lib/
├── main.dart                 # Application entry point and root widget
├── mock_data/                # Static data simulating a backend API
│   ├── mock_classes.dart
│   └── mock_students.dart
├── models/                   # Data classes representing domain entities
│   ├── class_model.dart
│   └── student_model.dart
├── screens/                  # Top-level, stateful UI pages
│   ├── my_classes_screen.dart     # Screen 1: Dashboard / Class List
│   └── class_details_screen.dart  # Screen 2: Individual Class & Student Stats
├── theme/                    # Centralized design system (Tokens)
│   ├── app_colors.dart       # Semantic color aliases (Cornflower Blue palette)
│   ├── app_text_styles.dart  # Typography (Hanken Grotesk & Work Sans)
│   └── app_theme.dart        # Radii, spacing, and shadows
└── widgets/                  # Reusable, stateless UI components
    ├── app_bottom_nav.dart
    ├── app_card.dart
    ├── class_card.dart
    ├── empty_state.dart
    ├── filter_chip_group.dart
    ├── skeleton_loader.dart
    └── ...
```

## ✨ Design & Architecture Notes

- **Theming**: The app strictly adheres to a centralized design system. No hardcoded hex colors or arbitrary padding values are used in the UI components; everything references the `theme/` definitions.
- **Component Reusability**: Complex screens are broken down into smaller, testable widgets located in the `widgets/` folder. The `screens/` files are solely responsible for state management and layout orchestration.
- **Responsive Layouts**: Layouts are built to prevent overflow on small screens (e.g., using `FittedBox` for large text and grids/wrap layouts where appropriate).
