from sqlalchemy.orm import Session
from app.models.brew import Brew
from app.schemas.brew_schema import BrewCreate, BrewUpdate 

def create_brew(db: Session, brew_data: BrewCreate):
    new_brew = Brew(
        roaster_name=brew_data.roaster_name,
        brew_method=brew_data.brew_method,
        coffee_weight=brew_data.coffee_weight,
        water_weight=brew_data.water_weight,
        grind_size=brew_data.grind_size
    )

    # Save to database
    db.add(new_brew)
    try:
        db.commit()
    except Exception:
        db.rollback()
        raise
    db.refresh(new_brew)

    return new_brew

def update_brew(db: Session, brew_id: int, brew_data: BrewUpdate):
    # First I fetch the brew
    brew = db.query(Brew).filter(Brew.id == brew_id).first()

    if not brew:
        raise ValueError("Brew not found")

    update_data = brew_data.model_dump(exclude_unset=True)

    for key, value in update_data.items():
        setattr(brew, key, value)

    try:
        db.commit()
    except Exception:
        db.rollback()
        raise

    db.refresh(brew)

    return brew