set version=3.1.0

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Este script requiere permisos de administrador.
    echo Solicitando permisos...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

set URL=
msg * Bienvenido a mi intento de herramienta
:: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:Base
cls
echo version %version%
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
:comprimir_vid
cls
echo ------------------------------------------------
echo                Compresor de videos
echo ------------------------------------------------
echo Pon el video en la misma carpeta del ejecutable
echo.
echo Ingresar: (Nombre.mp4)
set /p input=Introduce el nombre del archivo: 
echo.
echo ¿A qué resolucion quieres optimizar el video?
echo.
echo Resolucion      Ancho x Alto      Bitrate (kbps)    Calidad
echo 480p  (SD)      854 x 480        600  - 1000      Media
echo 720p  (HD)      1280 x 720       1000 - 2500      Buena
echo 1080p (Full HD) 1920 x 1080      2500 - 6000      Muy buena
echo 1440p (2K)      2560 x 1440      6000 - 10000     Excelente
echo 2160p (4K)      3840 x 2160      15000 - 50000    Excelente
echo.
set /p bitrate=Introduce el bitrate deseado (min. 1000k): 
echo.
echo Niveles de compresión (CRF):
echo 0%   = 0   (Sin pérdida)
echo 20%  = 23
echo 40%  = 28
echo 60%  = 30
echo 80%  = 35
echo 100% = 51  (Calidad muy baja)
echo.
set /p crf=Introduce el nivel de compresión (0 - 51): 
set output=rev_%input%
echo.
echo Comenzando el proceso de compresión...
ffmpeg.exe -i %input% -b:v %bitrate%k -vcodec libx264 -preset slow -crf %crf% -acodec aac -strict -2 %output%
echo.
echo Proceso finalizado.
pause
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
:vid_txt_vid
cls
setlocal

set FFmpegPath=ffmpeg.exe
set "outputDir=C:\Video procesos"
set "base64File=%outputDir%\As.txt"
set "nuevoVideo=%outputDir%\nuevo_video.mp4"

if not exist "%outputDir%" (
    mkdir "%outputDir%"
)

set "scriptDir=%~dp0"
echo Primero selecciona la pocion 1 para crear la carpeta en disco local C
echo despues elimina el As.txt que genera y ejecuta la opcion 1
echo Dirigete a ( C:\Video procesos )
echo ...
echo Ingresa 1 para convertir el archivo As.txt.
echo Ingresa 2 para ingresar el nombre del video.
echo .
echo Ingresa 0 para regresar
set /p "Txt_conv_1=Opción: "
if "%Txt_conv_1%"=="1" goto vid_txt_vid_op1
if "%Txt_conv_1%"=="2" goto vid_txt_vid_op2
if "%Txt_conv_1%"=="0" goto Base


:vid_txt_vid_op2
set /p "nombreVideo=Ingresa el nombre del video (sin extensión): "
if not exist "%scriptDir%%nombreVideo%.mp4" (
    echo Error: El archivo "%nombreVideo%.mp4" no existe en el directorio del script.
    echo pulsa para regesar
    pause
    goto vid_txt_vid
)

if not exist "%base64File%" (
    echo Creando Base64 del video...
    powershell -Command "[Convert]::ToBase64String([IO.File]::ReadAllBytes('%scriptDir%%nombreVideo%.mp4'))" > "%base64File%"
    if errorlevel 1 (
        echo Error al crear el Base64 del video.
        echo pulsa para regresar
        pause
        goto vid_txt_vid
    ) else (
        echo Base64 creado como %base64File%.
    )
) else (
    echo El archivo %base64File% ya existe un archivo
    pause
    goto vid_txt_vid
)


:vid_txt_vid_op1
set "nombreVideo=Aa"
echo Revirtiendo Base64 a video...
powershell -Command "[IO.File]::WriteAllBytes('%nuevoVideo%', [Convert]::FromBase64String([IO.File]::ReadAllText('%base64File%'))) "
if errorlevel 1 (
    echo Error al convertir el Base64 de nuevo a video.
    goto vid_txt_vid
) else (
    echo Archivo de video creado desde Base64: %nuevoVideo%.
    echo.
    echo Se ha creado una carpeta en "%outputDir%" donde está el archivo "As.txt", que se ha convertido en "%nuevoVideo%".
    pause
    goto vid_txt_vid
)
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
:native_menu
cls
echo 
echo **********************************  Nativefier *************************************
echo.
echo 1 Instalar nativefier
echo 2 Ejecutar nativefier
echo.
echo 0 Regresar
echo.
set /p Native_op="Selecciona una opcion (1-2): "

if "%Native_op%"=="1" goto native_instalar
if "%Native_op%"=="2" goto native_run
if "%Native_op%"=="0" Base
goto native_menu

:native_instalar
cls
start node-v22.14.0-x64.msi
pause
npm install -g nativefier
goto native_menu

:native_run
cls
set /p Native_website="Introduce la URL del sitio web (por ejemplo: https://www.example.com): "
echo Creando la aplicación para %Native_website%...
nativefier "%Native_website%"
goto native_menu
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
:buscador_win
cls
setlocal enabledelayedexpansion
if not exist "%~dp0" (
    echo El directorio %~dp0 no existe.
    exit /b
)
set /p "elemento=Ingrese el tipo de archivo a buscar (ejemplo *.mp4, *.txt, *.mp3): "
echo Buscando "%elemento%" en el directorio "%~dp0" y sus subdirectorios...
set "encontrado=0"
for /r "%~dp0" %%f in (%elemento%) do (
    echo Encontrado: %%f
    set "encontrado=1"
)
if !encontrado! equ 0 (
    echo No se encontraron elementos "%elemento%" en el directorio "%~dp0".
)
pause
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
:menuss
cls
echo ================================================
echo Bienvenido al convertidor de audio con FFmpeg
echo ================================================
echo.
echo despues de convertir un archivo opnle nombre manualmente
echo Selecciona una de las siguientes opciones:
echo a. Validar un dato
echo 1. Convertir desde MP3
echo 2. Convertir desde OGG
echo 3. Convertir desde FLAC
echo 4. Convertir desde WAV
echo 5. Convertir desde AIFF
echo 6. Convertir desde ALAC - M4A
echo 7. Convertir desde AAC
echo 0. Regresar
set /p option=Elige una opción (1-7 o 0 para salir): 

if "%option%"=="a" goto validar_opcion
if "%option%"=="1" goto mp3_options
if "%option%"=="2" goto ogg_options
if "%option%"=="3" goto flac_options
if "%option%"=="4" goto wav_options
if "%option%"=="5" goto aiff_options
if "%option%"=="6" goto alac_options
if "%option%"=="7" goto aac_options
if "%option%"=="0" goto Base
echo Opción no válida. Regresando al menú...
pause
goto menuss

:validar_opcion
@echo off
echo ================================================
echo Buscar archivo en el directorio actual
echo ================================================
echo Ingresa el nombre del archivo (sin la extensión): 
set /p file= 
for %%f in (%file%.*) do (
    echo Archivo encontrado: %%f
)

