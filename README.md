# Wujed – AI-Powered Lost & Found System

Wujed is an AI-powered Lost & Found system designed to help people in Riyadh quickly recover their lost belongings. Instead of relying on slow, outdated methods like social media posts or physical lost-and-found boxes, Wujed provides a smart digital platform where users can report lost or found items along with a title, description, location, and images. Using AI for text and image analysis, the system automatically suggests potential matches between lost and found reports. Users can accept or reject these matches, and once confirmed, both sides can securely chat to verify ownership and arrange item return. By combining intelligent technology with a user-friendly experience, Wujed aims to increase recovery rates, encourage community participation, and demonstrate how AI can effectively solve real everyday problems. 

In addition to the mobile application, Wujed includes a dedicated **web-based dashboard** for administrators. This dashboard allows the system team to monitor flagged reports and review AI-generated matches that were rejected by users, improving the platform’s accuracy and reliability.



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
  
##  1. Mobile App - Getting Started

### Prerequisites

Before running the Flutter application, make sure you have the following installed:

- **Flutter SDK**: If you haven't already, Install Flutter from the official link: [official Flutter installation guide](https://docs.flutter.dev/get-started/install).

- **Integrated Development Environment (IDE)**: We recommend using Visual Studio Code (VS Code) for developing Flutter applications. If you don't have it installed, you can download it from [here](https://code.visualstudio.com/download).

- **Emulator**:
  - For IOS devices you can use Xcode. download it from [here](https://apps.apple.com/sa/app/xcode/id497799835?mt=12).
  - Or you can use Android Studio for Windows, which you can download from [here](https://developer.android.com/studio).


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


## 2. Dashboard - Getting Started

### Prerequisites

The Wujed Dashboard is a local web-based admin panel that runs using MAMP.

Before running the dashboard, ensure you have:

- **MAMP installed** : You can download it from [here](https://www.mamp.info/en/downloads/), or any other server.

- **A modern browser (Chrome or Safari)**
  

### Installation and Launch Steps

1. Move Dashboard Folder to MAMP
Move your dashboard folder to:
- **macOS**: Applications/MAMP/htdocs/
- **Windows**: C:\MAMP\htdocs\
 Ex: C:\MAMP\htdocs\2025_GP_4\Wujed Dashboard

2. Start MAMP Server
Open the MAMP application, then click: Start Servers

3. Open the Dashboard in Browser
After servers start, open your browser and go to: [http://localhost:8888//WujedDashboard/Wujed.html](http://localhost:8888/Wujed%20Dashboard/Wujed.html)

### Notes
If the dashboard does not load data, ensure Apache is running on port 8888.

Confirm that the URL is currect.
