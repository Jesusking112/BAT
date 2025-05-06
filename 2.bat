set version=3.0.0
echo version %version%

set URL=
msg * Bienvenido a mi intento de herramienta
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:Base
cls
echo ******************************** Menu de Opciones ***********************************
echo.
echo (1) Descargar videos (Windows)
echo (2) Comprimir videos.mp4 (Windows)
echo (3) Convertir un video.mp4 a texto y texto a video.mp4 (windows)
echo (4) Convertidor de paginas (Windows X64-Nativefier)
echo (5) Buscar archivos *.extencion (Windows)
echo (6) Conversor de formatos de audio (windows)
echo (7) Descargar enlace de torrent (Windows)
echo (8) Compresor de video por megabaits .mp4 (Windows)
echo .
echo (a1) Mirar licencia de (windows 11)
echo (b1) Telemetria (windows 11)
echo (b2) Privacidad (windows 11)
echo (b3) Blodware - y mas (windows 11)
echo (c1) Opciones de red ipconfig (Windows 10-11)
echo 
echo.
echo 0 Salir
echo.
set /p B1="Selecciona una opcion (0-X): "

if "%B1%"=="1" goto menu
if "%B1%"=="2" goto comprimir_vid
if "%B1%"=="3" goto vid_txt_vid
if "%B1%"=="4" goto native_menu
if "%B1%"=="5" goto buscador_win
if "%B1%"=="6" goto menuss
if "%B1%"=="7" goto torrent_no
if "%B1%"=="8" goto video_tamaño
if "%B1%"=="a1" goto licencia_view
if "%B1%"=="b1" goto telemetria_win_11
if "%B1%"=="b2" goto privacidad_win_11
if "%B1%"=="b3" goto blodware_win_11
if "%B1%"=="c1" goto opc_red_sub_menu
if "%B1%"=="0" exit
goto Base
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:menu
@echo off
cd /d "%~dp0"
cls
echo Advertencia poner la carpeta en el escritorio para evitar perder datos
echo teoricamente no puede pasar pero para tener precausion en caso que pase
echo ******************************** Menu de Opciones ***********************************
echo.
echo 1   Poner o remplazar el enlace del video              (Esto es obligatorio)
echo 2e  Descargar el video y audio en la mejor calidad     (Video-Audio)
echo 2m  Descatgar Video y Audio por separado               (Video.mp4-audio.mp3)
echo 3a  Descargar solo el audio de calidad estandar        (Audio.mp3)
echo 3b  Descargar solo el mejor audio                      (Audio)
echo 8   Descargar video privado con cookies                (Video-Cookies)
echo 9   Descargar con subtitulos                           (Video-Subtitulos)
echo 10a Limitar la velocidad de descarga                   (Video-Limitar internet)
echo 10b Selecionar opciones de descarga                    (Video full-Seleccionar calidad)
echo 13  Descargar Video                                    (Video full)
echo 14  Descargar a traves de un servidor proxy            (Video-Proxy)
echo 15  Descargar contenido de sitios no oficiales         (Video full)
echo.
echo 0 Regresar
echo.
set /p option="Selecciona una opcion (0-10): "

if "%option%"=="1" goto set_url
if "%option%"=="2e" goto best_quality
if "%option%"=="2m" goto video_o_audio
if "%option%"=="3a" goto audio_minimo
if "%option%"=="3b" goto best_audio
if "%option%"=="8" goto download_private
if "%option%"=="9" goto download_subtitles
if "%option%"=="10a" goto limit_speed
if "%option%"=="10b" goto personalizado
if "%option%"=="13" goto download_mp4_playlist
if "%option%"=="14" goto download_proxy
if "%option%"=="15" goto download_other_sites
if "%option%"=="0" goto Base
goto menu

:set_url
cls
echo Ingresa la URL del video o lista de reproduccion
set /p URL="URL: "
echo.
echo URL establecida: %URL%
pause
goto menu

:video_o_audio
cls
set "panel=1"
goto personalizado2

:personalizado
cls
set "panel=2"
:personalizado2
echo El audio predeterminado es: 233
echo El video asegurate que diga extencion mp4, en base a eso la calidad
set /p FILE_NAME="Introduce un nombre para el archivo final: "
echo Obteniendo las calidades disponibles...
echo ------------------ Formatos disponibles ------------------
yt-dlp.exe -F %URL% | findstr /i "audio only"
echo.
echo Seleciona el codigo de la primera linea de cada renglon para especificar
echo             El audio y video tienen que ser compatibles
set /p AUDIO_FORMAT="Introduce el codigo de la calidad de audio (ejemplo: 233): "
set /p VIDEO_FORMAT="Introduce el codigo de la calidad de video (ejemplo: 231): "

if "%panel%"=="1" goto personalizadosin
if "%panel%"=="2" goto personalizadomezcla