pause
goto menuss
:: --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:mp3_options
cls
echo ================================================
echo Convertir desde MP3
echo ================================================
echo 1. Convertir MP3 a WAV
echo 2. Convertir MP3 a OGG
echo 3. Convertir MP3 a FLAC
echo 4. Convertir MP3 a AAC
echo 5. Convertir MP3 a AIFF
echo 6. Convertir MP3 a ALAC
echo 0. Regresar
set /p option=Selecciona el formato de salida (1-6 o 0 para regresar): 

if "%option%"=="1" goto convert_mp3_to_wav
if "%option%"=="2" goto convert_mp3_to_ogg
if "%option%"=="3" goto convert_mp3_to_flac
if "%option%"=="4" goto convert_mp3_to_aac
if "%option%"=="5" goto convert_mp3_to_aiff
if "%option%"=="6" goto convert_mp3_to_alac
if "%option%"=="0" goto menuss
echo Opción no válida. Regresando a opciones de MP3...
pause
goto mp3_options

:convert_mp3_to_wav
echo Ingresa el nombre del archivo MP3 (sin la extensión .mp3):
set /p file= 
ffmpeg -i "%file%.mp3" "%~dpn1.wav"
echo Conversión a WAV completada: "%~dpn1.wav"
pause
goto mp3_options

:convert_mp3_to_ogg
echo Ingresa el nombre del archivo MP3 (sin la extensión .mp3):
set /p file= 
ffmpeg -i "%file%.mp3" "%~dpn1.ogg"
echo Conversión a OGG completada: "%~dpn1.ogg"
pause
goto mp3_options

:convert_mp3_to_flac
echo Ingresa el nombre del archivo MP3 (sin la extensión .mp3):
set /p file= 
ffmpeg -i "%file%.mp3" "%~dpn1.flac"
echo Conversión a FLAC completada: "%~dpn1.flac"
pause
goto mp3_options

:convert_mp3_to_aac
echo Ingresa el nombre del archivo MP3 (sin la extensión .mp3):
set /p file= 
ffmpeg -i "%file%.mp3" "%~dpn1.aac"
echo Conversión a AAC completada: "%~dpn1.aac"
pause
goto mp3_options

:convert_mp3_to_aiff
echo Ingresa el nombre del archivo MP3 (sin la extensión .mp3):
set /p file= 
ffmpeg -i "%file%.mp3" "%~dpn1.aiff"
echo Conversión a AIFF completada: "%~dpn1.aiff"
pause
goto mp3_options

:convert_mp3_to_alac
echo Ingresa el nombre del archivo MP3 (sin la extensión .mp3):
set /p file= 
ffmpeg -i "%file%.mp3" "%~dpn1.m4a"
echo Conversión a ALAC completada: "%~dpn1.m4a"
pause
goto mp3_options
:: --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:ogg_options
cls
echo ================================================
echo Convertir desde OGG
echo ================================================
echo 1. Convertir OGG a MP3
echo 2. Convertir OGG a WAV
echo 3. Convertir OGG a FLAC
echo 4. Convertir OGG a AAC
echo 5. Convertir OGG a AIFF
echo 6. Convertir OGG a ALAC
echo 0. Regresar
set /p option=Selecciona el formato de salida (1-6 o 0 para regresar): 

if "%option%"=="1" goto convert_ogg_to_mp3
if "%option%"=="2" goto convert_ogg_to_wav
if "%option%"=="3" goto convert_ogg_to_flac
if "%option%"=="4" goto convert_ogg_to_aac
if "%option%"=="5" goto convert_ogg_to_aiff
if "%option%"=="6" goto convert_ogg_to_alac
if "%option%"=="0" goto menuss
echo Opción no válida. Regresando a opciones de OGG...
pause
goto ogg_options

:convert_ogg_to_mp3
echo Ingresa el nombre del archivo OGG (sin la extensión .ogg):
set /p file= 
ffmpeg -i "%file%.ogg" "%~dpn1.mp3"
echo Conversión a MP3 completada: "%~dpn1.mp3"
pause
goto ogg_options

:convert_ogg_to_wav
echo Ingresa el nombre del archivo OGG (sin la extensión .ogg):
set /p file= 
ffmpeg -i "%file%.ogg" "%~dpn1.wav"
echo Conversión a WAV completada: "%~dpn1.wav"
pause
goto ogg_options

:convert_ogg_to_flac
echo Ingresa el nombre del archivo OGG (sin la extensión .ogg):
set /p file= 
ffmpeg -i "%file%.ogg" "%~dpn1.flac"
echo Conversión a FLAC completada: "%~dpn1.flac"
pause
goto ogg_options

:convert_ogg_to_aac
echo Ingresa el nombre del archivo OGG (sin la extensión .ogg):
set /p file= 
ffmpeg -i "%file%.ogg" "%~dpn1.aac"
echo Conversión a AAC completada: "%~dpn1.aac"
pause
goto ogg_options

:convert_ogg_to_aiff
echo Ingresa el nombre del archivo OGG (sin la extensión .ogg):
set /p file= 
ffmpeg -i "%file%.ogg" "%~dpn1.aiff"
echo Conversión a AIFF completada: "%~dpn1.aiff"
pause
goto ogg_options

:convert_ogg_to_alac
echo Ingresa el nombre del archivo OGG (sin la extensión .ogg):
set /p file= 
ffmpeg -i "%file%.ogg" "%~dpn1.m4a"
echo Conversión a ALAC completada: "%~dpn1.m4a"
pause
goto ogg_options
:: --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:flac_options
cls
echo ================================================
echo Convertir desde FLAC
echo ================================================
echo 1. Convertir FLAC a MP3
echo 2. Convertir FLAC a WAV
echo 3. Convertir FLAC a OGG
echo 4. Convertir FLAC a AAC
echo 5. Convertir FLAC a AIFF
echo 6. Convertir FLAC a ALAC
echo 0. Regresar
set /p option=Selecciona el formato de salida (1-6 o 0 para regresar): 

if "%option%"=="1" goto convert_flac_to_mp3
if "%option%"=="2" goto convert_flac_to_wav
if "%option%"=="3" goto convert_flac_to_ogg
if "%option%"=="4" goto convert_flac_to_aac
if "%option%"=="5" goto convert_flac_to_aiff
if "%option%"=="6" goto convert_flac_to_alac
if "%option%"=="0" goto menuss
echo Opción no válida. Regresando a opciones de FLAC...
pause
goto flac_options

:convert_flac_to_mp3
echo Ingresa el nombre del archivo FLAC (sin la extensión .flac):
set /p file= 
ffmpeg -i "%file%.flac" "%~dpn1.mp3"
echo Conversión a MP3 completada: "%~dpn1.mp3"
pause
goto flac_options

:convert_flac_to_wav
echo Ingresa el nombre del archivo FLAC (sin la extensión .flac):
set /p file= 
ffmpeg -i "%file%.flac" "%~dpn1.wav"
echo Conversión a WAV completada: "%~dpn1.wav"
pause
goto flac_options

