# Some Tools for TETR.IO

## Game Resources

Game itself loads resources from these links:

```shell
# js file
curl -o tetrio.js https://tetr.io/js/tetrio.js

# css file
curl -o tetrio.css https://tetr.io/css/tetrio.css

# sfx pack
curl -o tetrio.opus.rsd https://tetr.io/sfx/tetrio.opus.rsd

# image(s)
curl -o ???.png https://tetr.io/res/FIND/PATHS/YOURSELF
```

## RSD Extractor

[Official Documentation](https://github.com/tetrio/tetrio-format-specs/blob/master/RSD.md)

> .lua script, need Lua to run  
> ffmpeg is optional, needed to extract audio files

1. Download `tetrio.opus.rsd` file from the links above and put it aside the `rsd_extractor.lua`
2. run `lua rsd_extractor.lua` to parse & extract the RSD file

## Resource Fetcher

> .lua script, need Lua to run
> curl is needed to download resources

1. Find resource paths yourself and paste them into the `list` variable at beginning
2. Run `lua fetch_res.lua` to fetch resources

## Version Tracker

> .sh script, need Bash to run

This script will track the version of `tetrio.js` file and create backup for each version.

**Manual Mode** - Just run it from time to time and see the output (files)

**Server Mode** - Run `version_tracker.sh --server` in the background

## Diff with line length

> .lua script, need Lua to run

1. Get 2 versions of **formatted** `tetrio.js` files and put them aside the `diff_line_length.lua`
2. run `lua diff_line_length.lua file1 file2` to get approximate result (stop automatically with stop sequence `.init(),`)
3. run `lua diff_line_length.lua file1 file2 start_offset1(0) start_offset2(0) line_count(inf)` to parse any area you want

## Anti-variable-name-confusion

> .lua script, need Lua to run

1. Get 2 versions of **formatted** `tetrio.js` files and put them aside the `anti_variable_name_confusion.lua`
2. Run `lua anti-confusion.lua file1 temp1`
3. Run `lua anti-confusion.lua file2 temp2`
4. Compare the `temp1` and `temp2` with tools like `diff` (and it should be also faster than before?), then go back to the pre-anti-confusion file to read the changes
