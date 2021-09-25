#requires -module NameIt

$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = "rub1con49bc!"

$i = 1

1..20 | Foreach-object {

    $First = invoke-generate "[person both first]"
    $Last = invoke-generate "[person both last]"
    $UPN = -join (($First.Substring(0, 1)), ($Last), "@mkanakosgmail.onmicrosoft.com")
    $mailNickName = -join (($First.Substring(0, 1)), ($Last))
    $displayname = -join (($first), " ", ($last))


    $i
    $i++

    New-AzureADUser -displayname $displayname -accountEnabled $true -PasswordProfile $PasswordProfile -UserPrincipalName $UPN -MailNickName $mailNickName

}


# New-AzureADUser -AccountEnabled $True -DisplayName "Abby Brown" -PasswordProfile $PasswordProfile -MailNickName "AbbyB" -UserPrincipalName "AbbyB@contoso.com"
