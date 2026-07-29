from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.database.database import engine, Base
import app.models
import os

# Import routes
from app.api.routes import brew_routes

app = FastAPI(
        title="Coffee Brew Log API", 
        version = "1.0.0"
    )

database_url = os.getenv("DATABASE_URL")

if database_url and database_url.startswith("postgres://"):
    database_url = database_url.replace("postgres://", "postgresql://", 1)

# Create Tables
Base.metadata.create_all(bind=engine)

# Enable CORS so the frontend can talk to the backend 
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], #TODO: Adjust origins for deployment later
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.get("/")
def read_root():
    return{
        "message": "Coffee Brew Log API is up and running!",
        "version": "1.0.0",
        "available_routes": [
            "/brew"
        ]
    }

# Register routes
API_PREFIX = "/api"

app.include_router(brew_routes.router, prefix=API_PREFIX)