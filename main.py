from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from datetime import datetime
from match_engine import calculate_compatibility

app = FastAPI(
    title="SoulSync API",
    description="Cosmic matchmaking using astrology, numerology & Feng Shui",
    version="0.1.0"
)

class User(BaseModel):
    name: str
    birth_date: str
    gender: str
    full_name_at_birth: str

class MatchRequest(BaseModel):
    user1: User
    user2: User

@app.post("/match")
async def match_users(request: MatchRequest):
    try:
        result = calculate_compatibility(request.user1.dict(), request.user2.dict())
        if "error" in result:
            raise HTTPException(status_code=400, detail=result["error"])
        return {"success": True, "data": result}
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Match failed: {str(e)}")

@app.get("/")
async def root():
    return {
        "message": "Welcome to SoulSync API 🌌",
        "docs": "/docs",
        "test": "POST to /match with two users"
    }