# Notsus.Exe/forensics
**Flag:** `grey{this_program_cannot_be_run_in_dos_mode_hehe}`

## Challenge Description
"```<Insert Guessy forensics challenge description here>```"


A "guessy" forensics challenge where I was provided with a ZIP file `files.zip` containing encrypted files.


First, I performed basic file analysis to understand what I was working with:

```bash
$ file files.zip
files.zip: Zip archive data, at least v2.0 to extract, compression method=store

$ exiftool files.zip
ExifTool Version Number         : 13.10
File Name                       : files.zip
Directory                       : .
File Size                       : 6.7 MB
File Modification Date/Time     : 2025:05:31 12:00:33-04:00
File Access Date/Time           : 2025:05:31 12:00:33-04:00
File Inode Change Date/Time     : 2025:05:31 12:00:33-04:00
File Permissions                : -rwxrwxrwx
File Type                       : ZIP
File Type Extension             : zip
MIME Type                       : application/zip
Zip Required Version            : 20
Zip Bit Flag                    : 0x0001
Zip Compression                 : None
Zip Modify Date                 : 2025:05:05 17:04:38
Zip CRC                         : 0xd4bef751
Zip Compressed Size             : 61
Zip Uncompressed Size           : 61
Zip File Name                   : flag.txt.yorm
Warning                         : [minor] Use the Duplicates option to extract tags for all 2 files
```

The analysis suggested the flag was inside the ZIP file, but nothing immediately suspicious.

Attempting to unzip revealed the file was password-protected:

```bash
$ unzip files.zip
# Password required
```

I listed the contents to see what was inside:

```bash
$ unzip -l files.zip
Archive:  files.zip
  Length      Date    Time    Name
---------  ---------- -----   ----
       49  2025-05-05 17:04   flag.txt.yorm
  6716527  2025-05-05 16:43   notsus.exe
```

The ZIP contained two files:
- `flag.txt.yorm` (49 bytes)
- `notsus.exe` (6,716,527 bytes)


Using 7-Zip for more detailed information:

```bash
$ 7z l -slt files.zip
```

**Key findings:**
- Both files are encrypted using **ZipCrypto Store** method
- `flag.txt.yorm`: Size 49, Packed Size 61 (12 bytes difference)
- `notsus.exe`: Size 6,716,527, Packed Size 6,716,539 (12 bytes difference)
- Encryption method: Store (older PKZip format)

I attempted to crack the password using John the Ripper:

```bash
$ zip2john files.zip > hash.txt
$ john hash.txt --wordlist=/usr/share/wordlists/rockyou.txt
```

This approach took too long and yielded no results, so I stopped it. The hash format showed `pkzip`, indicating an older compression method vulnerable to known-plaintext attacks.


After the dictionary attack failed, I consulted Claude Sonnet 4 with my findings. Claude suggested several approaches, with **known-plaintext attack** being the most promising technique for this type of legacy ZIP encryption.

Following Claude's recommendation, I researched the `bkcrack` tool, which performs known-plaintext attacks against ZipCrypto. This attack requires 12 bytes of known plaintext from the encrypted files.

Reference: [Cracking Legacy Encrypted ZIP Files](https://medium.com/@keeper772/cracking-legacy-encrypted-zip-files-bb59515e3f11)

Tool: https://github.com/kimci86/bkcrack.git

Since the challenge description mentioned "guessy," I needed to guess what content was inside the files.

**Initial attempts on `flag.txt.yorm`:**
- Tried common flag formats
- The `.yorm` extension appeared to be custom, making it harder to guess

**Focus on `notsus.exe`:**
- EXE files have predictable headers and common bytes
- Much larger file = higher chance of success

So I tried 
Testing with common EXE header:


```bash
$ echo '\x4d\x5a' > mz_header.bin
$ bkcrack -C ./files.zip -c notsus.exe -p ./mz_header.bin
```
After several failed manual attempts, I asked Claude to help write a PowerShell script that would systematically generate common EXE file headers and test them against `bkcrack`:

After testing various EXE headers, I successfully obtained the encryption keys:

```powershell
$ .\exploit.ps1
73.7 % (336684 / 456623)[1K
Keys: d1608c35 d11d350a 4bc3da9c
73.9 % (337230 / 456623)[1K
73.9 % (337240 / 456623)
Found a solution. Stopping.
You may resume the attack with the option: --continue-attack 337240
[17:34:44] Keys
d1608c35 d11d350a 4bc3da9c
```

```
Keys: d1608c35 d11d350a 4bc3da9c
```

Using the keys to recover the actual password:

```bash
$ bkcrack -k d1608c35 d11d350a 4bc3da9c -r 10..20 ?p
```

**Password recovered:** `21SZh=PC89Zb`

With the password, I extracted the ZIP contents:

```bash
$ unzip files.zip
# Used password: 21SZh=PC89Zb
```

**Issue:** The `flag.txt.yorm` file was still encrypted with an unknown method.

Suspecting that `notsus.exe` was designed to decrypt the flag file:

```bash
$ ./notsus.exe
```

**Result:** The program generated `flag.txt.yorm.yorm` - the decrypted flag file.

**Flag:** `grey{this_program_cannot_be_run_in_dos_mode_hehe}`