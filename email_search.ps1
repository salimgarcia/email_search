<#
Searches for a specific email in a list of files and writes out the
name of the file(s) that contain the specified email.
Can also delete the specified email from the file(s), or
replace it with a new email.
#>

Param(
  [string]$filepath, 
  [string]$email
)

$files = Get-ChildItem $filepath

<#Searches through each txt file in the emails folder for the specified email, then outputs the file(s) that contain the specified email#>
ForEach ($file in $files.FullName) {
  Select-String -AllMatches -Path $file $email -List | Format-Table Filename | Write-Output
}


$option = Read-Host -Prompt '[Q] Quit [D] Delete [R] Replace'

<#Quits the script#>
If ($option -eq 'Q') {
}

<#Deletes the email from the file(s)#>
elseif ($option -eq 'D') {
  ForEach ($file in $files.FullName) {
    ((Get-Content -Path $file) -replace $email, "") | Set-Content -Path $file
  }
}

<#Replaces the email with a different email#>
elseif ($option -eq 'R') {
  $newemail = Read-Host -Prompt 'Enter new email'
  ForEach ($file in $files.FullName) {
    ((Get-Content -Path $file) -replace $email, $newemail) | Set-Content -Path $file
  }
}
