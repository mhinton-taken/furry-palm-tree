#Goal:Powershell script that given a list of users (SamAccountName), it will list out various user details such as name, the country information.  Also, if the account is enabled. Repo name of furry-palm-tree was auto-suggested by GitHub

#Usage notes: To test, sugggest to have two test accounts inside your domain to experiment.


#Variables

#input file of user names. This variable contains where the input file is stored. One user name per line.

$Userlist= Get-Content -Path D:\Tools\logs\users2find.txt

 

#Current Date

$CURRENTDATE = get-date -format yyyy-MM-dd

 

#Directory for output file storage

$DIR = "D:\Tools\logs\"

 

#Export Filename for export.

$FILENAME1 = $CURRENTDATE + "_user_details.csv"

 

#Variable to help measure script execution time

$StopWatch = [System.Diagnostics.stopwatch]::StartNew()

 

#Main

 

#loop through file named in $Userlist

$Output = foreach ($User in $Userlist) {

Get-ADUser -Identity $User -Properties DisplayName,AccountExpirationDate, Description, Department,enabled, Name,SamAccountName,c,co,countryCode,GivenName,Surname,Manager 

}

 

#Output results to file. Due to using a foreach loop above requires additional measures. Because that loop type doesn't support pipelining we assign its output to the $Output variable.

#future note: Consider ForEach-Object loop, which supports pipelining

$Output | Export-Csv -path ($DIR + $FILENAME1) -NoTypeInformation -Encoding UTF8

 

#This part writes script execution time to console when script finishes

write-host " "

write-host "Script Completed. Execution time:"$StopWatch.Elapsed.TotalSeconds" seconds" 