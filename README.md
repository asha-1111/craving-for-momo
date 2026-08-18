# Craving for Momo

A responsive Flutter Web food-ordering website developed for Craving for Momo, a home-delivery momo business serving Sylhet Sadar, Bangladesh.

## Live Demo

[View Live Website](https://asha-1111.github.io/craving-for-momo/)

## Project Overview

Craving for Momo is a modern food-ordering website designed to provide customers with a simple and convenient way to browse the menu, select products, manage a cart, complete checkout, and submit an order.

The website is built with Flutter Web and follows a responsive design approach so that the interface adapts to desktop, tablet, and mobile screen sizes.

## Features

- Responsive Flutter Web interface
- Premium pastel blue and peach gradient design
- Interactive menu and product cards
- Product size and quantity selection
- Shopping cart management
- Add, remove, increase, and decrease cart items
- Automatic subtotal and total calculation
- Checkout form with input validation
- bKash manual payment workflow with transaction ID input
- Order confirmation screen
- Home-delivery information for Sylhet Sadar
- Reusable UI components
- Provider-based cart state management

## Design System

The visual identity of the website is based on the following primary colors:

- Pastel Blue: `#C9D3EC`
- Pastel Peach: `#FED7B8`

The interface uses these colors as the primary background gradient, supported by clean typography, rounded cards, subtle shadows, and minimal visual elements.

## Customer Flow

```text
Home
  |
  v
Menu
  |
  v
Select Product and Size
  |
  v
Add to Cart
  |
  v
Review Cart
  |
  v
Checkout
  |
  v
Select bKash Payment
  |
  v
Enter Transaction ID
  |
  v
Place Order
  |
  v
Order Confirmation
```

## Payment Workflow

The current version implements a manual bKash payment workflow.

1. The customer selects bKash during checkout.
2. The customer completes the payment using the business bKash number.
3. The customer enters the transaction ID.
4. The customer submits the order.

The application does not include automatic bKash payment verification unless a real payment gateway integration is added.

## Technology Stack

- Flutter
- Dart
- Flutter Web
- Provider
- Material and custom Flutter theming
- Git
- GitHub

## Project Structure

```text
craving_for_momo/
|
+-- android/
|   Android platform configuration
|
+-- assets/
|   Images and other application assets
|
+-- ios/
|   iOS platform configuration
|
+-- lib/
|   |
|   +-- core/
|   |   +-- constants/
|   |   |   Application-wide constants
|   |   |
|   |   +-- theme/
|   |       Application theme and styling
|   |
|   +-- models/
|   |   Data models used by the application
|   |
|   +-- screens/
|   |   Application screens and page-level UI
|   |
|   +-- services/
|   |   Business logic and application services
|   |
|   +-- widgets/
|   |   Reusable UI components
|   |
|   +-- main.dart
|       Application entry point
|
+-- test/
|   Widget and application tests
|
+-- web/
|   Flutter Web configuration and entry files
|
+-- pubspec.yaml
|   Project configuration and dependencies
|
+-- pubspec.lock
|   Locked dependency versions
|
+-- README.md
|   Project documentation
|
+-- .gitignore
    Git ignored files and directories
```

## Getting Started

### Prerequisites

Install the following before running the project:

- Flutter SDK
- Android Studio or Visual Studio Code
- Google Chrome
- Git

Verify the Flutter installation:

```bash
flutter doctor
```

### Clone the Repository

```bash
git clone https://github.com/asha-1111/craving-for-momo.git
cd craving-for-momo
```

### Install Dependencies

```bash
flutter pub get
```

### Run the Web Application

```bash
flutter run -d chrome
```

The application will open in Google Chrome.

### Run Tests

```bash
flutter test
```

### Analyze the Project

```bash
flutter analyze
```

### Build for Production

```bash
flutter build web --release
```

The production web build will be generated inside:

```text
build/web/
```

## Deployment

The project is designed for Flutter Web deployment. A production build can be hosted on a static web hosting platform such as GitHub Pages or Firebase Hosting.

For GitHub Pages deployment, the application should be built with the repository path as the web base path when the site is hosted under a project repository URL.

Expected GitHub Pages URL:

```text
https://asha-1111.github.io/craving-for-momo/
```

## Business Configuration

Business-specific information such as phone number, bKash number, and social media links should be stored in the application's configuration/constants and replaced with the actual business information before production use.

Sensitive information such as passwords, secret keys, access tokens, and private credentials must not be committed to the repository.

## Author

GitHub: https://github.com/asha-1111
