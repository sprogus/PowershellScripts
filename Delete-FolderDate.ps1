Import-Module .\Logging.ps1

# This function deletes folders based on specified criteria.

function Delete-FolderDate {

    param (
        [string] $Date = $(throw "Please enter a date"), # Accepts a date input
        [string] $FolderPath = $(throw "Please enter a folder path"), # Accepts a folder path
        [int]$NumberOfDays = $(throw "Please specify the number of days you want to start deleting from eg -60 for older than 60 days"), ## Number of days indicating the age limit for folders to be deleted
        [int]$DeleteFolders = 0 ## Set to 1 if you want to delete folders, default is 0
    )

    # Calculate the date from which folders will be considered for deletion
    $DeleteFromDate = ([datetime]$Date).AddDays($NumberOfDays)
    
    # Get folders that match the criteria for deletion based on last write time
    $FoldersToDelete = Get-ChildItem -Path $FolderPath | Where-Object { $_.LastWriteTime -lt $DeleteFromDate }
    
    # Loop through folders that match the criteria
    foreach ($Folder in $FoldersToDelete.FullName) {
        $Folder = Get-Item -Path $Folder
        $FolderLastModified = $Folder.LastWriteTime.ToString("yyyy-MM-dd")

        # Check if deletion flag is enabled
        if ($DeleteFolders -eq 1) {
            # Log and delete folders if specified
            Logging -message "$($Folder.FullName) has been deleted. Folder: $($Folder.FullName), LastModified: $($FolderLastModified)"
            Remove-Item -LiteralPath $Folder.FullName -Force -Recurse  # Remove the folder and its contents
        }
        else {
            # Log folders that can be deleted but won't be deleted due to the flag
            Logging -message "$($Folder.FullName) can be deleted. Folder: $($Folder.FullName), LastModified: $($FolderLastModified)"
        }
    }
}
