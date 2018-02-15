$VM = @()
$VHD =@()
$DiskSize = @()

function Resize-Disk
    {
        $VM = Get-VM | Out-GridView -PassThru
        $VHD = Get-VM -Name $VM.Name | Select-Object VMId | Get-VHD | Out-GridView -PassThru
        $DiskSize = @(40GB,45GB,50GB,55GB,60GB,65GB,70GB,75GB,80GB,85GB,90GB,95GB,100GB)
        $DiskSize = $DiskSize | Out-GridView -PassThru -Title "Select New disk size"

        Stop-VM -Name $VM.Name -TurnOff -Verbose
        Resize-VHD -Path $VHD.Path -SizeBytes $DiskSize -Verbose
        #Get-FollowOnAction
    }

function Get-FollowOnAction
    {
        $FollowOnAction = @("Resize another disk","Exit")
        $FollowAction = $FollowAction | Out-GridView -Title "Your disk has now been resized.  Please select a follow on action"

            Switch ($FollowOnAction)

                {
                    "Resize another disk"

                        {
                            
                            Resize-Disk
                            #Get-FollowOnAction
                        }

                    "Exit"

                        {
                            Write-Host "Goodbye" -ForegroundColor Yellow
                            Exit
                        }

                    default

                        {
                            
                            Write-Host "You have not selected an action" -ForegroundColor Yellow
                            Exit
                        }
                }

    }

Resize-Disk
#Get-FollowOnAction
