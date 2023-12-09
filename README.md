# batch-somware

### For scientific purposes only!

Easy ransomware, created using batch.
Works using utilities built into Windows 10, no need for third-party utilities.
And yes, there is no pasword. Because windows does not have utils like that. 
In any case, this way is better than simple renamers or editing register

## Features

### Smart recursive search 
- Searches in homedrive
- Avoid appdata folder
- Avoid Windows folder
- Avoid Program files folder
- Avoid empty files

### earches for several extensions at once

`.ext1, .ext2, .ext3` default, change it on `line 4`. No quantity limits!


### Checks the rights of the current user to modify the file

- Uses `icacls` to display file access
- Searches current user rights using `findstr`

### Built-in encryptyon

- Uses `certutil` to encrypt data. You can change it on `line 23`
- Overwrites the file without creating a copy (you can change it, see comments on `lines 24-26` and `28-30`


### Built-in message

- Automatically creates `README.html ` on the desktop and opens it at the end
- Does not display a message if no files have been encrypted
- Shows how many and which files (extensions only) have been encrypted (you can change it on `lines 43-44`, `%cnt%` and `%fileExtension%` variables)
