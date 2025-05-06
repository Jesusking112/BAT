@echo off
node 3.js
set version=2.25.0

:torrent_no
cls
setlocal enabledelayedexpansion

:: Nombre del juego / carpeta
set "GAME_NAME=Juegos"
set "DOWNLOAD_DIR=%USERPROFILE%\Desktop\%GAME_NAME%"

:: Magnet link del torrent
:: Mostrar ejemplo de enlace magnet
echo ================================
echo Ejemplo de enlace magnet:
echo "magnet:?xt=urn:btih:CAB8BEA86B869B163558519C5148B3A967C06BF6&tr=http%3A%2F%2Fbt.t-ru.org%2Fann%3Fmagnet&dn=%5BDL%5D%20Breath%20of%20Fire%20IV"
echo ================================
set /p MAGNET_LINK="Pega el enlace magnet y presiona Enter: "

:: Mostrar info
echo ================================
echo Descargando: %GAME_NAME%
echo Carpeta destino: %DOWNLOAD_DIR%
echo ================================

:: Crear carpeta si no existe
if not exist "%DOWNLOAD_DIR%" (
    mkdir "%DOWNLOAD_DIR%"
)

:: Ejecutar aria2c desde el mismo directorio que el script
set "ARIA2C_PATH=%~dp0aria2c.exe"

"%ARIA2C_PATH%" ^
  --dir="%DOWNLOAD_DIR%" ^
  --enable-dht=true ^
  --enable-peer-exchange=true ^
  --bt-save-metadata=true ^
  --bt-metadata-only=false ^
  --bt-tracker-connect-timeout=10 ^
  --bt-tracker-timeout=10 ^
  --bt-request-peer-speed-limit=512K ^
  --max-connection-per-server=10 ^
  --min-split-size=1M ^
  --split=10 ^
  --seed-time=0 ^
  --summary-interval=5 ^
  --console-log-level=info ^
  "%MAGNET_LINK%"

echo.
echo ================================
echo Descarga finalizada o abortada.
Pause
goto Base
