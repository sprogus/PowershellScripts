Import-Module .\logging.ps1
function Find-Folder {
    <# .SYNOPSIS#>
    param (
        [string]$FolderToSearch = $(throw "Please specify a folder/s to search in"), ## Specify the directory to search. Fullpath required
        [string]$FolderToFind = $(throw "Please specify a folder to search for") ## Specify the name of the folder to find
    )

    
    $CurrentPath = $FolderToSearch

    while ($CurrentPath -ne $FolderToFind -or $CurrentPath -ne $null) {
        
        logging -message "Searching for $($FolderToFind) folder in $($CurrentPath)"
        # Check if $currentPath is empty or null
        if ([string]::IsNullOrWhiteSpace($CurrentPath)) {
            logging -message "Current path is empty or null."
            return $null
        }

        # Check if $FolderToFind folder exists in the current directory
        $ArchiveFolder = Join-Path -Path $CurrentPath -ChildPath "archive"
        if (Test-Path -Path $ArchiveFolder -PathType Container) {
            logging -message "Found $($FolderToFind) folder: $ArchiveFolder"
            return $ArchiveFolder
        }

        # If $FolderToFind folder not found, go up one level
        $ParentFolder = Split-Path -Path $CurrentPath -Parent
        

        # If already at the root directory, stop searching and return null
        if ($ParentFolder -eq $CurrentPath -or [string]::IsNullOrWhiteSpace($ParentFolder)) {
            logging -message "Reached the root directory. $($FolderToFind) folder not found."
            return $null
        }
       
        else {
        
        
            $CurrentPath = $ParentFolder
        }

    }
   
}