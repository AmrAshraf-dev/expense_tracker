# expense_tracker
Expense tracker is an app to track all your expenses with every detail and to convert any currency you use to USD
===========================================================================================================================================================================
# Overview of the Architecture and Structure:
lib/
├── controller/
│   ├── helper/
├── model/
│   └── models/
├── view/
│   └── blocs/
|   |__ widgets/
├── utils/
│   └── my_colors/
├── widgets/
│   └──
└── main.dart
===========================================================================================================================================================================
# State Management Approach:
The app uses Bloc (Business Logic Component) as the state management solution. Bloc was chosen to provide clear separation between UI and business logic. This allows for:

Predictable state transitions
Reusability of logic
Easier testing
Each feature (e.g., expenses, currency) has its own Bloc handling all related events and states.

===========================================================================================================================================================================
# API Integration:
API integration is implemented using the http package with an abstraction layer for separation of concerns.
A dedicated CurrencyApiService fetches real-time exchange rates.
The response is parsed and passed to the Bloc, which updates the UI accordingly.
Errors are caught and handled gracefully through states like ErrorState.

===========================================================================================================================================================================
# Pagination Strategy
Local Pagination is used for expense records retrieved from SQLite.
Data is fetched in batches of 10 items.
The pagination logic is handled in the Bloc by keeping track of current page and fetching more data when the user scrolls.
This reduces memory usage and enhances performance for large datasets.

===========================================================================================================================================================================
# How to Run the Project
1-Clone the repository
git clone <repo-url>
cd <project-folder>

2-Install dependencies
flutter pub get

3-Run the app
flutter run

Run tests
flutter test

# Ensure you are using the latest stable version of Flutter and have a connected device or emulator running.
===========================================================================================================================================================================