:convert_flac_to_ogg
echo Ingresa el nombre del archivo FLAC (sin la extensión .flac):
set /p file= 
ffmpeg -i "%file%.flac" "%~dpn1.ogg"
echo Conversión a OGG completada: "%~dpn1.ogg"
pause
goto flac_options

:convert_flac_to_aac
echo Ingresa el nombre del archivo FLAC (sin la extensión .flac):
set /p file= 
ffmpeg -i "%file%.flac" "%~dpn1.aac"
echo Conversión a AAC completada: "%~dpn1.aac"
pause
goto flac_options

:convert_flac_to_aiff
echo Ingresa el nombre del archivo FLAC (sin la extensión .flac):
set /p file= 
ffmpeg -i "%file%.flac" "%~dpn1.aiff"
echo Conversión a AIFF completada: "%~dpn1.aiff"
pause
goto flac_options

:convert_flac_to_alac
echo Ingresa el nombre del archivo FLAC (sin la extensión .flac):
set /p file= 
ffmpeg -i "%file%.flac" "%~dpn1.m4a"
echo Conversión a ALAC completada: "%~dpn1.m4a"
pause
goto flac_options
:: --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:wav_options
cls
echo ================================================
echo Convertir desde WAV
echo ================================================
echo 1. Convertir WAV a MP3
echo 2. Convertir WAV a OGG
echo 3. Convertir WAV a FLAC
echo 4. Convertir WAV a AAC
echo 5. Convertir WAV a AIFF
echo 6. Convertir WAV a ALAC
echo 0. Regresar
set /p option=Selecciona el formato de salida (1-6 o 0 para regresar): 

if "%option%"=="1" goto convert_wav_to_mp3
if "%option%"=="2" goto convert_wav_to_ogg
if "%option%"=="3" goto convert_wav_to_flac
if "%option%"=="4" goto convert_wav_to_aac
if "%option%"=="5" goto convert_wav_to_aiff
if "%option%"=="6" goto convert_wav_to_alac
if "%option%"=="0" goto menuss
echo Opción no válida. Regresando a opciones de WAV...
pause
goto wav_options

:convert_wav_to_mp3
echo Ingresa el nombre del archivo WAV (sin la extensión .wav):
set /p file= 
ffmpeg -i "%file%.wav" "%~dpn1.mp3"
echo Conversión a MP3 completada: "%~dpn1.mp3"
pause
goto wav_options

:convert_wav_to_ogg
echo Ingresa el nombre del archivo WAV (sin la extensión .wav):
set /p file= 
ffmpeg -i "%file%.wav" "%~dpn1.ogg"
echo Conversión a OGG completada: "%~dpn1.ogg"
pause
goto wav_options

:convert_wav_to_flac
echo Ingresa el nombre del archivo WAV (sin la extensión .wav):
set /p file= 
ffmpeg -i "%file%.wav" "%~dpn1.flac"
echo Conversión a FLAC completada: "%~dpn1.flac"
pause
goto wav_options

:convert_wav_to_aac
echo Ingresa el nombre del archivo WAV (sin la extensión .wav):
set /p file= 
ffmpeg -i "%file%.wav" "%~dpn1.aac"
echo Conversión a AAC completada: "%~dpn1.aac"
pause
goto wav_options

:convert_wav_to_aiff
echo Ingresa el nombre del archivo WAV (sin la extensión .wav):
set /p file= 
ffmpeg -i "%file%.wav" "%~dpn1.aiff"
echo Conversión a AIFF completada: "%~dpn1.aiff"
pause
goto wav_options

:convert_wav_to_alac
echo Ingresa el nombre del archivo WAV (sin la extensión .wav):
set /p file= 
ffmpeg -i "%file%.wav" "%~dpn1.m4a"
echo Conversión a ALAC completada: "%~dpn1.m4a"
pause
goto wav_options
:: --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:aiff_options
cls
echo ================================================
echo Convertir desde AIFF
echo ================================================
echo 1. Convertir AIFF a MP3
echo 2. Convertir AIFF a OGG
echo 3. Convertir AIFF a FLAC
echo 4. Convertir AIFF a AAC
echo 5. Convertir AIFF a WAV
echo 6. Convertir AIFF a ALAC
echo 0. Regresar
set /p option=Selecciona el formato de salida (1-6 o 0 para regresar): 

if "%option%"=="1" goto convert_aiff_to_mp3
if "%option%"=="2" goto convert_aiff_to_ogg
if "%option%"=="3" goto convert_aiff_to_flac
if "%option%"=="4" goto convert_aiff_to_aac
if "%option%"=="5" goto convert_aiff_to_wav
if "%option%"=="6" goto convert_aiff_to_alac
if "%option%"=="0" goto menuss
echo Opción no válida. Regresando a opciones de AIFF...
pause
goto aiff_options

:convert_aiff_to_mp3
echo Ingresa el nombre del archivo AIFF (sin la extensión .aiff):
set /p file= 
ffmpeg -i "%file%.aiff" "%~dpn1.mp3"
echo Conversión a MP3 completada: "%~dpn1.mp3"
pause
goto aiff_options

:convert_aiff_to_ogg
echo Ingresa el nombre del archivo AIFF (sin la extensión .aiff):
set /p file= 
ffmpeg -i "%file%.aiff" "%~dpn1.ogg"
echo Conversión a OGG completada: "%~dpn1.ogg"
pause
goto aiff_options

:convert_aiff_to_flac
echo Ingresa el nombre del archivo AIFF (sin la extensión .aiff):
set /p file= 
ffmpeg -i "%file%.aiff" "%~dpn1.flac"
echo Conversión a FLAC completada: "%~dpn1.flac"
pause
goto aiff_options

:convert_aiff_to_aac
echo Ingresa el nombre del archivo AIFF (sin la extensión .aiff):
set /p file= 
ffmpeg -i "%file%.aiff" "%~dpn1.aac"
echo Conversión a AAC completada: "%~dpn1.aac"
pause
goto aiff_options

:convert_aiff_to_wav
echo Ingresa el nombre del archivo AIFF (sin la extensión .aiff):
set /p file= 
ffmpeg -i "%file%.aiff" "%~dpn1.wav"
echo Conversión a WAV completada: "%~dpn1.wav"
pause
goto aiff_options

:convert_aiff_to_alac
echo Ingresa el nombre del archivo AIFF (sin la extensión .aiff):
set /p file= 
ffmpeg -i "%file%.aiff" "%~dpn1.m4a"
echo Conversión a ALAC completada: "%~dpn1.m4a"
pause
goto aiff_options
:: --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:alac_options
cls
echo ================================================
echo Convertir desde ALAC
echo ================================================
echo 1. Convertir ALAC a MP3
echo 2. Convertir ALAC a OGG
echo 3. Convertir ALAC a FLAC
echo 4. Convertir ALAC a AAC
echo 5. Convertir ALAC a WAV
echo 6. Convertir ALAC a AIFF
echo 0. Regresar
set /p option=Selecciona el formato de salida (1-6 o 0 para regresar): 

