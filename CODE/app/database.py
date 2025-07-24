# MySQL connection setup

from sqlalchemy import create_engine, MetaData
from databases import Database

DATABASE_URL = "mysql://user:password@localhost:3306/yourdb"

database = Database(DATABASE_URL)
metadata = MetaData()
engine = create_engine(DATABASE_URL)



# from sqlalchemy import create_engine, MetaData
# from databases import Database
# create_engine: sets up a way to talk to MySQL

# MetaData: stores table schemas

# Database: handles async connections (for performance)

# DATABASE_URL = "mysql://user:password@localhost:3306/yourdb"
# This is your connection string to MySQL. Replace user, password, yourdb with real values.

# database = Database(DATABASE_URL)
# metadata = MetaData()
# engine = create_engine(DATABASE_URL)
# This creates:

# a database instance for queries

# metadata (table structure info)

# an engine to run SQL statements