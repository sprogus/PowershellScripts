Import-Module .\logging.ps1

function Delete-Folder {
    param (
        [string]$FolderPath = $(throw "Please specify a folder to delete subdirectories from"), ## Specify the directory to delete subfolders from. Fullpath required
        [int]$NumberOfDays = $(throw "Please specify the number of days you want to start deleting from eg -60 for older than 60 days"), ## Number of days indicating the age limit for folders to be deleted
        [int]$DeleteFolders = 0 ## Set to 1 if you want to delete folders, default is 0
    )
    
    # Get list of subdirectories from folder path
    $FoldersToClean = Get-ChildItem -Path $FolderPath  | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays($numberOfDays) }
    
    foreach ($Folder in $FoldersToClean.FullName) {
        # Get folder details
        $Folder = Get-Item -Path $Folder
        $FolderLastModified = $Folder.LastWriteTime.ToString("yyyy-MM-dd")

        # Check if deletion is set to be performed
        if ($DeleteFolders -eq 1) {
            # Log and delete folder
            Logging -message "$($Folder.FullName) has been deleted. Folder: $($Folder.FullName), LastModified: $($FolderLastModified)"
            Remove-Item -LiteralPath $Folder.FullName -Force -Recurse
        }
        else {
            #If not deleting, just log
            
            Logging -message "$($Folder.FullName) can be deleted. Folder: $($Folder.FullName), LastModified: $($FolderLastModified)"
        }

    }

}