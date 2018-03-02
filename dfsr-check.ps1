##
## Title: DFSR Check  
## Date: 03/02/2018
## Version: 1.00
## Author: Ted Emoto    
## This script scan through all files within the target folder to check if any files are having temp state. 
## If you turn on the swith, it will also correct the state to normal
##


#### Edit here ####
# Specify the top folder of DFS namespace
$tgtFolder = "d:\shared"
# Specify a log path
$logPath = "c:\temp"
# If you want to correct the status to normal at the same time, make the following value to yes
$correctState = "yes"
#### Don't edit anything below ####



## Obtain today's date
$today = [datetime]::Today.ToString('MMddyyyy')
## Scan file state
Get-ChildItem $tgtFolder -Recurse |`
ForEach-Object -process `
{if(($_.attributes -band 0x100) -eq 0x100) {write-output $_}} |`
Out-File -FilePath "$($logPath)\dfs-status$($today).log" -Force
## If yes, start correcting the state to normal
if ($correctState -eq "yes") {

    Get-ChildItem $tgtFolder -Recurse |`
    ForEach-Object -process `
    {if (($_.attributes -band 0x100) -eq 0x100) {$_.attributes = ($_.attributes -band 0xFEFF)}}

} 