if "%option%"=="1" goto convert_alac_to_mp3
if "%option%"=="2" goto convert_alac_to_ogg
if "%option%"=="3" goto convert_alac_to_flac
if "%option%"=="4" goto convert_alac_to_aac
if "%option%"=="5" goto convert_alac_to_wav
if "%option%"=="6" goto convert_alac_to_aiff
if "%option%"=="0" goto menuss
echo Opción no válida. Regresando a opciones de ALAC...
pause
goto alac_options

:convert_alac_to_mp3
echo Ingresa el nombre del archivo ALAC (sin la extensión .m4a):
set /p file= 
ffmpeg -i "%file%.m4a" "%~dpn1.mp3"
echo Conversión a MP3 completada: "%~dpn1.mp3"
pause
goto alac_options

:convert_alac_to_ogg
echo Ingresa el nombre del archivo ALAC (sin la extensión .m4a):
set /p file= 
ffmpeg -i "%file%.m4a" "%~dpn1.ogg"
echo Conversión a OGG completada: "%~dpn1.ogg"
pause
goto alac_options

:convert_alac_to_flac
echo Ingresa el nombre del archivo ALAC (sin la extensión .m4a):
set /p file= 
ffmpeg -i "%file%.m4a" "%~dpn1.flac"
echo Conversión a FLAC completada: "%~dpn1.flac"
pause
goto alac_options

:convert_alac_to_aac
echo Ingresa el nombre del archivo ALAC (sin la extensión .m4a):
set /p file= 
ffmpeg -i "%file%.m4a" "%~dpn1.aac"
echo Conversión a AAC completada: "%~dpn1.aac"
pause
goto alac_options

:convert_alac_to_wav
echo Ingresa el nombre del archivo ALAC (sin la extensión .m4a):
set /p file= 
ffmpeg -i "%file%.m4a" "%~dpn1.wav"
echo Conversión a WAV completada: "%~dpn1.wav"
pause
goto alac_options

:convert_alac_to_aiff
echo Ingresa el nombre del archivo ALAC (sin la extensión .m4a):
set /p file= 
ffmpeg -i "%file%.m4a" "%~dpn1.aiff"
echo Conversión a AIFF completada: "%~dpn1.aiff"
pause
goto alac_options
:: --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:aac_options
cls
echo ================================================
echo Convertir desde AAC
echo ================================================
echo 1. Convertir AAC a MP3
echo 2. Convertir AAC a OGG
echo 3. Convertir AAC a FLAC
echo 4. Convertir AAC a WAV
echo 5. Convertir AAC a AIFF
echo 6. Convertir AAC a ALAC
echo 0. Regresar
set /p option=Selecciona el formato de salida (1-6 o 0 para regresar): 

if "%option%"=="1" goto convert_aac_to_mp3
if "%option%"=="2" goto convert_aac_to_ogg
if "%option%"=="3" goto convert_aac_to_flac
if "%option%"=="4" goto convert_aac_to_wav
if "%option%"=="5" goto convert_aac_to_aiff
if "%option%"=="6" goto convert_aac_to_alac
if "%option%"=="0" goto menuss
echo Opción no válida. Regresando a opciones de AAC...
pause
goto aac_options

:convert_aac_to_mp3
echo Ingresa el nombre del archivo AAC (sin la extensión .aac):
set /p file= 
ffmpeg -i "%file%.aac" "%~dpn1.mp3"
echo Conversión a MP3 completada: "%~dpn1.mp3"
pause
goto aac_options

:convert_aac_to_ogg
echo Ingresa el nombre del archivo AAC (sin la extensión .aac):
set /p file= 
ffmpeg -i "%file%.aac" "%~dpn1.ogg"
echo Conversión a OGG completada: "%~dpn1.ogg"
pause
goto aac_options

:convert_aac_to_flac
echo Ingresa el nombre del archivo AAC (sin la extensión .aac):
set /p file= 
ffmpeg -i "%file%.aac" "%~dpn1.flac"
echo Conversión a FLAC completada: "%~dpn1.flac"
pause
goto aac_options

:convert_aac_to_wav
echo Ingresa el nombre del archivo AAC (sin la extensión .aac):
set /p file= 
ffmpeg -i "%file%.aac" "%~dpn1.wav"
echo Conversión a WAV completada: "%~dpn1.wav"
pause
goto aac_options

:convert_aac_to_aiff
echo Ingresa el nombre del archivo AAC (sin la extensión .aac):
set /p file= 
ffmpeg -i "%file%.aac" "%~dpn1.aiff"
echo Conversión a AIFF completada: "%~dpn1.aiff"
pause
goto aac_options

:convert_aac_to_alac
echo Ingresa el nombre del archivo AAC (sin la extensión .aac):
set /p file= 
ffmpeg -i "%file%.aac" "%~dpn1.m4a"
echo Conversión a ALAC completada: "%~dpn1.m4a"
pause
goto aac_options
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
:video_tamaño
cls
setlocal enabledelayedexpansion
echo Nombre del archivo (ej: video.mp4):
set /p nombre=
echo Peso final deseado (en MB):
set /p pesodeseado=

set /a pesodeseado_bytes=%pesodeseado%*1024*1024
for /f "tokens=*" %%a in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 "%nombre%"') do set duracion=%%a
echo Duracion: %duracion% segundos

set crf=28
set audio_bitrate=128k
set scale=1280:-2
set intento=1

:compresion_tamaño
echo === Compresion intento %intento% ===

ffmpeg -y -i "%nombre%" -vcodec libx264 -preset fast -crf %crf% -acodec aac -b:a %audio_bitrate% -vf scale=%scale% "compressed_%nombre%"
for %%F in ("compressed_%nombre%") do set /a peso=%%~zF
echo Peso resultante: !peso! bytes

if !peso! LEQ %pesodeseado_bytes% (
    echo Compresion exitosa.
    Pause
    goto Base
)

rem Si no cumple, reducimos calidad
set /a intento+=1
if !intento! GTR 10 (
    echo No se pudo comprimir al peso deseado tras 10 intentos.
    Pause
    goto Base
)

