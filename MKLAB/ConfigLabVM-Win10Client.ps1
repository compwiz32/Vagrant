

#Set execution Policy
Set-ExecutionPolicy -ExecutionPolicy AllSigned -Force

# Resize PS Cmd prompt

# pin Icon to taskbar

#Install Choco

Set-ExecutionPolicy Bypass -Scope Process -Force;
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#Install choco packages
Choco install git 7zip notepadplusplus powershell-core microsoft-edge /y

# Reinstall VIM (the installer in image is broken)
choco install vim --force

#After install, remove vim permanently.
choco uninstall vim -y


#install Modules

# Install PSWIndowsUpdate
Install-Module PSWindowsUpdate
install-module ImportExcel
Install-Module PSReadLine

#Add Microsoft Updates
Add-WUServiceManager -MicrosoftUpdate

#install all updates
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot


# create new local admin acct

$pass = ConvertTo-SecureString "Passw0rd123#"-AsPlainText -force
New-LocalUser -Name mkadmin -Password $pass -Description "Mike's Admin Acct"
Add-LocalGroupMember -Group administrators -Member mkadmin

# Set Static IP address


# Install Windows Features
Install-WindowsFeature -IncludeManagementTools -IncludeAllSubFeature AD-Domain-Services, DHCP, DNS, GPMC

#Update Help
start-job { update-help }


#create domain
$pass = ConvertTo-SecureString "Passw0rd123#"-AsPlainText -force

$DomainParams = @{
    CreateDnsDelegation           = $false
    DatabasePath                  = "C:\Windows\NTDS"
    DomainMode                    = “Win2012R2”
    DomainName                    = "MKLAB.INT"
    DomainNetbiosName             = "MKLAB"
    ForestMode                    = "Win2012R2"
    InstallDns                    = $true
    LogPath                       = "C:\Windows\NTDS"
    NoRebootOnCompletion          = $false
    SysvolPath                    = "C:\Windows\SYSVOL"
    SafeModeAdministratorPassword = $pass
}

Install-ADDSForest @DomainParams

#Configure DNS




