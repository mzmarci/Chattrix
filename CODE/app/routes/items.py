 # API routes

from fastapi import APIRouter
from ..database import database
from ..models import items
from ..cache import redis_client

router = APIRouter()

@router.get("/items/{item_id}")
async def get_item(item_id: int):
    cache_key = f"item:{item_id}"
    cached = redis_client.get(cache_key)
    if cached:
        return {"from": "redis", "data": cached.decode()}

    query = items.select().where(items.c.id == item_id)
    result = await database.fetch_one(query)
    if result:
        redis_client.set(cache_key, result["name"], ex=60)  # cache for 60 seconds
    return {"from": "mysql", "data": result}




# from fastapi import APIRouter
# from ..database import database
# from ..models import items
# from ..cache import redis_client
# You import your database, model, and Redis client.


# router = APIRouter()
# Creates a router to hold routes.


# @router.get("/items/{item_id}")
# async def get_item(item_id: int):
#     cache_key = f"item:{item_id}"                # Redis key
#     cached = redis_client.get(cache_key)         # Check Redis
#     if cached:
#         return {"from": "redis", "data": cached.decode()}
# Checks if the item exists in Redis.

# If yes, return it from Redis.


#     query = items.select().where(items.c.id == item_id)
#     result = await database.fetch_one(query)
# If not in Redis, query MySQL.


#     if result:
#         redis_client.set(cache_key, result["name"], ex=60)  # Cache for 60 seconds
#     return {"from": "mysql", "data": result}
# Save result in Redis for next time.

# Return the result from MySQL.