:personalizadosin
echo Descargando video...
yt-dlp.exe -f %VIDEO_FORMAT% -o "%FILE_NAME%.mp4" %URL%
echo Descargando audio...
yt-dlp.exe -f %AUDIO_FORMAT% -o "%FILE_NAME%.mp3" %URL%
pause
goto menu

:personalizadomezcla
echo Descargando video...
yt-dlp.exe -f %VIDEO_FORMAT% -o "%FILE_NAME%_video" %URL%
echo Descargando audio...
yt-dlp.exe -f %AUDIO_FORMAT% -o "%FILE_NAME%_audio" %URL%
echo Combinando video y audio con ffmpeg...
ffmpeg -i "%FILE_NAME%_video" -i "%FILE_NAME%_audio" -c:v copy -c:a aac -strict experimental "%FILE_NAME%.mp4"
del "%FILE_NAME%_video"
del "%FILE_NAME%_audio"
echo ¡Descarga y combinación completadas!
pause
goto menu

:best_quality
cls
if "%URL%"=="" (
    echo No se ha establecido una URL Vuelve a la opcion 1 para establecerla
    pause
    goto menu
)
yt-dlp.exe -f bestvideo+bestaudio --write-sub --output "%(title)s.%(ext)s" %URL%
pause
goto menu

:download_subtitles
cls
if "%URL%"=="" (
    echo No se ha establecido una URL Vuelve a la opcion 1 para establecerla
    pause
    goto menu
)
yt-dlp.exe --write-sub %URL%
pause
goto menu

:download_private
cls
if "%URL%"=="" (
    echo No se ha establecido una URL Vuelve a la opcion 1 para establecerla
    pause
    goto menu
)
echo Ingresa el archivo de cookies
set /p cookies_file="Archivo de cookies: "
yt-dlp.exe --cookies %cookies_file% %URL%
pause
goto menu

:download_mp4_playlist
cls
if "%URL%"=="" (
    echo No se ha establecido una URL Vuelve a la opcion 1 para establecerla
    pause
    goto menu
)
yt-dlp.exe -f mp4 --yes-playlist %URL%
pause
goto menu

:download_proxy
cls
if "%URL%"=="" (
    echo No se ha establecido una URL Vuelve a la opcion 1 para establecerla
    pause
    goto menu
)
echo Ingresa la URL del proxy ejemplo http://proxy.example.com:8080
set /p proxy="Proxy: "
yt-dlp.exe --proxy %proxy% %URL%
pause
goto menu

:limit_speed
cls
if "%URL%"=="" (
    echo No se ha establecido una URL Vuelve a la opcion 1 para establecerla
    pause
    goto menu
)
echo Ingresa el limite de velocidad ejemplo 500K
set /p speed_limit="Limite de velocidad: "
yt-dlp.exe --limit-rate %speed_limit% %URL%
pause
goto menu

:download_other_sites
cls
if "%URL%"=="" (
    echo No se ha establecido una URL Vuelve a la opcion 1 para establecerla
    pause
    goto menu
)
yt-dlp.exe %URL%
pause
goto menu

:best_audio
cls
if "%URL%"=="" (
    echo No se ha establecido una URL. Vuelve a la opcion 1 para establecerla.
    pause
    goto menu
)
yt-dlp.exe -f bestaudio %URL%

:na
setlocal enabledelayedexpansion
if not exist "musica_mp3" (
    mkdir musica_mp3
    echo Carpeta "musica_mp3" creada.
)

for %%f in (*.webm *.m4a *.opus *.flac *.aac) do (
    set "filename=%%~nf"
    set "filename=!filename:\=_!"
    set "filename=!filename:/=_!"
    set "filename=!filename::=_!"
    set "filename=!filename:*=_!"
    set "filename=!filename:?=_!"
    set "filename=!filename:<=_!"
    set "filename=!filename:>=_!"
    set "filename=!filename:|=_!"
    set "filename=!filename:\"=_!"

    if /i "%%~xf" neq ".mp3" (
        ffmpeg -i "%%f" -vn -acodec libmp3lame -ar 44100 -ac 2 -ab 192k "musica_mp3\!filename!.mp3"
        echo El archivo %%f ha sido convertido a: musica_mp3\!filename!.mp3
    )
)

for %%f in (*.webm *.m4a *.opus *.flac *.aac) do (
    if exist "%%f" (
        del /f "%%f"
        echo El archivo %%f ha sido eliminado.
    )
)

echo.
echo Los archivos convertidos han sido guardados en la carpeta "musica_mp3".
echo Por favor, elimine los restos de archivos originales no deseados.
pause
endlocal
goto menu

:audio_minimo
set /p FILE_NAME="Introduce un nombre para el audio: "
echo Descargando audio...
yt-dlp.exe -f 233 -o "%FILE_NAME%.mp3" %URL%
pause
goto menu
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
