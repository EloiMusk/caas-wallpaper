using module modules\WConfig.psm1
using module modules\WSetup.psm1

$localPath = $env:APPDATA + "\caas-wallpaper"

[WSetup]::checkLocalFolderStructure($localPath, $PSScriptRoot)

$conf = [WConfig]::new($localPath)

function createTask()
{
    #TODO - execute background task that gets the Images
    $taskAction = New-ScheduledTaskAction `
-Execute "powershell.exe" `
-Argument $PSScriptRoot'\getImages.ps1 -Windowstyle Hidden -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Unrestricted -File modules\WConfig.psm1'`
-WorkingDirectory $PSScriptRoot

    $taskTrigger = New-ScheduledTaskTrigger `
 -Once `
 -At "01:00" `
 -RepetitionInterval (New-TimeSpan -Minutes $conf.images.interval) `
 -RepetitionDuration (New-TimeSpan -Hours 23 -Minutes 55) `

 if (Get-ScheduledTask -TaskName 'caas-wallpaper' -ErrorAction SilentlyContinue)
    {
        $task = Get-ScheduledTask -TaskName 'caas-wallpaper' -ErrorAction SilentlyContinue
        $taskTriggers += $taskTrigger
        $task.Triggers = $taskTriggers
        $task | Set-ScheduledTask
    }
    else
    {
        $task = Register-ScheduledTask -TaskName "caas-wallpaper" -Trigger $taskTrigger -Action $taskAction
    }
}

createTask

#Write-Host "How many images do you want to generate? "
#$conf.images.imageCount = Read-Host
#$conf.save()