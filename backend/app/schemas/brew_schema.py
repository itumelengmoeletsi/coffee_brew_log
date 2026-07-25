from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime

# Base schema
# Shared fields between Scehemas
class BrewBase(BaseModel):
    roaster_name: str = Field(..., max_length=50)
    brew_method: str = Field(..., max_length=255)
    coffee_weight: int 
    water_weight: int
    grind_size: int

class BrewCreate(BrewBase):
    pass

# Update Schema
# Used when updating a job
class BrewUpdate(BaseModel):
    roaster_name: Optional[str] = Field(default=None, max_length=50)
    brew_method: Optional[str] = Field(default=None, max_length=255)
    coffee_weight: Optional[int] = None
    water_weight: Optional[int] = None
    grind_size: Optional[int] = None
    notes: Optional[str] = Field(default=None, max_length=255) 

# Response Schema
# Used when updating a job
class BrewResponse(BrewBase):
    id: int
    notes: Optional[str] = None
    creation_timestamp: Optional[datetime] = None

    class Config:
        from_attributes = True # this allows sqlalchemy models to be converted into API responses