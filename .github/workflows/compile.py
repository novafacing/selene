#!/usr/bin/env python3
import os
import shutil
from pathlib import Path

# Step 1: Compile moon to lua, remove moon

for file in Path("src").glob("**/*.moon"):
    os.system(f'moonc {file}')
    file.unlink()

# Step 2: Remove lib/moonscript

shutil.rmtree(Path("lib/moonscript"))

# Step 3: Remove moonscript import
with open("conf.lua") as file:
    conf = file.read()
conf = conf.replace('require("lib.moonscript")', "")
with open("conf.lua", "w") as file:
    file.write(conf)
