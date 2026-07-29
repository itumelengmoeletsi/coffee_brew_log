from pydantic import BaseModel, Field, ConfigDict
from typing import Optional
from datetime import datetime

# Base schema
# Shared fields between Scehemas
class BrewBase(BaseModel):
    roaster_name: str = Field(..., max_length=50)
    brew_method: str = Field(..., max_length=255)
    coffee_weight: int 
    water_weight: int
    rating: int
    notes: Optional[str] = Field(default=None, max_length=255)

class BrewCreate(BrewBase):
    pass

# Update Schema
# Used when updating a job
class BrewUpdate(BaseModel):
    roaster_name: Optional[str] = Field(default=None, max_length=50)
    brew_method: Optional[str] = Field(default=None, max_length=255)
    coffee_weight: Optional[int] = None
    water_weight: Optional[int] = None
    rating: Optional[int] = None
    notes: Optional[str] = Field(default=None, max_length=255) 

# Response Schema
# Used when updating a job
class BrewResponse(BrewBase):
    id: int
    creation_timestamp: Optional[datetime] = None

    # Pydantic v2 syntax (replaces class Config: from_attributes = True)
    model_config = ConfigDict(from_attributes=True)