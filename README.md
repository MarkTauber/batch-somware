# batch-somware

### For scientific purposes only!

Easy ransomware, created using batch.
Works using utilities built into Windows 10, no need for third-party utilities.

## Features

### Recursive search system that avoids system folders

- Appdata
- Windows
- Program files

### earches for several extensions at once

`.ext1, .ext2, .ext3` default, change it on `line 4`. No quantity limits!


### Checks the rights of the current user to modify the file

- Uses `icacls`
- Searches using `findstr`

### Built-in encryptyon

- Uses `certutil` to encrypt data. You can change it on `line 23`
- Overwrites the file without creating a copy (you can change it, see comments on `lines 24-26` and `28-30`


### Built-in message

- Automatically creates `README.html ` on the desktop and opens it at the end
- Does not display a message if no files have been encrypted
