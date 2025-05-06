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
