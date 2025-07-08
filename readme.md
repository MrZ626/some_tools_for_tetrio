# Some Tools for TETR.IO

## Game Resources

js file: https://tetr.io/js/tetrio.js  
css file: https://tetr.io/css/tetrio.css  
SFX: https://tetr.io/sfx/tetrio.opus.rsd  
Images: https://tetr.io/res/avatar.png (can only be accessed if you know their full paths)

(Game loads resources just from these links)

## RSD Extractor

[Official Documentation](https://github.com/tetrio/tetrio-format-specs/blob/master/RSD.md)

> .lua script, need Lua to run  
> ffmpeg is optional, needed to extract audio files

1. Download `tetrio.opus.rsd` file from the links above and put it aside the `rsd_extractor.lua`
2. run `lua rsd_extractor.lua` to parse & extract the RSD file

## Version Tracker

> .sh script, need Bash to run

This script will track the version of `tetrio.js` file and create backup for each version.

**Manual Mode** - Just run it from time to time and see the output (files)

**Server Mode** - Run `version_tracker.sh --server` in the background

## Diff with line length

> .lua script, need Lua to run

1. Get 2 versions of **formatted** `tetrio.js` files and put them aside the `diff_line_length.lua`
2. run `lua diff_line_length.lua file1 file2 start_pos1(1) start_pos2(1) rows(inf)`
