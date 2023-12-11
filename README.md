# batch-somware

### For scientific purposes only!

Easy ransomware, created using batch at 4:20 a.m. "because I can but I dont know how to"

Works using utilities built into Windows 10, no need for third-party utilities.

And yes, there is no pasword. Because windows has no utils like that (maybe I'll change it idk). 

In any case, this way is better than simple renamers or editing register


## Features

### Smart recursive search 
- Searches in homedrive
- Avoid appdata folder
- Avoid Windows folder
- Avoid Program files folder
- Avoid empty files

### Searches for several extensions at once

`.ext1, .ext2, .ext3` default, change it on `line 4`. No quantity limits!


### Checks the rights of the current user to modify the file

- Uses `icacls` to display file access
- Searches current user rights using `findstr`

### Built-in encryptyon

- Uses `certutil` to encrypt data. You can change it or modify on `line 29`
- Shuffling the encrypted Base64 strings (`lines 50-76`)
- ~~Overwrites the file without creating a copy (you can change it, see comments on `lines 26-28` and `30-32`~~


### Built-in message (AV alerts here btw, change the sus words like "encrypted" in it to avoid)

- Automatically creates `README.html ` on the desktop and opens it at the end
- Does not display a message if no files have been encrypted
- Shows how many and which files (extensions only) have been encrypted (you can change it on `lines 43-44`, `%cnt%` and `%fileExtension%` variables)


### Other 

- Hides console window on start (`lines 7-13`)

### About Shuffling (WIP)
For now it uses simple shuffle system taht pulls out every first character followed by every 3rd character:

```1st  | 1234567890 = 1
3rd  | 234567890  = 14
1st  | 23567890   = 142
3rd  | 3567890    = 1426
1st  | 357890     = 14263
3rd  | 57890      = 142638
1st  | 5790       = 1426385
3rd  | 790        = 14263850
1st  | 79         = 142638507
3rd  | 9          = 1426385079
```
Slowed because its f*cking hard to process every line manually

I've tried to shuffle hex, but batch has limitations on the number of characters in line (nearly 1024 symbols), so it's easier to work with a large number of short strings without touching the concatenation topic
