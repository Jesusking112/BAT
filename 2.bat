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
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
