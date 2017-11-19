function Expand-WebArchive
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true,
                   Position=0)]
            [string]$Uri,
        [Parameter(Mandatory=$false,
                   Position=0)]
            [string]$DestinationPath = "."
    )

    Begin
    {
        # Create temporary file with the name of the archive to download
        #
        # NOTE 1: New-TemporaryFile is force evaluated before Rename-Item due to
        #         the () around it.
        #
        # NOTE 2: The URI is split by the '/' characters and the last part is taken
        #
        # NOTE 3: -PassThru is provided so the modified item is returned for assignment
        $TempFile = Rename-Item (New-TemporaryFile) -NewName ($Uri.Split('/')[-1]) -PassThru;
        Write-Verbose -Message "Created temporary file $TempFile";
    }
    Process
    {
        # Download content into temporary file
        Write-Verbose -Message "Dowloading $Uri into temporary archive";
        Invoke-WebRequest -Uri $Uri -OutFile $TempFile;

        # Expand the archive into the desired destination
        Write-Verbose -Message "Expanding temporary archive to $DestinationPath";
        Expand-Archive -Path $TempFile.FullName -DestinationPath $DestinationPath;
    }
    End
    {
        # Remove the downloaded temporary
        Write-Verbose -Message "Removing temporary archive";
        Remove-Item $TempFile;
    }
}