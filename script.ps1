﻿az login
#.\azcopy login --tenant-id "a744ad3c-a378-440b-95ad-97af5c23c30a"
.\azcopy make "https://chelseastorage.blob.core.windows.net/sourcecontainer"
.\azcopy make "https://chelseastorage2.blob.core.windows.net/targetcontainer"
For ($i=0; $i -le 10; $i++) {
    $file = "C:\blob$i.txt"
    New-Item $file -ItemType File -Value "The first sentence in our file."
    Add-Content $file "The second sentence in our file."
    #Set-Content blob$i.txt 'test text file'
    .\azcopy copy $file "https://chelseastorage.blob.core.windows.net/sourcecontainer/?sv=2020-02-10&ss=bfqt&srt=sco&sp=rwdlacuptfx&se=2021-06-10T15:52:22Z&st=2021-06-10T07:52:22Z&spr=https&sig=jSaKedsMy6jWFHY6rbvbeVVaxcP5MlS8K5lgci3lbMo%3D"
}
.\azcopy copy 'https://chelseastorage.blob.core.windows.net/sourcecontainer/?sv=2020-02-10&ss=bfqt&srt=sco&sp=rwdlacuptfx&se=2021-06-10T15:52:22Z&st=2021-06-10T07:52:22Z&spr=https&sig=jSaKedsMy6jWFHY6rbvbeVVaxcP5MlS8K5lgci3lbMo%3D' 'https://chelseastorage2.blob.core.windows.net/targetcontainer' --recursive