rem Reducimos parámetros progresivamente
if !crf! LSS 35 (
    set /a crf+=2
) else (
    if "!audio_bitrate!"=="128k" (
        set audio_bitrate=96k
    ) else if "!audio_bitrate!"=="96k" (
        set audio_bitrate=64k
    ) else if "!audio_bitrate!"=="64k" (
        set audio_bitrate=32k
    ) else (
        rem Si ya bajamos audio al mínimo, reducimos resolución
        if "!scale!"=="1280:-2" (
            set scale=854:-2
        ) else if "!scale!"=="854:-2" (
            set scale=640:-2
        ) else (
            set scale=480:-2
        )
    )
)
goto compresion_tamaño
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
:licencia_view
cls
wmic path softwarelicensingservice get OA3xOriginalProductKey
Pause
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
:telemetria_win_11
cls
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    color 4
    echo This script requires administrator privileges.
    echo Please run WinScript as an administrator.
    pause
    exit /b 1
)
setlocal EnableExtensions DisableDelayedExpansion
echo -- Disabling CCleaner telemetry
reg add "HKCU\Software\Piriform\CCleaner" /v "Monitoring" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Piriform\CCleaner" /v "HelpImproveCCleaner" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Piriform\CCleaner" /v "SystemMonitoring" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Piriform\CCleaner" /v "UpdateAuto" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Piriform\CCleaner" /v "UpdateCheck" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Piriform\CCleaner" /v "CheckTrialOffer" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Piriform\CCleaner" /v "(Cfg)HealthCheck" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Piriform\CCleaner" /v "(Cfg)QuickClean" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Piriform\CCleaner" /v "(Cfg)QuickCleanIpm" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Piriform\CCleaner" /v "(Cfg)GetIpmForTrial" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Piriform\CCleaner" /v "(Cfg)SoftwareUpdater" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Piriform\CCleaner" /v "(Cfg)SoftwareUpdaterIpm" /t REG_DWORD /d 0 /f
echo -- Disabling PowerShell telemetry
setx POWERSHELL_TELEMETRY_OPTOUT 1
echo -- Disabling Media Player telemetry
reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Policies\Microsoft\WindowsMediaPlayer" /v "PreventCDDVDMetadataRetrieval" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\WindowsMediaPlayer" /v "PreventMusicFileMetadataRetrieval" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\WindowsMediaPlayer" /v "PreventRadioPresetsRetrieval" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\WMDRM" /v "DisableOnline" /t REG_DWORD /d 1 /f
echo -- Disabling Visual Studio telemetry
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\VSCommon\14.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\VSCommon\15.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\VSCommon\16.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\VSCommon\17.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\VisualStudio\SQM" /v "OptIn" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\VisualStudio\Telemetry" /v "TurnOffSwitch" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\VisualStudio\Feedback" /v "DisableFeedbackDialog" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\VisualStudio\Feedback" /v "DisableEmailInput" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\VisualStudio\Feedback" /v "DisableScreenshotCapture" /t REG_DWORD /d 1 /f
reg delete "HKLM\Software\Microsoft\VisualStudio\DiagnosticsHub" /v "LogLevel" /f 2>nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\VisualStudio\IntelliCode" /v "DisableRemoteAnalysis" /t "REG_DWORD" /d "1" /f
reg add "HKCU\SOFTWARE\Microsoft\VSCommon\16.0\IntelliCode" /v "DisableRemoteAnalysis" /t "REG_DWORD" /d "1" /f
reg add "HKCU\SOFTWARE\Microsoft\VSCommon\17.0\IntelliCode" /v "DisableRemoteAnalysis" /t "REG_DWORD" /d "1" /f
echo -- Disabling NVIDIA telemetry
reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID44231" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID64640" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID66610" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup" /v "SendTelemetryData" /t REG_DWORD /d 0 /f
schtasks /change /TN NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8} /DISABLE
schtasks /change /TN NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8} /DISABLE
schtasks /change /TN NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8} /DISABLE
echo -- Opting out of privacy consent
reg add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d 0 /f
echo -- Disabling Targeted Ads and Data Collection
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d "1" /f
reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightFeatures" /t "REG_DWORD" /d "1" /f
reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t "REG_DWORD" /d "1" /f
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableTailoredExperiencesWithDiagnosticData" /t "REG_DWORD" /d "1" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /d "0" /t REG_DWORD /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /d "0" /t REG_DWORD /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /d "0" /t REG_DWORD /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /d "0" /t REG_DWORD /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /d "0" /t REG_DWORD /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /d "0" /t REG_DWORD /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /d "0" /t REG_DWORD /f
echo -- Disabling Clipboard history and Cloud Clipboard
reg add "HKCU\Software\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "AllowInputPersonalization" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "AllowCrossDeviceClipboard" /t "REG_DWORD" /d "0" /f
reg add "HKCU\Software\Microsoft\Clipboard" /v "CloudClipboardAutomaticUpload" /t "REG_DWORD" /d "0" /f
reg add "HKCU\Software\Microsoft\Clipboard" /v "EnableClipboardHistory" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "AllowClipboardHistory" /t "REG_DWORD" /d "0" /f
echo -- Disabling Handwriting telemetry
reg add "HKCU\Software\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "AllowInputPersonalization" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d 0 /f
echo -- Disabling Windows Feedback Experience telemetry
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f
echo -- Disabling Application Experience telemetry
schtasks /change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /DISABLE
schtasks /change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser Exp" /DISABLE
schtasks /change /TN "\Microsoft\Windows\Application Experience\StartupAppTask" /DISABLE
schtasks /change /TN "\Microsoft\Windows\Application Experience\PcaPatchDbTask" /DISABLE
schtasks /change /TN "\Microsoft\Windows\Application Experience\MareBackup" /DISABLE
echo -- Disabling Office telemetry
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail" /v "EnableLogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail" /v "EnableLogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar" /v "EnableCalendarLogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar" /v "EnableCalendarLogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Word\Options" /v "EnableLogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Word\Options" /v "EnableLogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" /v "EnableLogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" /v "EnableLogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" /v "EnableUpload" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" /v "EnableUpload" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" /v "DisableTelemetry" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" /v "DisableTelemetry" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" /v "VerboseLogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" /v "VerboseLogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Common" /v "QMEnable" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common" /v "QMEnable" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Common\Feedback" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\Feedback" /v "Enabled" /t REG_DWORD /d 0 /f
schtasks /change /TN "\Microsoft\Office\OfficeTelemetryAgentFallBack" /DISABLE > NUL 2>&1
schtasks /change /TN "\Microsoft\Office\OfficeTelemetryAgentLogOn" /DISABLE > NUL 2>&1
schtasks /change /TN "\Microsoft\Office\OfficeTelemetryAgentFallBack2016" /DISABLE > NUL 2>&1
schtasks /change /TN "\Microsoft\Office\OfficeTelemetryAgentLogOn2016" /DISABLE > NUL 2>&1
schtasks /change /TN "\Microsoft\Office\Office 15 Subscription Heartbeat" /DISABLE > NUL 2>&1
schtasks /change /TN "\Microsoft\Office\Office 16 Subscription Heartbeat" /DISABLE > NUL 2>&1
echo -- Disabling Windows Search Telemetry
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchPrivacy" /t REG_DWORD /d "3" /f
reg add "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchHistory" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t "REG_DWORD" /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "EnableDynamicContentInWSB" /t "REG_DWORD" /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t "REG_DWORD" /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t "REG_DWORD" /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t "REG_DWORD" /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "PreventUnwantedAddIns" /t "REG_SZ" /d " " /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "PreventRemoteQueries" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AlwaysUseAutoLangDetection" /t "REG_DWORD" /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowIndexingEncryptedStoresOrItems" /t "REG_DWORD" /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "DisableSearchBoxSuggestions" /t "REG_DWORD" /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaInAmbientMode" /t "REG_DWORD" /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t "REG_DWORD" /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCortanaButton" /t "REG_DWORD" /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CanCortanaBeEnabled" /t "REG_DWORD" /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t "REG_DWORD" /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaAboveLock" /t "REG_DWORD" /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDynamicSearchBoxEnabled" /t "REG_DWORD" /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowCortana" /v "value" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "AllowSearchToUseLocation" /t "REG_DWORD" /d "1" /f
reg add "HKCU\Software\Microsoft\Speech_OneCore\Preferences" /v "ModelDownloadAllowed" /t "REG_DWORD" /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDeviceSearchHistoryEnabled" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Speech_OneCore\Preferences" /v "VoiceActivationOn" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Speech_OneCore\Preferences" /v "VoiceActivationEnableAboveLockscreen" /t "REG_DWORD" /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "DisableVoice" /t "REG_DWORD" /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t "REG_DWORD" /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "DeviceHistoryEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "HistoryViewEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Speech_OneCore\Preferences" /v "VoiceActivationDefaultOn" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t "REG_DWORD" /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t "REG_DWORD" /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsMSACloudSearchEnabled" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsAADCloudSearchEnabled" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /t "REG_DWORD" /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "VoiceShortcut" /t "REG_DWORD" /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t "REG_DWORD" /d "0" /f
echo -- Disabling Windows Update Telemetry
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t "REG_DWORD" /d 0 /f
echo -- Disabling Windows Telemetry
schtasks /change /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /DISABLE > NUL 2>&1
schtasks /change /TN "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /DISABLE > NUL 2>&1
schtasks /change /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /DISABLE > NUL 2>&1
schtasks /change /TN "\Microsoft\Windows\Autochk\Proxy" /DISABLE > NUL 2>&1
schtasks /change /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /DISABLE > NUL 2>&1
schtasks /change /TN "\Microsoft\Windows\Feedback\Siuf\DmClient" /DISABLE > NUL 2>&1
schtasks /change /TN "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /DISABLE > NUL 2>&1
schtasks /change /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /DISABLE > NUL 2>&1
schtasks /change /TN "\Microsoft\Windows\Maps\MapsUpdateTask" /DISABLE > NUL 2>&1
sc config diagnosticshub.standardcollector.service start=demand
sc config diagsvc start=demand
sc config WerSvc start=demand
sc config wercplsupport start=demand
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowDesktopAnalyticsProcessing" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowDeviceNameInTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "MicrosoftEdgeDataOptIn" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowWUfBCloudProcessing" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowUpdateComplianceProcessing" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowCommercialDataPipeline" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v "DisableOneSettingsDownloads" /t "REG_DWORD" /d "1" /f
reg add "HKLM\Software\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" /v "NoGenTicket" /t "REG_DWORD" /d "1" /f
reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t "REG_DWORD" /d "1" /f
reg add "HKLM\Software\Microsoft\Windows\Windows Error Reporting\Consent" /v "DefaultConsent" /t REG_DWORD /d "0" /f
reg add "HKLM\Software\Microsoft\Windows\Windows Error Reporting\Consent" /v "DefaultOverrideBehavior" /t REG_DWORD /d "1" /f
reg add "HKLM\Software\Microsoft\Windows\Windows Error Reporting" /v "DontSendAdditionalData" /t REG_DWORD /d "1" /f
reg add "HKLM\Software\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d "1" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /d "0" /t REG_DWORD /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /d "0" /t REG_DWORD /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /d "0" /t REG_DWORD /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /d "0" /t REG_DWORD /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /d "0" /t REG_DWORD /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /d "0" /t REG_DWORD /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\SystemSettings\AccountNotifications" /v "EnableAccountNotifications" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SystemSettings\AccountNotifications" /v "EnableAccountNotifications" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_TOASTS_ENABLED" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Policies\Microsoft\Windows\EdgeUI" /v "DisableMFUTracking" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" /v "DisableMFUTracking" /t REG_DWORD /d "1" /f
reg add "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d "0" /f
pause
endlocal
taskkill /f /im explorer.exe & start explorer & exit /b 0
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
:privacidad_win_11
cls
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    color 4
    echo This script requires administrator privileges.
    echo Please run WinScript as an administrator.
    pause
    exit /b 1
)
setlocal EnableExtensions DisableDelayedExpansion
echo -- Disabling Biometrics (Breaks Windows Hello)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Biometrics" /v "Enabled" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Biometrics\Credential Provider" /v "Enabled" /t "REG_DWORD" /d "0" /f
echo -- Disabling Auto Map Downloads
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Maps" /v "AllowUntriggeredNetworkTrafficOnSettingsPage" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Maps" /v "AutoDownloadAndUpdateMapData" /t REG_DWORD /d 0 /f
echo -- Disabling Cloud Sync
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSyncOnPaidNetwork" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t REG_DWORD /d 5 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSync" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSyncUserOverride" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSync" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSyncUserOverride" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSync" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSyncUserOverride" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSync" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSyncUserOverride" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSync" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSyncUserOverride" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSync" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSyncUserOverride" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSync" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSyncUserOverride" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSync" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSyncUserOverride" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSync" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSyncUserOverride" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /t REG_DWORD /v "Enabled" /d 0 /f
pause
endlocal
taskkill /f /im explorer.exe & start explorer & exit /b 0
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
:blodware_win_11
cls
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    color 4
    echo This script requires administrator privileges.
    echo Please run WinScript as an administrator.
    pause
    exit /b 1
)

