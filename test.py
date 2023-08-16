import requests
from time import sleep


with open(
    "README.md",
    "r",
    encoding="utf-8",
) as f:
    text = f.read()


with open("cache.png", mode="wb") as f:
    requests.post("http://127.0.0.1:8089/api/generate", json={"text": text})
    sleep(2)
    f.write(requests.get("http://127.0.0.1:8089/api/screenshot").content)
