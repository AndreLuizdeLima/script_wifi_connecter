Write-Host -B red "conectando a rede default"

$NAME = 'nome da rede'
$AUTHENTICATION = 'tipo de autenticaçãa'
$ENCRYPTION = 'CCMP'
$PASSWORD = 'senha'

$NEWPROFILE = @'
<?xml version="1.0"?>
<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1">
	<name>{0}</name>
	<SSIDConfig>
		<SSID>
			<name>{0}</name>
		</SSID>
	</SSIDConfig>
	<connectionType>ESS</connectionType>
	<connectionMode>auto</connectionMode>
	<MSM>
		<security>
			<authEncryption>
				<authentication>{1}</authentication>
				<encryption>{2}</encryption>
				<useOneX>false</useOneX>
			</authEncryption>
			<sharedKey>
				<keyType>passPhrase</keyType>
				<protected>false</protected>
				<keyMaterial>{3}</keyMaterial>
			</sharedKey>
		</security>
	</MSM>
	<MacRandomization xmlns="http://www.microsoft.com/networking/WLAN/profile/v3">
		<enableRandomization>false</enableRandomization>
	</MacRandomization>
</WLANProfile>
'@ -f $NAME, $AUTHENTICATION, $ENCRYPTION, $PASSWORD

$NEWPROFILE | Out-File Default_net.xml

Start-Sleep -Seconds 1

netsh wlan add profile filename= 'MYPROFILE.xml'

netsh wlan connect name=$NAME ssid=$NAME

Write-Host -B green "Tudo OK"

Start-Sleep -Seconds 1
