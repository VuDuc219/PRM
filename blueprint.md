# Project Blueprint

## Overview

This is a Flutter application for a coffee shop. It allows users to browse different coffee categories, view product details, manage their profile, and authenticate.

## Implemented Features

*   **Authentication:**
    *   User signup and login with email and password using Firebase Authentication.
    *   User data (name, email, profile image URL) is stored in Cloud Firestore upon registration.
*   **User Profile:**
    *   Displays the user's name, email, and profile picture fetched from Firestore.
    *   Allows users to edit their name and profile picture.
    *   Profile pictures are uploaded to Firebase Storage, and the URL is updated in the user's Firestore document.
    *   A loading indicator is displayed while user data is being fetched.
*   **Home Screen:** Displays a banner, a search bar, and sections for "Today's Special" and "Best Sellers".
*   **Category Screen:** Shows a list of coffee categories.
*   **Product Detail Screen:** Shows details for a selected product.
*   **Theming:**
    *   Uses a `ValueNotifier` in `main.dart` to manage and switch between light and dark themes.
*   **Asset Management:**
    *   Images for banners, products, and icons are stored in `assets/images/` and `assets/icons/`.
    *   `pubspec.yaml` is configured to include these assets.
*   **Dependencies:**
    *   `velocity_x`: For UI development.
    *   `get`: For state management and navigation.
    *   `firebase_core`: For Firebase integration.
    *   `firebase_auth`: For authentication.
    *   `cloud_firestore`: For database.
    *   `firebase_storage`: For file storage.
    *   `image_picker`: For selecting images from the gallery.

## Current Plan

The requested features for the profile screen have been implemented. The system is now ready for further development or new feature requests.
