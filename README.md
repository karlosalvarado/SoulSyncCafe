# SoulSync.cafe 🌌

> Cosmic matchmaking powered by astrology, numerology, Chinese zodiac & Feng Shui.

This is the backend for **SoulSync**, a mystical dating app that calculates deep compatibility using ancient wisdom systems.

## 🔧 Tech Stack
- **Python + FastAPI** – Backend API
- **Render.com** – Hosting
- **Flutter** – Mobile frontend (separate repo)

## 🚀 Features
- Sun sign & element compatibility
- Chinese zodiac animal + element matching
- Life Path & Soul Urge numerology
- Kua number (Feng Shui) directional harmony
- Cosmic Compatibility Score (0–100)

## 📦 Requirements
- `fastapi`
- `uvicorn`

## 🌐 API Endpoints
- `POST /match` – Get compatibility score between two users

Example:
```json
{
  "user1": { "name": "Luna", "birth_date": "1995-06-15", "gender": "female", "full_name_at_birth": "Luna Moon" },
  "user2": { "name": "Orion", "birth_date": "1990-01-20", "gender": "male", "full_name_at_birth": "Orion Star" }
}
