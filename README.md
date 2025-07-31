  <img src="assets/images/LogoHabitO.jpeg" alt="Habit-O Logo" height="200"/>

# 🧠 Habit-O - eine App um  Gewohnheiten zu tracken

[![Flutter](https://img.shields.io/badge/flutter-3.29.3-blue?logo=flutter)](https://flutter.dev)
[![Version](https://img.shields.io/badge/version-1.0.0-orange)](#)
[![Platform](https://img.shields.io/badge/platform-android%20%7C%20ios-yellow?logo=flutter)](#)
[![Firebase](https://img.shields.io/badge/backend-firebase-orange?logo=firebase)](https://firebase.google.com/)[![License](https://img.shields.io/badge/license-MIT-lightgrey)](LICENSE)

**From Zero to Hero – Schritt für Schritt zur besseren Version deiner selbst.**  
Habit-O hilft dir, neue Routinen zu entwickeln – ganz ohne Druck, aber mit Struktur, Motivation und Klarheit.

---

## 🧩 Problem, das Habit-O löst

Viele Menschen nehmen sich neue Gewohnheiten vor – sei es mehr Sport, früher Schlafen oder Selfcare. Doch im
Alltagsstress oder bei nachlassender Motivation fällt es schwer, am Ball zu bleiben.

**Habit-O** unterstützt dich mit:

- 🆕 intuitivem Anlegen von Gewohnheiten
- ✅ täglichem Abhaken zur Erfolgskontrolle
- 🤖 KI-gestützten Habit-Vorschlägen durch *Ori*
- 📊 Verlaufsübersicht deiner Routinen (geplant)

---

## 👤 Für wen ist Habit-O?

### 🎓 Persona: Annika, 19, Studentin im 2. Semester

Annika ist frisch ausgezogen und möchte Struktur in ihren Alltag bringen. Sie hat viele Ideen, wie sie sich verbessern
könnte, scheitert aber oft an der Umsetzung.

Sie will:

- Klarheit über ihre Ziele
- stolz auf sich selbst sein
- Routinen, die zu ihrem Leben passen

Doch sie kämpft mit:

- Selbstzweifeln und Perfektionismus
- zu großen Plänen, die sie schnell überfordern
- fehlender Übersicht, wie konsequent sie wirklich ist

**Habit-O** ist ihr kleiner Begleiter – ohne Druck, aber mit klarem Plan.

---

### 👩‍👧 Persona: Maria, 35, berufstätige Mutter

Maria hat zwei Kinder und einen Teilzeitjob, wodurch ihr Alltag sehr ausgelastet ist. Sie möchte trotzdem persönliche
Gewohnheiten wie tägliches Lesen oder Meditation pflegen, verliert diese im Trubel jedoch leicht aus den Augen.

**Sie will:**

- mehr Balance zwischen Alltag und Selbstfürsorge
- ihrer Tochter ein gutes Vorbild sein
- kurze Momente für sich sinnvoll nutzen

**Doch sie kämpft mit:**

- spontanen Zeitfenstern, die oft verpuffen
- Schuldgefühlen, wenn sie sich Zeit für sich nimmt
- Routinen, die nicht zu ihrem Alltag passen

**Habit-O** hilft ihr mit klarer Übersicht, kleinen Schritten und (zukünftig) Erinnerungen, ihre Vorhaben im Blick zu
behalten – ganz ohne zusätzlichen Stress.

---

## 🖼 Screens

| Screen                         | Beschreibung                                                                    |
|--------------------------------|---------------------------------------------------------------------------------|
| 🏠 **Home Screen**             | Zeigt deine heutigen Habits – gruppiert nach Tageszeit (morgens,mittags,abends) |
| ➕ **Create Habit**             | Neue Gewohnheiten mit Titel und Tageszeit anlegen                               |
| 🤖 **Ori Chat **               | KI hilft dir, deine Ziele in konkrete Schritte zu verwandeln                    |
| 📊 **Progress View (geplant)** | Monatsübersicht mit grün markierten Habit-Tagen                                 |

### 📸 Screenshots

<p align="center">
  <img src="assets/images/screens_readme/StartScreen.png" alt="Start Screen" width="200"/>
  <img src="assets/images/screens_readme/HomeScreen.png" alt="Home Screen" width="200"/>
</p>
<p align="center">
  <img src="assets/images/screens_readme/CreateHabitScreen.png" alt="Create Habit Screen" width="200"/>
  <img src="assets/images/screens_readme/OriScreen.png" alt="Ori Chat Screen" width="200"/>
</p>

---

## 🚀 Features

- ✅ **Habits anlegen**
- ⏰ **Zeitbasierte Gruppierung (z. B. morgens/abends)**
- ✅ **Habits löschen**
- 📤 **Daten persistent in Firestore speichern**
- 🤖 **Ori (KI-Vorschläge für neue Habits)**
- 📅 **Verlauf über einen längeren Zeitraum einsehbar(unvollständig)**

---

## 🤖 KI-Feature „Ori“ – externes Backend

Das Feature **„Ori“** bietet Nutzern personalisierte Vorschläge für neue Gewohnheiten, die sie noch nicht in ihrer Liste
haben.  
Es dient als kreative Starthilfe – besonders für Menschen, die nicht wissen, wie sie anfangen sollen oder neue Impulse
brauchen.

### ⚙️ Funktionsweise

- Die App sendet eine Liste von bereits vorhandenen Gewohnheiten (Strings) an das **Ori-Backend**
- Dieses ist ein **Java-Backend mit Quarkus**, das auf **GPT-4o** von OpenAI zugreift
- GPT-4o analysiert die Eingaben und generiert neue, passende Vorschläge, **die inhaltlich sinnvoll, aber noch nicht
  redundant sind**
- Die Antwort ist eine Liste neuer, motivierender Habit-Ideen

### 🧰 Technologie-Stack

| Komponente     | Beschreibung                            |
|----------------|-----------------------------------------|
| **Backend**    | Java mit [Quarkus]                      |
| **API Layer**  | REST mit Jakarta WS (`@Path`, `@POST`)  |
| **KI-Modell**  | GPT-4o von OpenAI                       |
| **Deployment** | Extern gehostet (Produktiv erreichbar)  |
| **Verbindung** | `POST /chat/habits` – JSON-Ein-/Ausgabe |

---

## 📂 Projektstruktur

Die App basiert auf dem **Layer-First-Architekturprinzip**, bei dem der Code nach Verantwortlichkeiten (Daten, Logik,
Präsentation etc.) gegliedert ist.

### 📁 Ordnerstruktur

```bash
lib/
│
├── bloc/                   # State-Management (Bloc) nach Feature gruppiert
│   ├── auth/
│   ├── habit/
│   ├── habit_time_range/
│   └── user/
│
├── constants/              # Zentrale App-Konstanten (Farben, Texte, TextStyles)
│   ├── app_colors.dart
│   ├── app_text_styles.dart
│   └── app_texts.dart
│
├── interfaces/             # Abstrakte Interfaces für Services & Repositories
│   ├── i_auth_service.dart
│   ├── i_habit_repository.dart
│   └── i_time_range_repository.dart
│
├── models/                 # Datenmodelle 
│   ├── habit.dart
│   └── time_of_day_range.dart
│
├── repository/             # Firestore-Repositories (Implementierung der Interfaces)
│   ├── habit_repository.dart
│   └── time_range_repository.dart
│
├── router/                 # Routing mit GoRouter
│   ├── app_router.dart
│   └── navigation_shell.dart
│
├── services/               # Logik für Authentifizierung und KI (Ori)
│   ├── auth_service.dart
│   └── ori_service.dart
│
├── validators/             # Validierungslogik für Benutzereingaben
│   └── auth_input_validators.dart
│
├── views/                  # UI-Seiten (Screens)
│   ├── create_habit.dart
│   ├── habit_overview.dart
│   ├── home.dart
│   ├── intro.dart
│   ├── login.dart
│   ├── my_profile.dart
│   ├── ori_chat.dart
│   └── register.dart
│
├── widgets/                # Wiederverwendbare UI-Komponenten
│   ├── custom_fab.dart
│   ├── habit_card.dart
│   ├── habit_details_dialog.dart
│   ├── habit_time_section.dart
│   ├── logout_button.dart
│   ├── ori_light.dart
│   ├── time_option_chip.dart
│   └── user_menu.dart
│
├── firebase_options.dart   # Firebase-Konfiguration
└── main.dart               # Einstiegspunkt der App

---
## 🧰 Tech Stack

| Layer      | Tools & Libraries                                 |
|------------|---------------------------------------------------|
| Frontend   | Flutter 3.29.3, Dart 3.7.2            |
| State Mgmt | Bloc, flutter_bloc                                |
| Backend    | Firebase Auth, Firestore Firebase          |
| Extras     | SharedPreferences für Intro-Tracking              |
| UI         | Eigene `Theme`, Icons, `TextStyles`               |


---

## 🛠 Installation

##    Voraussetzungen

- 🐦 **Flutter SDK** >= 3.7.2  
- 💻 Eine Entwicklungsumgebung wie _IntelliJ IDEA_

### Lokale Ausführung

```bash
git clone https://github.com/batooch/HabitO.git
cd habito
flutter pub get
flutter run

---

#### 👩‍💻 Developed and designed with passion by:

- [@batooch](https://github.com/batooch)

> 💬 Feel free to reach out for questions, feedback, or collaboration ideas! 🤝🚀
---