# 📱 Simple Calculator App

A modern, clean, and responsive Calculator application built with **Flutter** using the **BLoC (Business Logic Component)** pattern for scalable and robust state management.

---

## 🌟 Key Features

* **Core Arithmetic Operations:** Addition (`+`), Subtraction (`-`), Multiplication (`×`), and Division (`÷`).
* **Input Validation & Edge Case Handling:** Protects against invalid numeric entries, empty fields, and division-by-zero errors.
* **Reactive UI:** Instant visual feedback and dynamic state rebuilding powered by `flutter_bloc`.
* **Clean UI/UX Design:** Modern Material 3 interface matching production-grade design specifications with custom operation selectors.

---

## 🏗️ Architecture & State Management

The project strictly follows the **BLoC pattern** to separate business logic from the user interface:

* **`CalculatorEvent`:** Defines actions dispatched from the UI (e.g., selecting an operation, submitting numbers for calculation).
* **`CalculatorState`:** Encapsulates the immutable state representing the UI (selected operation, calculated result, equation string, and error messages).
* **`CalculatorBloc`:** Handles business logic, validates decimal inputs, executes arithmetic, and emits updated states.

### Project Structure
```text
lib/
├── bloc/
│   ├── calculator_event.dart   # Events triggered by user interaction
│   ├── calculator_state.dart   # UI states
│   └── calculator_bloc.dart    # Business logic & calculations
├── calculator_screen.dart      # View layer (Widgets & Builders)
└── main.dart                   # Application entry point & BlocProvider
