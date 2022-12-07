class WSetup
{
    static checkLocalFolderStructure($localPathRoot, $scriptRoot)
    {
        if (!(Test-Path $localPathRoot))
        {
            New-Item -ItemType Directory -Path $localPathRoot
        }
        if (!(Test-Path "$localPathRoot\config"))
        {
            New-Item -ItemType Directory -Path "$localPathRoot\config"
        }
        if (!(Test-Path "$localPathRoot\config\config.xml"))
        {
            Copy-Item -Path "$scriptRoot\config\config.xml" -Destination "$localPathRoot\config\config.xml"
        }
        if (!(Test-Path "$localPathRoot\images"))
        {
            New-Item -ItemType Directory -Path "$localPathRoot\images"
        }
    }
}