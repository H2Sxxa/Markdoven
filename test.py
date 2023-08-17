import requests
from time import sleep


with open(
    "D:\WorkSpace\h2sxxa.github.io\source\_posts\wsl-gcc-vscode.md",
    "r",
    encoding="utf-8",
) as f:
    text = f.read()


with open("cache.png", mode="wb") as f:
    requests.post("http://127.0.0.1:9098/api/generate", json={"text": text,"isdark":True,"width":700,"scale":2})
    sleep(0.2)
    f.write(requests.get("http://127.0.0.1:9098/api/screenshot").content)
