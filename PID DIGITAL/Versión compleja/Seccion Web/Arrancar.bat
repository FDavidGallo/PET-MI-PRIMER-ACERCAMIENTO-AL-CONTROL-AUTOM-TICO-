@echo off
setlocal enabledelayedexpansion

:: Configuración: nombre del archivo de flujo (puede ser "flow.json" o "flow" sin extensión)
set "FLOW_FILE=flow.json"

if not exist "%~dp0%FLOW_FILE%" (
    echo [ERROR] No se encuentra el archivo %FLOW_FILE% en la misma carpeta que este script.
    pause
    exit /b 1
)

echo Iniciando Node-RED...
start "Newt" newt
start "Node-RED" node-red

echo Esperando que Node-RED arranque (20 segundos)...
timeout /t 20 /nobreak >nul

echo Importando flujo desde %FLOW_FILE%...
curl -X POST http://localhost:1880/flows -H "Content-Type: application/json" -d @"%~dp0%FLOW_FILE%"

if %ERRORLEVEL% EQU 0 (
    echo Flujo importado exitosamente.
) else (
    echo Error al importar. Verificá que Node-RED esté corriendo y que curl esté instalado.
)

pause