COffee Brew Log - System Documentation & Technical Specification

1. Summary & Architecture Overview

The Coffee Brew Log is a full-stack, cloud-native application designed for coffee enthusiasts to log, track, and analyze coffee brews, extraction parameters, and tasting notes.

The application follows a decoupled multi-tier architecture:

-   Frontend Tier: Flutter cross-platform client (Web/Mobile) using the Cubit/BLoC for predictable state management and reactive UI updates. 
-   Backend Tier: High-performance Python FastAPI Restful web service using Pydantic for runtime schema validation and SQLAlchemy as the Object-Relational Mapper (ORM).
-   Database Tier: Relational PostgreSQL databaase instance hosted on Render Cloud. 
-   Infrastructure & Hosting: Containerized deployment support via Docker & Docker Compose. Live deployment hosted on Render Web Services with SSL termination (HTTPS).

1.1 System Architecture Diagram

+-------------------------------------------------------+
|                 Flutter App Client                    |
|             (Mobile / Web - Port 3000)                |
|                                                       |
|  [ UI Views ] <---> [ BrewCubit ] <---> [ ApiService ]|
+--------------------------+----------------------------+
                           |
                           | HTTPS / REST (JSON)
                           v
+-------------------------------------------------------+
|                FastAPI Backend Service                |
|               (Render / Docker - Port 8000)           |
|                                                       |
|  [ CORSMiddleware ] -> [ API Routers ]                |
|                             |                         |
|                      [ Pydantic Schemas ]             |
|                             |                         |
|                     [ SQLAlchemy Models ]             |
+--------------------------+----------------------------+
                           |
                           | PostgreSQL Protocol (Port 5432)
                           v
+-------------------------------------------------------+
|             Managed PostgreSQL Database               |
|                    (Render Cloud)                     |
|                                                       |
|                  Tables: [ brews ]                    |
+-------------------------------------------------------+

2. Technology Stack & Dependencies
2.1 Backend (Python / FastAPI)

-    Framework: FastAPI ^0.100.0+

-    ASGI Web Server: Uvicorn ^0.22.0

-    ORM: SQLAlchemy ^2.0.0

-    Data Validation & Parsing: Pydantic ^2.0

-    Database Driver: psycopg2-binary

-    Environment Variable Management: python-dotenv

2.2 Frontend (Flutter / Dart)

-    Language & SDK: Dart 3.x / Flutter SDK 3.19+

-    State Management: flutter_bloc (Cubit pattern)

-    HTTP Client: http package

-    Environment Variable Support: --dart-define (Compile-time injection)

2.3 Cloud Infrastructure & DevOps

-    Cloud Host: Render (Web Service + Managed PostgreSQL + Static Site)

-    Containerization: Docker (Dockerfile) & Docker Compose (docker-compose.yml)

-    Static File Web Server: Nginx (Alpine) for Flutter Web Docker builds

3. Database Schema & Data Models
3.1 brews Table Specification

The relational database consists of a primary brews entity table storing quantitative extraction details and qualitative feedback.


Fields:
1. id, 2. roaster_name, 3. brew_method, 4. coffee_weight, 5. water_weight, 6. rating, 7. notes, 8. created_at

Data Type:
1. Integer, 2. VARCHAR(50), 3. VARCHAR(50), 4. INTEGER, 5. INTEGER, 6. INTEGER, 7. TEXT, 8. TIMESTAMP

Constraints:
1. PRIMARY KEY, AUTOINCREMENT, 2. NOT NULL, 3. NOT NULL, 4. NOT NULL, 5. NOT NULL, 6. CHECK (rating >= 1 AND rating <=5>), 7. NULLABLE, 8. DEFAULT CURRENT_TIMESTAMP

Description
1. Unique identifier for the brew entry
2. Brand/Roaster name
3. Brewing device
4. Dose weight in grams
5. Water yield weight in grams
6. User score rating (1 to 5 stars)
7. Testing notes, aroma, and flavour descriptors
8. System timestamp of record creation

4. API Endpoints Specification (REST Contract)

4.1 Summary Table 

Method	Endpoint	        Query Parameters	    Body Payload	    Success Status	    Description
GET	    /api/brews/	        brew_method (optional)	None	            200 OK	            Retrieves list of all brew logs
POST	/api/brews/	        None	                JSON Brew Object	201 Created     	Creates a new brew entry
GET	    /api/brews/{id}/	None	                None	            200 OK	            Retrieves details for a specific brew
PATCH	/api/brews/{id}/	None	                JSON Partial Object	200 OK	            Updates existing brew fields
DELETE	/api/brews/{id}/	None	                None	            204 No Content	    Removes a brew entry by ID

5. Environment Variables & Configuration

5.1 Backend Environment Variables

# App Settings
APP_NAME="Coffee Brew Log API"
ENVIRONMENT="production"
DEBUG=False

# Database Configuration (Render PostgreSQL)
DATABASE_URL="postgresql://brew_db_user:password@dpg-cxxxxxxxxxxxxxxx-a.oregon-postgres.render.com/brew_db"

