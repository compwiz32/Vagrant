$OU = "OU=TestUserAccounts,DC=MKLAB,DC=INT"
$password = ConvertTo-SecureString "Passw0rd123#" -AsPlainText -Force

$i = 1

1..1000 | Foreach-object {
    $First = invoke-generate "[person both first]"
    $Middle = invoke-generate "[person both first]"
    $Last = invoke-generate "[person both last]"
    $SAM = -join (($First.Substring(0,1)),($Middle.Substring(0,1)),($Last))

    $nameinfo = [PSCustomObject]@{
        First = $First
        Last = $Last
        SAMAcct = $SAM
        DisplayName = $First, $Middle, $Last -join " "
    }

    $NewUserParams = @{
    Name = $nameinfo.SamAcct
    DisplayName = $nameinfo.DisplayName
    GivenName = $nameinfo.First
    Surname = $nameinfo.Last
    Path = $OU
    AccountPassword = $password
    Enabled = $true
    Server = "DC01"
    }
    
    $i
    $i++
    New-ADUser @NewUserParams 
    
}