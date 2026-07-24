from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(title="Coffee Brew Log API")

# Enable CORS so the frontend can talk to the backend 
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], #TODO: Adjust origins for deployment later
    allow_creentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.get("/")
def read_root():
    return{"message": "Coffee Brew Log API is up and running!"}