echo -----------------------------------------------
echo    Bienvenido al Menú de Opciones de Windows 11
echo -----------------------------------------------
echo 1. Desinstalar OneDrive
echo 2. Desinstalar Microsoft Edge
echo 3. Desinstalar Widgets
echo 4. Desinstalar Microsoft Store
echo 5. Desinstalar Xbox Apps
echo 6. Desinstalar Extensiones
echo 7. Desinstalar Microsoft Apps
echo 8. Desinstalar Apps de terceros
echo 9. Desactivar Widgets de la Barra de Tareas
echo 10. Remover Copilot
echo 0 regresar
echo -----------------------------------------------
set /p blodware_op="Seleccione una opción (1-11): "

:: Validar la opción seleccionada
if "%blodware_op%"=="1" goto blodware_op_1
if "%blodware_op%"=="2" goto blodware_op_2
if "%blodware_op%"=="3" goto blodware_op_3
if "%blodware_op%"=="4" goto blodware_op_4
if "%blodware_op%"=="5" goto blodware_op_5
if "%blodware_op%"=="6" goto blodware_op_6
if "%blodware_op%"=="7" goto blodware_op_7
if "%blodware_op%"=="8" goto blodware_op_8
if "%blodware_op%"=="9" goto blodware_op_9
if "%blodware_op%"=="10" goto blodware_op_10
if "%blodware_op%"=="0" goto Base
goto blodware_win_11

:blodware_op_1
setlocal EnableExtensions DisableDelayedExpansion
echo -- Killing OneDrive Process
taskkill /f /im OneDrive.exe
echo -- Uninstalling OneDrive through the installers
if exist "%SystemRoot%\System32\OneDriveSetup.exe" (
    "%SystemRoot%\System32\OneDriveSetup.exe" /uninstall
)
if exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" (
    "%SystemRoot%\SysWOW64\OneDriveSetup.exe" /uninstall
)

echo -- Removing OneDrive registry keys
reg delete "HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
reg delete "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f

