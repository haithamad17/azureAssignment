Connect-AzAccount

Get-AzLocation | select Location
$location = "eastus"

#creating a resource group
$rGroup = "0307Test"
New-AzResourceGroup -Name $rGroup -Location $location

#creating the first storage account named "chelseastorage" with blob encryption
$storageAccount1 = New-AzStorageAccount -ResourceGroupName $rGroup `
  -Name "chelseastorage" `
  -SkuName Standard_LRS `
  -Location $location `
$ctx1 = $storageAccount1.Context
#creating the second storage account named "chelseastorage2" with blob encryption
$storageAccount2 = New-AzStorageAccount -ResourceGroupName $rGroup `
  -Name "chelseastorage2" `
  -SkuName Standard_LRS `
  -Location $location `
$ctx2 = $storageAccount2.Context

#creating the first container for chelseastorage 
$container1Name = "sourcecontainer"
New-AzStorageContainer -Name $containerName -Context $ctx1 -Permission blob
#creating the second storage for chelseastorage2
$container2Name = "targetcontainer"
New-AzStorageContainer -Name $containerName -Context $ctx2 -Permission blob
For ($i=0; $i -le 100; $i++) {
    $file = "C:\blob$i.txt"
    New-Item $file -ItemType File -Value "The first sentence in our file."
    Add-Content $file "The second sentence in our file."
    #Set-Content blob$i.txt 'test text file'
    Set-AzStorageBlobContent -File "C:\blob$i.txt" `
      -Container $container1Name `
      -Blob "C:\blob$i.txt" `
      -Context $ctx1 
}
azcopy login
#azcopy copy 'C:\myDirectory\myTextFile.txt' 'https://mystorageaccount.blob.core.windows.net/mycontainer/myTextFile.txt'
azcopy copy 'https://chelseastorage.blob.core.windows.net/sourcecontainer/?sv=2020-02-10&ss=bfqt&srt=sco&sp=rwdlacuptfx&se=2021-06-10T15:52:22Z&st=2021-06-10T07:52:22Z&spr=https&sig=jSaKedsMy6jWFHY6rbvbeVVaxcP5MlS8K5lgci3lbMo%3D' 'https://chelseastorage2.blob.core.windows.net/targetcontainer' --recursive
