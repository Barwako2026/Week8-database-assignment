import json
import redis

redis_client = redis.Redis(
    host="localhost",
    port=6379,
    decode_responses=True
)


def cart_key(tenant_id, user_id):
    return f"cart:{tenant_id}:{user_id}"


def add_to_cart(tenant_id, user_id, product_id, quantity):
    key = cart_key(tenant_id, user_id)

    existing = redis_client.get(key)

    if existing:
        cart = json.loads(existing)
    else:
        cart = {}

    product_id = str(product_id)
    cart[product_id] = cart.get(product_id, 0) + quantity

    redis_client.set(
        key,
        json.dumps(cart),
        ex=86400
    )

    return cart


def get_cart(tenant_id, user_id):
    key = cart_key(tenant_id, user_id)
    existing = redis_client.get(key)

    if existing is None:
        return {}

    return json.loads(existing)


def remove_from_cart(tenant_id, user_id, product_id):
    key = cart_key(tenant_id, user_id)
    cart = get_cart(tenant_id, user_id)

    cart.pop(str(product_id), None)

    redis_client.set(
        key,
        json.dumps(cart),
        ex=86400
    )

    return cart


if __name__ == "__main__":
    tenant_id = 1
    user_id = 1

    print("Adding product to cart...")

    add_to_cart(
        tenant_id,
        user_id,
        product_id=1,
        quantity=2
    )

    print("Current cart:")
    print(get_cart(tenant_id, user_id))