echo -- Removing OneDrive folders
rd "%UserProfile%\OneDrive" /Q /S
rd "%LocalAppData%\Microsoft\OneDrive" /Q /S
rd "%ProgramData%\Microsoft\OneDrive" /Q /S
rd "C:\OneDriveTemp" /Q /S
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeEnhanceImagesEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "PersonalizationReportingEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "ShowRecommendationsEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HideFirstRunExperience" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserFeedbackAllowed" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "ConfigureDoNotTrack" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "AlternateErrorPagesEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeCollectionsEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeFollowEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeShoppingAssistantEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "MicrosoftEdgeInsiderPromotionEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "ShowMicrosoftRewards" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "WebWidgetAllowed" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiagnosticData" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeAssetDeliveryServiceEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "CryptoWalletEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "WalletDonationEnabled" /t REG_DWORD /d 0 /f
pause
endlocal
taskkill /f /im explorer.exe & start explorer & exit /b 0

:blodware_op_2
setlocal EnableExtensions DisableDelayedExpansion
echo -- Uninstalling Edge
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdateDev" /v "AllowUninstall" /t REG_DWORD /d "1" /f
Powershell -ExecutionPolicy Unrestricted -Command "$installer = (Get-ChildItem \"$($env:ProgramFiles)*\Microsoft\Edge\Application\*\Installer\setup.exe\"); if (!$installer) { Write-Host \"Installer not found. Microsoft Edge may already be uninstalled.\"; } else { $installer | ForEach-Object { $uninstallerPath = $_.FullName; $installerArguments = @(\"--uninstall\", \"--system-level\", \"--verbose-logging\", \"--force-uninstall\"); Write-Output \"Uninstalling through uninstaller: $uninstallerPath\"; $process = Start-Process -FilePath \"$uninstallerPath\" -ArgumentList $installerArguments -Wait -PassThru; if ($process.ExitCode -eq 0 -or $process.ExitCode -eq 19) { Write-Host \"Successfully uninstalled Edge.\"; } else { Write-Error \"Failed to uninstall, uninstaller failed with exit code $($process.ExitCode).\"; }; }; }"
pause
endlocal
taskkill /f /im explorer.exe & start explorer & exit /b 0

:blodware_op_3
setlocal EnableExtensions DisableDelayedExpansion
echo -- Uninstalling Widgets
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t "REG_DWORD" /d "0" /f
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *WebExperience* | Remove-AppxPackage"
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned\MicrosoftWindows.Client.WebExperience_cw5n1h2txyewy" /f

echo -- Disabling Taskbar Widgets
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d 0 /f
pause
endlocal
taskkill /f /im explorer.exe & start explorer & exit /b 0

:blodware_op_4
setlocal EnableExtensions DisableDelayedExpansion
echo -- Uninstalling Microsoft Store
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "*Microsoft.WindowsStore*" | Remove-AppxPackage"
pause
endlocal
taskkill /f /im explorer.exe & start explorer & exit /b 0

:blodware_op_5
setlocal EnableExtensions DisableDelayedExpansion
echo -- Uninstalling Xbox apps
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.XboxApp" | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.Xbox.TCUI" | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.XboxGamingOverlay" | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.XboxGameOverlay" | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.XboxIdentityProvider" | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.XboxSpeechToTextOverlay" | Remove-AppxPackage"
pause
endlocal
taskkill /f /im explorer.exe & start explorer & exit /b 0

:blodware_op_6
setlocal EnableExtensions DisableDelayedExpansion
echo -- Uninstalling Extensions
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage \"Microsoft.HEIFImageExtension\" | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage \"Microsoft.VP9VideoExtensions\" | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage \"Microsoft.WebpImageExtension\" | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage \"Microsoft.HEVCVideoExtension\" | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage \"Microsoft.RawImageExtension\" | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage \"Microsoft.WebMediaExtensions\" | Remove-AppxPackage"
pause
endlocal
taskkill /f /im explorer.exe & start explorer & exit /b 0

:blodware_op_7
echo -- Uninstalling Microsoft apps
@echo off
cls
echo *** Blodware Removal Menu ***
echo 1   Remove MicrosoftFamily
echo 2   Remove OutlookForWindows
echo 3   Remove Clipchamp
echo 4   Remove 3DBuilder
echo 5   Remove Microsoft3DViewer
echo 6   Remove BingWeather
echo 7   Remove BingSports
echo 8   Remove BingFinance
echo 9   Remove MicrosoftOfficeHub
echo 10  Remove BingNews
echo 11  Remove OneNote
echo 12  Remove Sway
echo 13  Remove WindowsPhone
echo 14  Remove CommsPhone
echo 15  Remove YourPhone
echo 16  Remove Getstarted
echo 17  Remove Microsoft549981C3F5F10
echo 18  Remove Messaging
echo 19  Remove WindowsSoundRecorder
echo 20  Remove MixedRealityPortal
echo 21  Remove WindowsFeedbackHub
echo 22  Remove WindowsAlarms
echo 23  Remove WindowsCamera
echo 24  Remove MSPaint
echo 25  Remove WindowsMaps
echo 26  Remove MinecraftUWP
echo 27  Remove People
echo 28  Remove Wallet
echo 29  Remove Print3D
echo 30  Remove OneConnect
echo 31  Remove SolitaireCollection
echo 32  Remove StickyNotes
echo 33  Remove CommunicationsApps
echo 34  Remove SkypeApp
echo 35  Remove GroupMe10
echo 36  Remove Todos
echo .
echo 0 Regresar
echo Enter your choice (1-36):
set /p choice=
if "%choice%"=="0" blodware_win_11
if "%choice%"=="1" goto blodware_sub_op_1
if "%choice%"=="2" goto blodware_sub_op_2
if "%choice%"=="3" goto blodware_sub_op_3
if "%choice%"=="4" goto blodware_sub_op_4
if "%choice%"=="5" goto blodware_sub_op_5
if "%choice%"=="6" goto blodware_sub_op_6
if "%choice%"=="7" goto blodware_sub_op_7
if "%choice%"=="8" goto blodware_sub_op_8
if "%choice%"=="9" goto blodware_sub_op_9
if "%choice%"=="10" goto blodware_sub_op_10
if "%choice%"=="11" goto blodware_sub_op_11
if "%choice%"=="12" goto blodware_sub_op_12
if "%choice%"=="13" goto blodware_sub_op_13
if "%choice%"=="14" goto blodware_sub_op_14
if "%choice%"=="15" goto blodware_sub_op_15
if "%choice%"=="16" goto blodware_sub_op_16
if "%choice%"=="17" goto blodware_sub_op_17
if "%choice%"=="18" goto blodware_sub_op_18
if "%choice%"=="19" goto blodware_sub_op_19
if "%choice%"=="20" goto blodware_sub_op_20
if "%choice%"=="21" goto blodware_sub_op_21
if "%choice%"=="22" goto blodware_sub_op_22
if "%choice%"=="23" goto blodware_sub_op_23
if "%choice%"=="24" goto blodware_sub_op_24
if "%choice%"=="25" goto blodware_sub_op_25
if "%choice%"=="26" goto blodware_sub_op_26
if "%choice%"=="27" goto blodware_sub_op_27
if "%choice%"=="28" goto blodware_sub_op_28
if "%choice%"=="29" goto blodware_sub_op_29
if "%choice%"=="30" goto blodware_sub_op_30
if "%choice%"=="31" goto blodware_sub_op_31
if "%choice%"=="32" goto blodware_sub_op_32
if "%choice%"=="33" goto blodware_sub_op_33
if "%choice%"=="34" goto blodware_sub_op_34
if "%choice%"=="35" goto blodware_sub_op_35
if "%choice%"=="36" goto blodware_sub_op_36
goto end
:blodware_sub_op_1
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing MicrosoftFamily
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "MicrosoftCorporationII.MicrosoftFamily" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_2
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing OutlookForWindows
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.OutlookForWindows" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_3
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing Clipchamp
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Clipchamp.Clipchamp" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_4
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing 3DBuilder
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.3DBuilder" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_5
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing Microsoft3DViewer
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.Microsoft3DViewer" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_6
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing BingWeather
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.BingWeather" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_7
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing BingSports
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.BingSports" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_8
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing BingFinance
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.BingFinance" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_9
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing MicrosoftOfficeHub
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.MicrosoftOfficeHub" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_10
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing BingNews
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.BingNews" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_11
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing OneNote
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.Office.OneNote" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_12
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing Sway
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.Office.Sway" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_13
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing WindowsPhone
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.WindowsPhone" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_14
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing CommsPhone
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.CommsPhone" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_15
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing YourPhone
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.YourPhone" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_16
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing Getstarted
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.Getstarted" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_17
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing Microsoft549981C3F5F10
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.549981C3F5F10" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_18
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing Messaging
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.Messaging" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_19
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing WindowsSoundRecorder
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.WindowsSoundRecorder" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_20
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing MixedRealityPortal
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.MixedReality.Portal" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_21
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing WindowsFeedbackHub
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.WindowsFeedbackHub" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_22
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing WindowsAlarms
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.WindowsAlarms" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0
:blodware_sub_op_23
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing WindowsCamera
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.WindowsCamera" | Remove-AppxPackage"
taskkill /f /im explorer.exe & start explorer & exit /b 0

