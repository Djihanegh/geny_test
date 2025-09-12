# geny_test

# Tech Notes — geny_test

## 📁 Project Architecture

- Feature-first structure:  
  `lib/features/businesses/` holds the businesses feature:  
  ├─ `data/` — remote & local providers, models  
  ├─ `repository/` —  repository interface  
  ├─ `ui/` — UI widgets/pages

- Core/Shared code in `lib/core/`:  
  - Network / Dio setup  
  - Local storage / persistence (Hive)  
  - Utility classes, error handling, constants
  - Controller -- ItemsNotifier : a Global Provider ( with proper error, loading, states handling ) 
  - Exception -- Global AppException handling
  - Shared UI and Widgets ( ItemsList ) 

## 🛠 State Management

- Using **Provider** (ChangeNotifier) for business state:  
  `ItemsNotifier<Business>`  
- Search is handled in the state to avoid extra API calls

## 🔌 Networking & Persistence

- Remote provider (Dio) fetches businesses JSON  
- Local provider (HiveBox) responsible for caching data locally  
- On `getAll()`: check connectivity, fetch remote if online, save to local; fallback to local if offline or remote fails

## 🎯 Navigation

- Using `go_router` for routing  

## 🔮 What to Improve / Future Work
- Improve the UI.
- Add unit/widget tests + integration tests for API / persistence / UI paths.  
- Possibly add pagination if the businesses list grows.
- Add Localization.
- Add Debounce for Search.

