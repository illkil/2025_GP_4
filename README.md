# Wujed – AI-Powered Lost & Found System

Wujed is an intelligent digital platform designed to help the residents of Riyadh recover lost items more efficiently.  
The system enables users to report lost or found items by uploading a photo, adding a short description, and providing the location.  
Using artificial intelligence, Wujed compares text and image features to identify potential matches between reports. When a match is found, both users receive instant notifications and can communicate through a secure in-app chat to confirm the item and arrange its return.

In addition to the mobile application, Wujed includes a dedicated **web-based dashboard** for administrators. This dashboard allows the system team to monitor flagged reports and review AI-generated rejected matches, improving the platform’s accuracy and reliability.



## Technologies Used

### **Programming Languages**
- Dart  
- Python  
- HTML  
- CSS  
- JavaScript  
- JSON
- Node.js

### **Frameworks**
- Flutter Framework

### **Database & Cloud Services**
- Firebase Authentication  
- Cloud Firestore  
- Firebase Storage  
- Firebase Realtime Database (Chat)  
- Firebase Cloud Messaging (Notifications)  
- Firebase App Check (Security)

### **AI & Machine Learning**
- Google Vision API  
- OpenAI NLP API

### **Maps**
- Google Maps API

---
  
## 1. Mobile App – Getting Started

###  App Launch Instructions

Before running the Flutter application, make sure you have the following installed:

- **Flutter SDK**: If you haven't already, Install Flutter from the official link: [official Flutter installation guide](https://docs.flutter.dev/get-started/install).

- **Integrated Development Environment (IDE)**: We recommend using Visual Studio Code (VS Code) for developing Flutter applications. If you don't have it installed, you can download it from [here](https://code.visualstudio.com/download).

- **Emulator**:
  - You can use Xcode. you can download it from [here](https://apps.apple.com/sa/app/xcode/id497799835?mt=12).
  - Or you can use Android Studio, which you can download from [here](https://developer.android.com/studio).


### Installation and Launch Steps


1. Cloning the Project
```
$ git clone https://github.com/illkil/2025_GP_4.git
```
2. Accessing the Project Folder
```
$ cd wujed
```
3. Running the Application
```
$ flutter run
```

### Notes

It is recommended to use a physical machine or a powerful emulator for optimal performance.

Be sure to enable the required APIs in Google Cloud Console and Firebase before launching.

---
## 2- Dashboard – Launch Instructions

The Wujed Dashboard is a local web-based admin panel that runs using MAMP.

Before running the dashboard, ensure you have:

- **MAMP installed** : You can download it from [here](https://www.mamp.info/en/downloads/), or any other server.

- **A modern browser (Chrome or Safari)**
  

### Installation and Launch Steps

1. Move Dashboard Folder to MAMP
Move your dashboard folder to:
- macOS
Applications/MAMP/htdocs/
- Windows
C:\MAMP\htdocs\
- Ex: C:\MAMP\htdocs\2025_GP_4\Wujed Dashboard

2. Start MAMP Server
Open the MAMP application, then click: Start Servers

3. Open the Dashboard in Browser
After servers start, open your browser and go to: http://localhost:8888/2025_GP_4/WujedDashboard/Wujed.html

### Notes
If the dashboard does not load data, ensure Apache is running on port 8888.

Confirm your Firebase config inside dashboard files is correct.
