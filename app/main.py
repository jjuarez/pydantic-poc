#!/usr/bin/env python

import os
import uvicorn
from typing import Optional
from fastapi import FastAPI
from pydantic import BaseModel


#
# Models
#
class Item(BaseModel):
    """The Item class"""
    name: str
    description: Optional[str] = None
    price: float


#
# App and routes
#
app = FastAPI(title="FastAPI, pydantic")


@app.get("/")
def read_root():
    return {"message": "Try /items endpoint"}


@app.post("/items")
def create_item(item: Item):
    return item


def setup() -> dict:
    config = {}
    config['host'] = os.getenv("HOST", "0.0.0.0")
    config['port'] = int(os.getenv("PORT", "8000"))
    return config


#
# ::main::
#
if __name__ == '__main__':
    app_config = setup()
    uvicorn.run("main:app", host=app_config['host'], port=app_config['port'])
