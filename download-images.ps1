# WLAN Ch.04 image downloader
# Run via download-images.bat (preferred) or directly with:
#   powershell -ExecutionPolicy Bypass -File download-images.ps1

$ErrorActionPreference = 'Continue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$base = 'https://cdn-mineru.openxlab.org.cn/result/2026-05-04/42a7ac78-2750-4a02-ad28-10368d5f0aca'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$dir  = Join-Path $root 'images'

if (-not (Test-Path $dir)) {
  New-Item -ItemType Directory -Path $dir | Out-Null
  Write-Host "Created folder: $dir"
}

$files = [ordered]@{
  'fig-4-1.jpg'  = '2ed5416858edf644dbd3e63b6a605ae71358971983f6fa01285cb833d2e00297.jpg'
  'fig-4-2.jpg'  = '9b1c8d6ae85d06c2831f2db5ecec074dbcac0082252cb9e68ab49ba8c3356782.jpg'
  'fig-3-2.jpg'  = '92622f04847557e328033158d6536bca8d553b33a4aa6b4e224266379a212964.jpg'
  'fig-3-12.jpg' = 'a20e006ed74f793a8da8e5db1a2ed404d8839c96e3c7074190b6f209ddc55fe3.jpg'
  'fig-3-18.jpg' = '50e8964d2ae5ead2e81e995eb04882ab57f069e9833146bdbd39f788ec766b51.jpg'
  'fig-4-3.jpg'  = 'f81cfe30e8e49c036d24f98ae505ed4e35d84bfe83326ac14f6f5a6a41ed663d.jpg'
  'fig-4-4.jpg'  = '6086819cf874b6d94889de5f2c657ee689ca057690ba20b5cf39a38e70ae3455.jpg'
  'fig-4-6.jpg'  = 'fcb1056df9a33f493e89609d504216d9c2e56b93236a1cf4e050b953d42c306c.jpg'
  'fig-4-5.jpg'  = 'bc9e284eea860ba5925ea17aaf6b6b8c80c3f2a9f6efdba6c55dc1bfbfd7bb78.jpg'
  'fig-4-8.jpg'  = '190738ad873f2e50c69f67dd6eea254d4fd4325d6677d546d72c289025377ab0.jpg'
  'fig-4-9.jpg'  = 'f9ba5e472abc2d81b4b6a806de2acf3d7664d411e93a68c9e377c66b14117551.jpg'
  'fig-4-10.jpg' = 'd868c1d3bf472b14919bff874e98356730af0b8384fded8d5172fd005ec45207.jpg'
}

$total = $files.Count
$ok = 0; $skip = 0; $fail = 0; $i = 0

Write-Host ""
Write-Host "Downloading $total images to $dir"
Write-Host "------------------------------------------------------------"

foreach ($name in $files.Keys) {
  $i++
  $dest = Join-Path $dir $name
  if (Test-Path $dest -PathType Leaf) {
    $size = (Get-Item $dest).Length
    if ($size -gt 1000) {
      Write-Host ("[{0:00}/{1:00}] SKIP {2}  ({3:N0} bytes already exists)" -f $i,$total,$name,$size)
      $skip++
      continue
    }
  }
  $url = "$base/$($files[$name])"
  Write-Host ("[{0:00}/{1:00}] GET  {2}" -f $i,$total,$name) -NoNewline
  try {
    Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing -TimeoutSec 30 -ErrorAction Stop
    $size = (Get-Item $dest).Length
    Write-Host ("  -> OK ({0:N0} bytes)" -f $size) -ForegroundColor Green
    $ok++
  } catch {
    Write-Host "  -> FAIL: $($_.Exception.Message)" -ForegroundColor Red
    $fail++
  }
}

Write-Host "------------------------------------------------------------"
Write-Host ("Result:  OK={0}   SKIP={1}   FAIL={2}   TOTAL={3}" -f $ok,$skip,$fail,$total)
Write-Host ""
Write-Host "Files in images\:"
Get-ChildItem $dir -File | Sort-Object Name | Format-Table Name, @{N='Size(KB)';E={[Math]::Round($_.Length/1KB,1)}} -AutoSize

if ($fail -gt 0) {
  Write-Host "Some files failed. Check your network and run again." -ForegroundColor Yellow
} elseif (($ok + $skip) -eq $total) {
  Write-Host "All images ready. You can now upload this folder to GitHub." -ForegroundColor Green
}
