# Layer Cake - CTF Forensics Challenge

**Challenge:** Layer Cake  
**Category:** Forensics/Steganography  
**Flag:** `grey{s0_f3w_lay3r5_w00p5}`

## Challenge Description
"Layer cake is so good. I have an mp3 file all about layer cake. Maybe you can find the flag there?"

In this challenge, I was provided with an audio file `layer cake.mp3`. However, when I attempted to play the file, I encountered an error, which suggested that something might be hidden inside it.

## Solution Walkthrough

First, I performed basic file analysis using standard forensic tools:

```bash
$ file layer\ cake.mp3
layer cake.mp3: MPEG ADTS, layer III, v1, 80 kbps, 32 kHz, Stereo

$ exiftool layer\ cake.mp3
# Standard MP3 metadata - nothing suspicious
```

The `file` and `exiftool` commands showed normal MP3 file properties, but the file still wouldn't play.

I performed a quick string analysis and found something interesting:

```bash
$ strings layer\ cake.mp3
# Found: "layers/word/document.xmlux"
```

The presence of `layers/word/document.xml` strongly suggested that a Microsoft Word document was hidden inside the file.

Using `binwalk` to analyze the file structure:

```bash
$ binwalk layer\ cake.mp3

DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
69            0x45            Zip archive data, at least v2.0 to extract, name: layers/docProps/
147           0x93            Zip archive data, at least v2.0 to extract, name: layers/docProps/app.xml
618           0x26A           Zip archive data, at least v2.0 to extract, name: layers/docProps/core.xml
1081          0x439           Zip archive data, at least v2.0 to extract, name: layers/word/
1155          0x483           Zip archive data, at least v2.0 to extract, name: layers/word/document.xml
4151          0x1037          Zip archive data, at least v2.0 to extract, name: layers/word/fontTable.xml
4805          0x12C5          Zip archive data, at least v2.0 to extract, name: layers/word/settings.xml
5986          0x1762          Zip archive data, at least v2.0 to extract, name: layers/word/styles.xml
10081         0x2761          Zip archive data, at least v2.0 to extract, name: layers/word/theme/
10161         0x27B1          Zip archive data, at least v2.0 to extract, name: layers/word/theme/theme1.xml
11962         0x2EBA          Zip archive data, at least v2.0 to extract, name: layers/word/webSettings.xml
12425         0x3089          Zip archive data, at least v2.0 to extract, name: layers/word/_rels/
12505         0x30D9          Zip archive data, at least v2.0 to extract, name: layers/word/_rels/document.xml.rels
12855         0x3237          Zip archive data, at least v2.0 to extract, name: layers/[Content_Types].xml
13299         0x33F3          Zip archive data, at least v2.0 to extract, name: layers/_rels/
13374         0x343E          Zip archive data, at least v2.0 to extract, name: layers/_rels/.rels
15253         0x3B95          End of Zip archive, footer length: 22
```

**Key Discovery:** A complete ZIP archive (Word document) was embedded within the MP3 file starting at offset 69 (0x45).

First, I extracted the embedded ZIP file using binwalk:

```bash
$ binwalk -e layer\ cake.mp3
```

This created a file `45.zip` containing the embedded archive.

When I tried to extract the ZIP file using the standard `unzip` command, I encountered errors:

```bash
$ unzip 45.zip
Archive:  45.zip
error [45.zip]:  missing 69 bytes in zipfile
  (attempting to process anyway)
error: invalid zip file with overlapped components (possible zip bomb)
```

However, using 7-Zip was successful despite some warnings:

```bash
$ 7z x 45.zip        

7-Zip 24.09 (x64) : Copyright (c) 1999-2024 Igor Pavlov : 2024-11-29
 64-bit locale=en_US.UTF-8 Threads:32 OPEN_MAX:1024

Scanning the drive for archives:
1 file, 15206 bytes (15 KiB)

Extracting archive: 45.zip

ERRORS:
Unavailable start of archive

--
Path = 45.zip
Type = zip
ERRORS:
Unavailable start of archive
Offset = -69
Physical Size = 15275

ERROR: Unavailable data : layers
             
Sub items Errors: 1

Archives with Errors: 1

Open Errors: 1

Sub items Errors: 1
                     
```

### Step 6: Finding the Flag

After successful extraction, I performed a recursive grep search for the flag format:

```bash
$ grep -r grey .

761" w:themeColor="accent1" w:themeShade="BF"/></w:rPr></w:style><w:style w:type="paragraph" w:styleId="Heading5"><!-- grey{s0_f3w_lay3r5_w00p5} --><w:name w:val="heading 5"/><w:basedOn w:val="Normal"/><w:next w:val="Normal"
```

**Flag:** `grey{s0_f3w_lay3r5_w00p5}`