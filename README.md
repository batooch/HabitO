<p align="center">
  <img src="assets/images/habit_o_logo.png" alt="Habit-O Logo" height="200"/>
</p>

# 🧠 Habit-O - eine App um deine Gewohnheiten zu tracken
[![Flutter](https://img.shields.io/badge/flutter-3.19.2-blue?logo=flutter)](https://flutter.dev)
[![Version](https://img.shields.io/badge/version-1.0.0-orange)](#)
[![Platform](https://img.shields.io/badge/platform-android%20%7C%20ios-yellow?logo=flutter)](#)
[![Firebase](https://img.shields.io/badge/backend-firebase-orange?logo=firebase)](https://firebase.google.com/)
[![License](https://img.shields.io/badge/license-MIT-lightgrey)](#)

**From Zero to Hero – Schritt für Schritt zur besseren Version deiner selbst.**  
Habit-O hilft dir, neue Routinen zu entwickeln – ganz ohne Druck, aber mit Struktur, Motivation und Klarheit.

---

## 🧩 Problem, das Habit-O löst

Viele Menschen nehmen sich neue Gewohnheiten vor – sei es mehr Sport, früher Schlafen oder Selfcare. Doch im Alltagsstress oder bei nachlassender Motivation fällt es schwer, am Ball zu bleiben.

**Habit-O** unterstützt dich mit:
- 🆕 intuitivem Anlegen von Gewohnheiten
- ✅ täglichem Abhaken zur Erfolgskontrolle
- 🤖 KI-gestützten Habit-Vorschlägen durch *Ori*
- 📊 Verlaufsübersicht deiner Routinen (geplant)


---

## 👤 Für wen ist Habit-O?

### 🎓 Persona: Annika, 19, Studentin im 2. Semester

Annika ist frisch ausgezogen und möchte Struktur in ihren Alltag bringen. Sie hat viele Ideen, wie sie sich verbessern könnte, scheitert aber oft an der Umsetzung.

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

## 🖼 Screens (Mockups & App UI)

| Screen                | Beschreibung                                                                     |
|-----------------------|----------------------------------------------------------------------------------|
| 🏠 **Home Screen**    | Zeigt deine heutigen Habits – gruppiert nach Tageszeit (morgens,mittags, abends) |
| ➕ **Create Habit**    | Neue Gewohnheiten mit Titel und Tageszeit anlegen                                |
| 📊 **Progress View (geplant)** | Monatsübersicht mit grün markierten Habit-Tagen                                  |
| 🧠 **Ori Chat **      | KI hilft dir, deine Ziele in konkrete Schritte zu verwandeln                     |

---

## 🚀 Features

- ✅ **Habits anlegen & verwalten**
- ⏰ **Zeitbasierte Gruppierung (z. B. morgens/abends)**
- 📅 **Verlauf über einen längeren Zeitraum einsehbar**
- ✅ **Checkbox zum Abhaken → Visual Feedback (ausgrauen)**
- 📤 **Daten persistent in Firestore gespeichert**
- 🔔 **(Optional) Erinnerungen geplant**
- 🤖 **Ori (KI-Vorschläge für neue Habits) – in Planung**

---

## 🧱 Architektur

Die App folgt dem MVC-Prinzip und verwendet zusätzlich Bloc zur State-Verwaltung.

**Ordnerstruktur:**
- `lib/ui/` – Views: Home, Habit erstellen, Profil …
- `lib/controllers/` – Logik für das Abrufen, Speichern, Sortieren
- `lib/models/` – Datenmodelle für Habit & User
- `lib/bloc/` – State Management für Habits, User, Zeitspannen
- `lib/services/` – Firebase Auth, Firestore, Ori-Service

---

## ⚙️ Tech Stack

| Layer         | Tools & Libraries                              |
|---------------|-------------------------------------------------|
| Frontend      | Flutter 3.19, Dart (null safety), GetX, Bloc    |
| State Mgmt    | Bloc, flutter_bloc                              |
| Backend       | Firebase Auth, Firestore, (Ori in Planung)      |
| Storage       | Firestore: `/users/{uid}/habits/…`              |
| Extras        | SharedPreferences für Intro-Tracking            |
| UI            | Tailwind-ähnlich mit `Theme`, Icons, `TextStyles` |

---

## 🛠 Installation

### Voraussetzungen
- Flutter SDK >= 3.19
- Android Studio oder VS Code
- Firebase-Projekt (E-Mail/Passwort Auth + Firestore)

### Lokale Ausführung

```bash
git clone https://github.com/DEIN_GITHUB_USERNAME/habit-o.git
cd habit-o
flutter pub get
flutter run
