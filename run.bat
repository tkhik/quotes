@echo off
chcp 65001

:: quotes.txt の絶対パス（必要に応じて変更）（Cドライブ直下推奨）
set "QUOTEFILE=C:\quotes.txt"


:: 一時 PowerShell スクリプトを作成
set "PSSCRIPT=%TEMP%\get_quote.ps1"
(
    echo $lines = Get-Content -Path "%QUOTEFILE%"
    echo $filtered = $lines ^| Where-Object { $_ -ne "" }
    echo $quote = $filtered ^| Get-Random
    echo Write-Output $quote
) > "%PSSCRIPT%"

:: 一時ファイルでPowerShell出力を取得
powershell -ExecutionPolicy Bypass -File "%TEMP%\get_quote.ps1" > "%TEMP%\quote.txt" 2> "%TEMP%\quote_err.txt"

:: quote.txt が存在するか確認
if not exist "%TEMP%\quote.txt" (
    echo [エラー] 名言出力が失敗しました。
    type "%TEMP%\quote_err.txt"
    pause
    exit /b
)

:: 名言を表示
cls
echo ========================================================
type "%TEMP%\quote.txt"
echo ========================================================

