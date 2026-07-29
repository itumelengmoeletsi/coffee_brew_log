from sqlalchemy import Column, Integer, String, DateTime, Float
from sqlalchemy.sql import func
from app.database.database import Base

class Brew(Base):
    __tablename__ = "brews"

    id = Column(Integer, primary_key=True, nullable=False)
    roaster_name = Column(String(50), nullable=False)
    brew_method = Column(String(255), nullable=False)
    coffee_weight = Column(Integer, nullable=False)
    water_weight = Column(Integer, nullable=False)
    rating = Column(Integer, nullable=False, default=0)
    notes = Column(String(255), nullable=True)
    creation_timestamp = Column(DateTime(timezone=True), server_default=func.now())