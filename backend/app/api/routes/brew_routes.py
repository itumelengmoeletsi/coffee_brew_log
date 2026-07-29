from fastapi import APIRouter, Depends, HTTPException, status, Query
from sqlalchemy.orm import Session
from typing import List, Optional

from app.database.database import get_db
from app.schemas.brew_schema import (BrewCreate, BrewUpdate, BrewResponse)
from app.services.brew_service import (create_brew, update_brew, delete_brew)
from app.models.brew import Brew

router = APIRouter(
    prefix="/brews", 
    tags=["Brews"]
)

@router.get("/", response_model=List[BrewResponse])
def read_brews(
    brew_method: Optional[str] = Query(default=None, description="Filter by brew method"),
    db: Session = Depends(get_db)
):
    """
    Display the list of all existing brews
    """
    query = db.query(Brew)

    if brew_method: 
        query = query.filter(Brew.brew_method.ilike(f"%{brew_method}"))

    brews = query.all()
    return brews

@router.get("/{id}", response_model=BrewResponse)
def read_brew_by_id(
    id: int,
    db: Session = Depends(get_db),
):
    """
    Fetch brew by ID assigned to it
    """

    # Query the database for the matching model instance
    brew = db.query(Brew).filter(Brew.id == id).first()

    # Check if the query returned a record or None
    if not brew:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            details=f"Brew with ID {id} not found."
        )

    return brew

@router.post("/", response_model=BrewResponse, status_code=201)
def create_brew_route(
    brew: BrewCreate,
    db: Session = Depends(get_db),
): 
    """Creates a new brew."""
    try:
        new_brew = create_brew(db, brew)
        return new_brew
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.patch("/{id}", response_model=BrewResponse)
def update_brew_route(
    id: int,
    brew: BrewUpdate,
    db: Session = Depends(get_db)
):
    """Updates an existing brew"""
    try:
        updated_brew = update_brew(db, id, brew)
        return updated_brew
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))

@router.delete("/{id}", status_code=204)
def delete_brew_route(
    id: int, 
    db: Session = Depends(get_db)
):
    """
    Delete an existing brew by id
    """
    try:
        delete_brew(db, id)
        return None
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
