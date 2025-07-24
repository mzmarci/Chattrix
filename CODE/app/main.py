# FastAPI entry point

from fastapi import FastAPI
from .database import database
from .routes import items

app = FastAPI()

@app.on_event("startup")
async def startup():
    await database.connect()

@app.on_event("shutdown")
async def shutdown():
    await database.disconnect()

app.include_router(items.router)


# explaining my code 
# from fastapi import FastAPI
# from .database import database
# from .routes import items
# Import FastAPI, your database, and your route files.


# app = FastAPI()
# Starts the FastAPI application.


# @app.on_event("startup")
# async def startup():
#     await database.connect()
# When the app starts, connect to the MySQL database.


# @app.on_event("shutdown")
# async def shutdown():
#     await database.disconnect()
# When the app stops, disconnect from MySQL.


# app.include_router(items.router)
# This tells FastAPI to load your API routes from routes/items.py.