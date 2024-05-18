# Shoesly Commerce App with Flutter and Firebase

A brief video overview



https://github.com/caxtonmbuvi/shoesly/assets/57038806/f6ed0384-e199-42bc-babf-f6c295357a5a





A comprehensive shoe commerce application built with Flutter and Firebase, featuring product listing, cart management, and payment processing.

## Project Setup Instructions

### Prerequisites

- Flutter installed (Follow the instructions on the [Flutter website](https://flutter.dev/docs/get-started/install))
- Dart installed (Flutter comes with Dart)
- Firebase project set up (Follow the [official guide](https://firebase.flutter.dev/docs/overview))

### Installation
1. **Clone the Repository**:
   ```bash
   git clone (https://github.com/caxtonmbuvi/shoesly.git)
   
2. **Install Dependencies**:
   ```bash
   Flutter dependencies: flutter pub get

3. **Set Up Firebase**:
   ```bash
   Flutter dependencies: flutter pub get
   Create a Firebase Project: Go to the Firebase Console, create a new project.
   Add Firebase to Your Flutter App:
   Add google-services.json (for Android) in android/app directory.
   Add GoogleService-Info.plist (for iOS) in ios/Runner directory.
   Enable Firestore and Authentication: Enable Firestore and the necessary authentication methods (Email/Password, Google, etc.).
  
4. **Run the App**:
   ```bash
   Connect a device or start an emulator, and run: flutter run


Assumptions Made During Development
1. User Authentication:
    ```bash
    Users need to be authenticated to make a purchase.
    Basic user information (like name) is stored in Firestore during purchase.

2. Product Data:
    ```bash
    Product details such as name, price, description, and images are stored in Firestore are not the real prices but place holders.
    Products may not match the colors available.Some only have one image.
    Some brand Icons may not match the category.

3. Payment Processing:
    ```bash
    Payment success is simulated; integration with a real payment gateway can be added later.
    Payment details are stored in Firestore upon success.


Challenges Faced and How They Were Overcome
1. Firestore Data Structure:
    ```bash
    Challenge: Designing an efficient data structure for products and orders information.
    Solution: Structured Firestore collections with proper indexing and references.

2. State Management:
    ```bash
    Challenge: Managing state across multiple pages (cart, product listing, order history).
    Solution: Utilized the Bloc/Cubit pattern with the flutter_bloc package for clean and maintainable state management.

3. Challenge: Handling network errors, authentication errors, and other exceptions.
    ```bash
    Solution: Implemented robust error handling using Bloc’s error state and custom error messages.


Additional Features or Improvements Added
1. Payment Success and Order History Pages:
   ```bash
   Added pages to display payment success confirmation and to view order history.

1. Persistent Cart:
   ```bash
   Implemented cart persistence using SharedPreferences, allowing the cart to be cached locally and restored when the app is reopened.
   
1. Improved Error Messages:
   ```bash
   Enhanced user experience by displaying user-friendly error messages and handling various edge cases.
   
