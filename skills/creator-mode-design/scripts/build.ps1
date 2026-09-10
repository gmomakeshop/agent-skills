# 使い方: powershell -ExecutionPolicy Bypass -File build.ps1 <デザインセットのフォルダ>
param([Parameter(Mandatory = $true)][string]$SrcDir)
$ErrorActionPreference = 'Stop'

if ('System.Text.CodePagesEncodingProvider' -as [type]) {
  [Text.Encoding]::RegisterProvider([Text.CodePagesEncodingProvider]::Instance)
}
$eucJp = [Text.Encoding]::GetEncoding(20932, [Text.EncoderExceptionFallback]::new(), [Text.DecoderExceptionFallback]::new())
$utf8 = [Text.UTF8Encoding]::new($false, $true)

$rootDir = (Resolve-Path -LiteralPath $SrcDir).Path.TrimEnd('\', '/')
$workDir = Join-Path ([IO.Path]::GetTempPath()) ([IO.Path]::GetRandomFileName())
$cdarDir = Join-Path (Get-Location) ((Split-Path -Leaf $rootDir) + '.cdar')

$config = Join-Path $rootDir 'config.json'
if (-not (Test-Path -LiteralPath $config -PathType Leaf)) {
  Write-Host "config.json が見つかりません: $config"
  exit 1
}

try {
  $null = $utf8.GetString([IO.File]::ReadAllBytes($config))
} catch {
  Write-Host "config.json は UTF-8 で保存してください: $config"
  exit 1
}

New-Item -ItemType Directory -Path $workDir | Out-Null
Copy-Item -LiteralPath $config -Destination $workDir
foreach ($file in Get-ChildItem -LiteralPath $rootDir -Recurse -File -Force | Where-Object { $_.Extension -in '.html', '.css', '.js' }) {
  $dest = Join-Path $workDir $file.FullName.Substring($rootDir.Length + 1)
  New-Item -ItemType Directory -Path (Split-Path -Parent $dest) -Force | Out-Null
  $bytes = [IO.File]::ReadAllBytes($file.FullName)
  try {
    [IO.File]::WriteAllBytes($dest, $eucJp.GetBytes($utf8.GetString($bytes)))
  } catch {
    try {
      $null = $eucJp.GetString($bytes)
    } catch {
      Write-Host "EUC-JP に変換できない文字があります: $($file.FullName.Substring($rootDir.Length + 1))"
      exit 1
    }
    [IO.File]::WriteAllBytes($dest, $bytes)
  }
}

Add-Type -AssemblyName System.IO.Compression.FileSystem
$zip = [IO.Compression.ZipFile]::Open("$workDir.cdar", 'Create')
foreach ($file in Get-ChildItem -LiteralPath $workDir -Recurse -File) {
  $name = $file.FullName.Substring($workDir.Length + 1).Replace('\', '/')
  [IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $file.FullName, $name) | Out-Null
}
$zip.Dispose()

Move-Item -LiteralPath "$workDir.cdar" -Destination $cdarDir -Force
Write-Host "$cdarDir を生成しました。"
