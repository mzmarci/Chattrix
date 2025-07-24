# Database table definitions

from sqlalchemy import Table, Column, Integer, String
from .database import metadata

items = Table(
    "items",
    metadata,
    Column("id", Integer, primary_key=True),
    Column("name", String(50)),
)


# from sqlalchemy import Table, Column, Integer, String
# from .database import metadata
# You import metadata to define your table:


# items = Table(
#     "items",                    # Table name
#     metadata,                   # Attach it to our metadata object
#     Column("id", Integer, primary_key=True),   # ID column
#     Column("name", String(50)),                # Name column
# )
# This says: “Create a table called items with id and name fields.”
