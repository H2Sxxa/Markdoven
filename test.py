import requests


with open(
    "D:\WorkSpace\h2sxxa.github.io\source\_posts\wsl-gcc-vscode.md",
    "r",
    encoding="utf-8",
) as f:
    text = f.read()


with open("cache.png", mode="wb") as f:
    f.write(
        requests.post("http://127.0.0.1:8089/api/generate", json={"text": text}).content
    )
