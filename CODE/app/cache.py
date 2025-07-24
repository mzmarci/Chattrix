# Redis connection setup


# redis_client.py
import aioredis

async def get_redis():
    redis = await aioredis.from_url("redis://localhost", encoding="utf-8", decode_responses=True)
    try:
        yield redis
    finally:
        await redis.close()



# import redis

# redis_client = redis.Redis(host="localhost", port=6379, db=0)

# This connects to a Redis server running on port 6379.


