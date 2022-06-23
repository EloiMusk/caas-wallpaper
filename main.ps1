using module modules\WConfig.psm1

$conf = [WConfig]::new()
$conf.init($PSScriptRoot)

function createTask()
{
    #TODO - execute background task that gets the Images
    $taskAction = New-ScheduledTaskAction `
-Execute "powershell.exe" `
-Argument '-Windowstyle Hidden -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Unrestricted -File modules\WConfig.psm1'`
-WorkingDirectory ~\.caas-wallpaper\

    $taskTrigger = New-ScheduledTaskTrigger `
 -Once `
 -At "01:00" `
 -RepetitionInterval (New-TimeSpan -Minutes $conf.images.interval) `
 -RepetitionDuration (New-TimeSpan -Hours 23 -Minutes 55) `

 if (Get-ScheduledTask -TaskName 'caas-wallpaper' -ErrorAction SilentlyContinue)
    {
        $task = Get-ScheduledTask -TaskName 'caas-wallpaper' -ErrorAction SilentlyCoKntinue
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