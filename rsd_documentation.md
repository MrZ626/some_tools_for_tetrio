# Radical Sound Definition (RSD) File Format in TETR.IO

> By [SweetSea](https://github.com/SweetSea-ButImNotSweet)

Radical Sound Definition (RSD) is a file format developed by Dr. Ocelot to replace TETR.IO's old sound effect (SFX) loading system, which was cumbersome and slow.

## 1. File Information

- **File extension**: `.rsd`
- **Magic code / header**: `tRSD`
- **Number encoding**: All numeric values in the file are encoded as unsigned 32-bit integers in little-endian format.
- **Main components**: The file contains a list of timestamps for SFX and an OGG audio file.

## 2. File Structure

1. **First 4 bytes**: Contains the magic code `tRSD`, used to validate the file.
2. **Next 1 byte**: Currently holds the hex value `01` - possibly an RSD version indicator. It is likely that this byte, along with the next 3 bytes, represents the RSD version.
3. **Bytes 6 to 16**: Contain no significant information (all set to `00`).
4. **SFX timestamp list**:
   - No special marker indicates the start of the timestamp list.
   - Each timestamp follows this format:
     1. `[Name length]`: The length of the SFX name, occupying a single byte, with a maximum value of `FF` (255 characters).
     2. `00 00 00`: 3 empty bytes, possibly used to separate timestamps, as names cannot exceed 255 characters to avoid conflicts with `[Starting]`.
     3. `[Name]`: The SFX name, exactly `[Name length]` bytes long, encoded in ASCII.
     4. `[Starting]`: The start point of the SFX within the combined audio file, stored as unsigned Float32
   - The timestamp list ends with 4 bytes of `00 00 00 00`.
5. **Combined SFX file**:
   - This is the final section of the RSD file, with no checksum.
   - `[Size]`: The size of the combined SFX file. The number of bytes used for this field is not fixed, ending with a `00` byte.
   - `[File SFX]`: The combined SFX file, not compressed using tools like `zip`, `7z`, etc.