:blodware_op_8
setlocal EnableExtensions DisableDelayedExpansion
echo -- Uninstalling third-party apps
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage \"king.com.CandyCrushSaga\" | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage \"king.com.CandyCrushSodaSaga\" | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage \"ShazamEntertainmentLtd.Shazam\" | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage \"Flipboard.Flipboard\" | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage \"9E2F88E3.Twitter\" | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage \"ClearChannelRadioDigital.iHeartRadio\" | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage \"D5EA27B7.Duolingo-LearnLanguagesforFree\" | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage \"AdobeSystemsIncorporated.AdobePhotoshopExpress\" | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage \"PandoraMediaInc.29680B314EFC2\" | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage \"46928bounde.EclipseManager\" | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage \"ActiproSoftwareLLC.562882FEEB491\" | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage \"SpotifyAB.SpotifyMusic\" | Remove-AppxPackage"
pause
endlocal
taskkill /f /im explorer.exe & start explorer & exit /b 0

:blodware_op_9
echo -- Disabling Taskbar Widgets
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d 0 /f
goto blodware_win_11_menu

:blodware_op_10
setlocal EnableExtensions DisableDelayedExpansion
echo -- Removing Copilot
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage "Microsoft.CoPilot" | Remove-AppxPackage"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t "REG_DWORD" /d "1" /f
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t "REG_DWORD" /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "AutoOpenCopilotLargeScreens" /t "REG_DWORD" /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t "REG_DWORD" /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\Shell\Copilot\BingChat" /v "IsUserEligible" /t "REG_DWORD" /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled" /t "REG_DWORD" /d "0" /f
pause
endlocal
taskkill /f /im explorer.exe & start explorer & exit /b 0
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
:opc_red_sub_menu
cls
echo ================================
echo        UTILIDAD IPCONFIG
echo ================================
echo 1. Ver contraseña de red Wi-Fi guardada
echo 2. Ver configuracion IP actual
echo 3. Ver configuracion IP detallada
echo 4. Renueva todas las direcciones IP
echo 5. Libera todas las direcciones IP
echo 6. Mostrar DNS actuales (cache)
echo 7. Guardar DNS actuales en DNS.txt
echo 8. Limpiar cache de DNS
echo 9. Mostrar ID de clase DHCP
echo 10. Regresar
echo ================================
set /p opc_sub_10_11=Selecciona una opcion:

if "%opc_sub_10_11%"=="1" goto WIFIKEY_10_11
if "%opc_sub_10_11%"=="2" goto CONFIG_10_11
if "%opc_sub_10_11%"=="3" goto CONFIGALL_10_11
if "%opc_sub_10_11%"=="4" goto RENEW_10_11
if "%opc_sub_10_11%"=="5" goto RELEASE_10_11
if "%opc_sub_10_11%"=="6" goto DISPLAYDNS_10_11
if "%opc_sub_10_11%"=="7" goto SAVEDNS_10_11
if "%opc_sub_10_11%"=="8" goto FLUSHDNS_10_11
if "%opc_sub_10_11%"=="9" goto SHOWCLASSID_10_11
if "%opc_sub_10_11%"=="10" goto Base
goto opc_red_sub_menu

:WIFIKEY_10_11
cls
echo Mostrando perfiles Wi-Fi guardados...
netsh wlan show profiles
echo.
set /p ssid=Escribe el nombre exacto de la red Wi-Fi:
cls
echo Mostrando contrasena para: %ssid%
echo ================================
netsh wlan show profile name="%ssid%" key=clear
echo ================================
pause
goto opc_red_sub_menu

:CONFIG_10_11
cls
echo Configuracion IP actual:
ipconfig
pause
goto opc_red_sub_menu

:CONFIGALL_10_11
cls
echo Configuracion IP detallada:
ipconfig /all
pause
goto opc_red_sub_menu

:RENEW_10_11
cls
echo Renovando direcciones IP...
ipconfig /renew
pause
goto opc_red_sub_menu

:RELEASE_10_11
cls
echo Liberando direcciones IP...
ipconfig /release
pause
goto opc_red_sub_menu

:DISPLAYDNS_10_11
cls
echo DNS en cache actualmente:
ipconfig /displaydns
pause
goto opc_red_sub_menu

:SAVEDNS_10_11
cls
echo Guardando DNS actuales en la carpeta del script...
ipconfig /displaydns > "%~dp0DNS.txt"
echo Listado guardado como %~dp0DNS.txt
pause
goto opc_red_sub_menu

:FLUSHDNS_10_11
cls
echo Limpiando cache de DNS...
ipconfig /flushdns
echo Cache de DNS limpiada.
pause
goto opc_red_sub_menu

:SHOWCLASSID_10_11
cls
echo Mostrando ID de clase DHCP de todos los adaptadores:
ipconfig /showclassid *
pause
goto opc_red_sub_menu
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