# Allowed CORS Origins (Comma-separated)
ALLOWED_ORIGINS="http://localhost:3000,https://coffee-brew-backend-ktmt.onrender.com"

5.2 Frontend Environment Variables 
# Production API Base URL
BASE_URL=https://coffee-brew-backend-ktmt.onrender.com

6. Project Directory Structure
coffee_brew_log/
├── .gitignore
├── README.md
├── document.md
├── docker-compose.yml
│
├── backend/
│   ├── Dockerfile
│   ├── .dockerignore
│   ├── .env.example
│   ├── requirements.txt
│   └── app/
│       ├── main.py                # FastAPI entry point & CORS configuration
│       ├── core/
│       │   ├── config.py          # Environment settings loader
│       │   └── database.py        # SQLAlchemy engine & session setup
│       ├── models/
│       │   └── brew.py            # SQLAlchemy database ORM model
│       ├── schemas/
│       │   └── brew.py            # Pydantic schemas for request/response validation
│       └── api/
│           └── brews.py           # REST route handlers
│
└── frontend/
    ├── Dockerfile
    ├── .dockerignore
    ├── pubspec.yaml
    ├── assets/
    └── lib/
        ├── main.dart              # Flutter app root & BlocProvider initialization
        ├── config/
        │   └── theme.dart         # Material UI theme tokens
        ├── cubit/
        │   └── brew/
        │       ├── brew_cubit.dart # Business logic state controller
        │       └── brew_state.dart # Brew state models (Loading, Loaded, Error)
        ├── models/
        │   └── brew.dart          # Dart data object with fromJson/toJson
        ├── screens/
        │   ├── brew_list_screen.dart # Primary brew log feed view
        │   └── brew_detail_screen.dart
        └── services/
            └── api_service.dart   # REST client implementation (http library)

7. Local Development & Setup Instructions

7.1 Option A: Running via Docker Compose (Recommended)

To launch the complete stack locally using Docker:

1.    Clone the repository and navigate to the project root:

    git clone https://github.com/itumelengmoeletsi/coffee_brew_log.git
    cd coffee_brew_log

2.  Build and start all services in detached mode:
    docker-compose up --build -d

3.  Access running services:

-    Flutter Web Frontend: http://localhost:3000

-    FastAPI Backend: http://localhost:8000

-     Swagger API Documentation: http://localhost:8000/docs

-    PostgreSQL Database: localhost:5432

4.  Tear down containers:
    docker-compose down

7.2 Option B: Manual Bare-Metal Setup 

1. Backend Setup

    cd backend
    python -m venv venv

    # Activate virtual environment
    # Windows (PowerShell):
    .\venv\Scripts\Activate.ps1
    # macOS / Linux:
    source venv/bin/activate

    pip install -r requirements.txt
    cp .env.example .env # Configure DATABASE_URL

    # Start backend dev server
    uvicorn app.main:app --reload --port 8000

2. Frontend Setup
    cd frontend
    flutter pub get

    # Run on Chrome Web with API URL compile-time injection
    flutter run -d chrome --dart-define=BASE_URL=https://coffee-brew-backend-ktmt.onrender.com

    # Build production web bundle
    flutter build web --release --dart-define=BASE_URL=https://coffee-brew-backend-ktmt.onrender.com

8. Deployment Architecture on Render

The production instance is hosted on Render Cloud using three interconnected resources:

[ PostgreSQL Database ] <--- (Internal DB Connection) --- [ FastAPI Web Service ]
  Instance: coffee-brew-db                                Instance: coffee-brew-backend
  Region: Oregon (us-west)                                Build: Python 3.11 / Uvicorn
                                                          URL: https://coffee-brew-backend-ktmt.onrender.com
                                                                     ^
                                                                     | (HTTPS Requests)
                                                          [ Flutter Web Static Site ]
                                                          Publish Dir: frontend/build/web

8.1 Deployment Parameters

-    FastAPI Web Service:

    -    Build Command: pip install -r requirements.txt

    -    Start Command: uvicorn app.main:app --host 0.0.0.0 --port $PORT

    -    Environment Variable: DATABASE_URL pointing to Render PostgreSQL internal connection string.

-    Flutter Static Web Site:

    -    Publish Directory: frontend/build/web

    -    Pre-built locally via flutter build web --release --dart-define=BASE_URL=[https://coffee-brew-backend-ktmt.onrender.com](https://coffee-brew-backend-ktmt.onrender.com).

9. Performance & Operational Notes 

    Free Tier Cold Starts: Render spins down free web service instances after 15 minutes of inactivity. The initial HTTP request after sleeping takes 30–50 seconds to wake up the server. To accommodate this, ApiService in Flutter uses a 60-second request timeout limit.

    CORS Headers: FastAPI utilizes CORSMiddleware configured with allow_origins=["*"] or explicit frontend domains to facilitate cross-origin browser requests from Flutter Web.

    Database Expiry: Render free-tier PostgreSQL databases expire after 90 days. For production continuity, database dumps are taken periodically via pg_dump.