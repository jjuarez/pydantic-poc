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

#
# ::main::
#
if __name__ == '__main__':
    host = os.getenv("HOST", "0.0.0.0")
    port = int(os.getenv("PORT", "8000"))
    log_level = os.getenv("LOG_LEVEL", "info")
    uvicorn.run("main:app", host=host, port=port, log_level=log_level)
