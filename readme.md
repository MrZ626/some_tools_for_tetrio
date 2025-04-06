# Some Tools for TETR.IO

## Game Resources

SFX: https://tetr.io/sfx/tetrio.opus.rsd  
Images: https://tetr.io/res/avatar.png (can only be accessed if you know their full paths)

Game loads resources by links, so you can get them directly in same way :)

## RSD Extractor

[Official Documentation](https://github.com/tetrio/tetrio-format-specs/blob/master/RSD.md)

Tools needed:

- Lua (5.3+) <!-- or Love2D -->
- ffmpeg (optional)

How to use:

1. Download `tetrio.opus.rsd` file from the links above and put it aside the `rsd_extractor.lua`
2. run `lua rsd_extractor.lua` to parse & extract the RSD file
