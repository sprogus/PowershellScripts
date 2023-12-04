function Logging {
    param(
        [string]$Message = "" ## Message to be logged
    )

    #Get current date in "yyyy-MM-dd" format
    $Date = Get-Date -Format "yyyy-MM-dd"
    
    # Define the logging path as a .log file in the current directory
    $LoggingPath = ".\logging $($Date).log"

    # If the log file doesn't exist create a new one
    if (!(Test-Path -Path $LoggingPath)) {
        New-Item -Path $LoggingPath
    }

    # Get the current date and time in "yyyy-MM-dd HH:mm:ss" format
    $DateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Append the date and time to the message
    $Message = "$($DateTime) $($Message)"

    # Add the message to the log file
    Add-Content -Path $loggingPath $Message

    
}
