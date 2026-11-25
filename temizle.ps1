# temizle.ps1 - klasördeki dosyaları türe (ve istersen aya) göre ayırır. Hiçbir şey silinmez, yalnız taşınır.
# Kullanım:  .\temizle.ps1 -Dene          (taşımadan ne olacağını gösterir)
#            .\temizle.ps1                (türe göre taşır)
#            .\temizle.ps1 -Tarih         (tür + ay: PDF\2026-11)
# "Bu sistemde betik çalıştırma devre dışı" hatası alırsan, YALNIZ bu PowerShell penceresi için izin ver:
#            Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
param(
  [string]$Klasor = (Join-Path $env:USERPROFILE 'Downloads'),
  [switch]$Tarih,
  [switch]$Dene
)
$tur = @{
  'PDF'    = 'pdf'
  'Arşiv'  = 'zip','rar','7z'
  'Resim'  = 'jpg','jpeg','png','gif','webp','heic'
  'Video'  = 'mp4','mov','mkv','avi'
}
$harita = @{}
foreach ($ad in $tur.Keys) { foreach ($u in $tur[$ad]) { $harita[$u] = $ad } }

$sayac = 0
Get-ChildItem -LiteralPath $Klasor -File | ForEach-Object {
  $u = $_.Extension.TrimStart('.').ToLower()
  if (-not $harita.ContainsKey($u)) { return }
  $hedef = Join-Path $Klasor $harita[$u]
  if ($Tarih) { $hedef = Join-Path $hedef $_.LastWriteTime.ToString('yyyy-MM') }
  $yol = Join-Path $hedef $_.Name
  $i = 1
  while (Test-Path -LiteralPath $yol) {   # aynı ad varsa üzerine yazma
    $yol = Join-Path $hedef ("{0} ({1}){2}" -f $_.BaseName, $i, $_.Extension); $i++
  }
  $goster = $hedef.Substring($Klasor.Length).TrimStart('\')   # ekranda kısa göster: Resim ya da PDF\2026-11
  if ($Dene) { Write-Host "TAŞINIRDI: $($_.Name) -> $goster" }
  else {
    New-Item -ItemType Directory -Path $hedef -Force | Out-Null
    Move-Item -LiteralPath $_.FullName -Destination $yol
    Write-Host "taşındı: $($_.Name) -> $goster"
  }
  $sayac++
}
Write-Host "$sayac dosya" ($(if ($Dene) { 'taşınırdı (deneme modu)' } else { 'taşındı' }))
