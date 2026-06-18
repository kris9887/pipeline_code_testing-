def add_user_to_db(db, user):
    """Simple function to simulate adding a user to a database."""
    if not user:
        return False
    db.append(user)
    return True

def calculate_tax(salary):
    """Calculates tax based on salary."""
    if salary < 0:
        raise ValueError("Salary cannot be negative")
    if salary <= 50000:
        return salary * 0.05
    return salary * 0.10


