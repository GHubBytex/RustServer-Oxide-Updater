# Lesen Sie die Pfade aus der config.cfg Datei
$config = Get-Content -Path "config.cfg"
$serverDataPath = $config[1]

# Setzen Sie die Basis-URL für die GitHub API
$apiUrl = 'https://api.github.com/repos/OxideMod/Oxide.Rust/releases/latest';

# Ruft die neuesten Release-Informationen ab
$response = Invoke-RestMethod -Uri $apiUrl;

# Extrahiert die URL des ersten Assets aus der Response
$assetUrl = $response.assets[0].browser_download_url;

# Überprüft, ob eine Asset-URL gefunden wurde
if ($null -ne $assetUrl) {
    # Setzt den Namen der Ausgabedatei
    $outputFile = 'latest_release.zip';

    # Lädt die Datei herunter
    Invoke-WebRequest -Uri $assetUrl -OutFile $outputFile;

    # Informiert den Benutzer, dass der Download abgeschlossen ist
    Write-Host 'Download abgeschlossen. Die Datei wurde als $outputFile gespeichert.';

	# Entpackt die ZIP-Datei und überschreibt vorhandene Dateien ohne zu fragen
	Expand-Archive -LiteralPath $outputFile -DestinationPath $serverDataPath -Force;


    # Löscht die ZIP-Datei
    Remove-Item -LiteralPath $outputFile;

    # Informiert den Benutzer, dass die ZIP-Datei entpackt und gelöscht wurde
    Write-Host 'Die ZIP-Datei wurde entpackt und Oxide installiert.';
    Write-Host 'ZIP-Datei wurde gelöscht.';
}
else {
    # Informiert den Benutzer, dass keine Assets gefunden wurden
    Write-Host 'Keine Assets gefunden.';
}
