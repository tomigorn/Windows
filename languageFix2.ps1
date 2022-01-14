<#
    script to remove annoying Windows bug that auto adds en-US language.
    works with adding the language and then removing it again.

    if an error pops up with "scripts is disabled on this system" simply do this:
    Get-ExecutionPolicy
    Set-ExecutionPolicy RemoteSigned
    Then run this sciprt.
    After running it you can set the execution policy to what it was before or leave it as it is. I do not recommend leaving it.

    @author: tomigorn
    @date: 2022/01/14
#>

$scriptName = $MyInvocation.MyCommand.Name
Write-Host "$scriptName starting.."

$LanguageList = Get-WinUserLanguageList

if($LanguageList -notcontains 'en-US')
{
    $LanguageList.Add("en-US")
}
Set-WinUserLanguageList $LanguageList -Force

$LanguageList.Remove(($LanguageList | Where-Object LanguageTag -like 'en-US'))
Set-WinUserLanguageList $LanguageList -Force

Write-Host "$scriptName finished."