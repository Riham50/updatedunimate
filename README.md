# UniMate – Smart Campus Companion 📱🎓

UniMate is an all-in-one mobile application designed to enhance the digital campus experience for university students. Built using **Flutter** (frontend) and **Node.js + Firebase** (backend), UniMate helps students stay organized, informed, and connected.

---

## 🚀 Features

### 🗓️ Schedule Manager
- Add, view, and edit weekly course schedules (Monday–Saturday)
- Organized by day and period
- Sticky headers, smooth transitions, and highlight for today's classes

### ✅ Attendance Tracker
- QR Code-based attendance system
- Automatic absence detection if students miss scans during scheduled time

### 🧾 Assignment Manager
- Upload and view assignments with due dates
- Set reminders and get notifications

### 🧑‍🎓 Digital Student ID
- View your unique university ID digitally
- Fetched directly from the database

### 📚 Course Materials
- Search and browse course descriptions and downloadable PDF materials
- Organized and searchable course list

### 🔔 Notification Center
- Receive notifications for assignments, events, due dates, and updates

### 🧭 Lost and Found System
- Post lost or found items
- Two sections: "Lost Items" and "Found Items" with photos and descriptions

---

## 🛠️ Tech Stack

| Layer       | Tech                          |
|------------|-------------------------------|
| Frontend   | Flutter                        |
| Backend    | Node.js                        |
| Database   | Firebase (Firestore + Storage) |
| Auth       | Firebase Authentication        |

---

## 📂 Folder Structure

```bash
lib/
├── auth/
├── models/
├── screens/
├── services/
├── widgets/
