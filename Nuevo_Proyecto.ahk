#Requires AutoHotkey v2.0

; =================================================================================
;       SCRIPT PARA CREAR ENTORNO FULLSTACK (v4.0)
;       - Inicio: Ctrl + Shift + N (crear estructura completa y abrir en VS Code)
;       - Fin: Ctrl + Shift + W (guardar README, cerrar VS Code con opción de limpieza)
; =================================================================================

; --- Configuración ---
baseFolderName := "Proyecto_Fullstack"
vsCodePath := "C:\Users\loren\AppData\Local\Programs\Microsoft VS Code\Code.exe"

; Variable global para rastrear la carpeta del proyecto actual
global currentProjectPath := ""

; === HOTKEY: CREAR PROYECTO ===
^+n::{
    CreateNewProject()
}

; === HOTKEY: GUARDAR README Y CERRAR TODO ===
^+w::{
    CloseProject()
}

; --- Función: Crear Nuevo Proyecto ---
CreateNewProject() {
    global currentProjectPath
    
    ; Obtiene la fecha actual en formato Año-Mes-Día
    timestamp := FormatTime(, "yyyy-MM-dd")
    
    ; Construye el nombre completo de la carpeta
    newFolderName := baseFolderName . "_" . timestamp
    fullFolderPath := A_Desktop . "\" . newFolderName
    
    ; Revisa si la carpeta ya existe y le añade un número si es necesario
    counter := 1
    while (DirExist(fullFolderPath)) {
        fullFolderPath := A_Desktop . "\" . newFolderName . "_" . counter
        counter++
    }
    
    ; Crea el directorio principal
    try {
        DirCreate(fullFolderPath)
        currentProjectPath := fullFolderPath
    } catch as err {
        MsgBox("Error al crear la carpeta principal: " . err.Message)
        return
    }
    
    ; === CREAR ESTRUCTURA DE CARPETAS ===
    try {
        ; Frontend
        DirCreate(fullFolderPath . "\client")
        DirCreate(fullFolderPath . "\client\css")
        DirCreate(fullFolderPath . "\client\js")
        DirCreate(fullFolderPath . "\client\assets")
        DirCreate(fullFolderPath . "\client\assets\images")
        
        ; Backend
        DirCreate(fullFolderPath . "\server")
        DirCreate(fullFolderPath . "\server\routes")
        
        ; Documentación
        DirCreate(fullFolderPath . "\docs")
    } catch as err {
        MsgBox("Error al crear la estructura de carpetas: " . err.Message)
        return
    }
    
    ; === CREAR ARCHIVOS INICIALES ===
    
    ; 1. client/index.html
    htmlContent := '<!DOCTYPE html>`n'
    htmlContent .= '<html lang="es">`n'
    htmlContent .= '<head>`n'
    htmlContent .= '    <meta charset="UTF-8">`n'
    htmlContent .= '    <meta name="viewport" content="width=device-width, initial-scale=1.0">`n'
    htmlContent .= '    <title>Proyecto Fullstack</title>`n'
    htmlContent .= '    <link rel="stylesheet" href="css/style.css">`n'
    htmlContent .= '</head>`n'
    htmlContent .= '<body>`n'
    htmlContent .= '    <h1>¡Proyecto Fullstack Iniciado!</h1>`n'
    htmlContent .= '    <p>Edita este archivo en <code>/client/index.html</code></p>`n'
    htmlContent .= '`n'
    htmlContent .= '    <script src="js/main.js"></script>`n'
    htmlContent .= '</body>`n'
    htmlContent .= '</html>`n'
    
    try {
        FileAppend(htmlContent, fullFolderPath . "\client\index.html", "UTF-8")
    } catch as err {
        MsgBox("Error al crear index.html: " . err.Message)
    }
    
    ; 2. client/css/style.css (vacío)
    try {
        FileAppend("/* Estilos del proyecto */`n`n", fullFolderPath . "\client\css\style.css", "UTF-8")
    } catch as err {
        MsgBox("Error al crear style.css: " . err.Message)
    }
    
    ; 3. client/js/main.js (vacío)
    try {
        FileAppend("// JavaScript principal`n`n", fullFolderPath . "\client\js\main.js", "UTF-8")
    } catch as err {
        MsgBox("Error al crear main.js: " . err.Message)
    }
    
    ; 4. server/server.js
    serverContent := '// Punto de entrada del backend`n`n'
    serverContent .= '// Ejemplo con Node.js y Express:`n'
    serverContent .= "// const express = require('express');`n"
    serverContent .= '// const app = express();`n'
    serverContent .= '// const PORT = 3000;`n`n'
    serverContent .= "// app.get('/', (req, res) => {`n"
    serverContent .= "//     res.send('Servidor funcionando');`n"
    serverContent .= '// });`n`n'
    serverContent .= '// app.listen(PORT, () => {`n'
    serverContent .= '//     console.log(\`Servidor corriendo en http://localhost:\${PORT}\`);`n'
    serverContent .= '// });`n'
    
    try {
        FileAppend(serverContent, fullFolderPath . "\server\server.js", "UTF-8")
    } catch as err {
        MsgBox("Error al crear server.js: " . err.Message)
    }
    
    ; 5. .gitignore
    gitignoreContent := "# Dependencias`n"
    gitignoreContent .= "node_modules/`n"
    gitignoreContent .= "package-lock.json`n`n"
    gitignoreContent .= "# Variables de entorno`n"
    gitignoreContent .= ".env`n"
    gitignoreContent .= ".env.local`n`n"
    gitignoreContent .= "# Logs`n"
    gitignoreContent .= "*.log`n"
    gitignoreContent .= "npm-debug.log*`n`n"
    gitignoreContent .= "# Sistema operativo`n"
    gitignoreContent .= ".DS_Store`n"
    gitignoreContent .= "Thumbs.db`n`n"
    gitignoreContent .= "# IDEs`n"
    gitignoreContent .= ".vscode/`n"
    gitignoreContent .= ".idea/`n"
    gitignoreContent .= "*.swp`n"
    gitignoreContent .= "*.swo`n`n"
    gitignoreContent .= "# Build`n"
    gitignoreContent .= "dist/`n"
    gitignoreContent .= "build/`n"
    
    try {
        FileAppend(gitignoreContent, fullFolderPath . "\.gitignore", "UTF-8")
    } catch as err {
        MsgBox("Error al crear .gitignore: " . err.Message)
    }
    
    ; 6. README.md
    timestampFull := FormatTime(, "dd/MM/yy HH:mm:ss")
    
    readmeContent := "# " . newFolderName . "`n`n"
    readmeContent .= "creado: " . timestampFull . "`n`n"
    readmeContent .= "rutas:`n"
    readmeContent .= "  raiz:          " . fullFolderPath . "`n"
    readmeContent .= "  frontend:      " . fullFolderPath . "\client`n"
    readmeContent .= "  backend:       " . fullFolderPath . "\server`n"
    readmeContent .= "  documentacion: " . fullFolderPath . "\docs`n`n"
    readmeContent .= "---`n`n"
    readmeContent .= "estructura:`n`n"
    readmeContent .= "/client`n"
    readmeContent .= "  html, css, js. lo usual.`n"
    readmeContent .= "  /css - estilos`n"
    readmeContent .= "  /js - scripts`n"
    readmeContent .= "  /assets/images - imagenes si es que las hay`n`n"
    readmeContent .= "/server`n"
    readmeContent .= "  el backend. node probablemente.`n"
    readmeContent .= "  server.js - arranca desde aca`n"
    readmeContent .= "  /routes - endpoints cuando los necesites`n`n"
    readmeContent .= "/docs`n"
    readmeContent .= "  diagramas, anotaciones, lo que sea que necesites documentar`n`n"
    readmeContent .= ".gitignore`n"
    readmeContent .= "  ya sabes para que es`n`n"
    readmeContent .= "---`n`n"
    readmeContent .= "proposito:`n"
    readmeContent .= "[completa esto cuando sepas que estas haciendo]`n`n"
    readmeContent .= "uso:`n"
    readmeContent .= "  abre en vscode`n"
    readmeContent .= "  edita /client para frontend`n"
    readmeContent .= "  /server si necesitas backend`n"
    readmeContent .= "  guarda cosas en /docs`n`n"
    readmeContent .= "---`n"
    readmeContent .= "generado automaticamente. obviamente.`n"
    
    try {
        FileAppend(readmeContent, fullFolderPath . "\README.md", "UTF-8")
    } catch as err {
        MsgBox("Error al crear README.md: " . err.Message)
    }
    
    ; === ABRIR VS CODE ===
    if (FileExist(vsCodePath)) {
        Run('"' . vsCodePath . '" "' . fullFolderPath . '"')
        ToolTip("proyecto '" . newFolderName . "' creado. estructura lista.")
        Sleep(3000)
        ToolTip()
    } else {
        MsgBox("no se encontro vscode en:`n" . vsCodePath . "`n`nel proyecto esta ahi de todas formas.")
    }
}

; --- Función: Cerrar Proyecto ---
CloseProject() {
    global currentProjectPath
    
    ; Verificar si hay un proyecto activo
    if (currentProjectPath == "") {
        ToolTip("no hay proyecto activo")
        Sleep(2000)
        ToolTip()
        return
    }
    
    ; Verificar si VS Code está abierto
    if WinExist("ahk_exe Code.exe") {
        ; Activar ventana de VS Code
        WinActivate("ahk_exe Code.exe")
        Sleep(200)
        
        ; Guardar todos los archivos abiertos (Ctrl+K S)
        Send("^k")
        Sleep(100)
        Send("s")
        Sleep(500)
        
        ; Cerrar VS Code (Alt+F4)
        Send("!{F4}")
        Sleep(300)
        
        ; Si aparece diálogo de confirmación, presionar Enter para confirmar
        if WinExist("Visual Studio Code ahk_exe Code.exe") {
            Sleep(200)
            Send("{Enter}")
        }
        
        Sleep(500)
        
        ; Preguntar si desea eliminar todo excepto el README con timestamp
        result := MsgBox("eliminar todo excepto el timestamp?`n`ny = si`nn = no", "limpieza", "YesNo")
        
        if (result = "Yes") {
            CleanProjectKeepTimestamp()
        } else {
            ToolTip("proyecto cerrado. archivos intactos.")
            Sleep(2000)
            ToolTip()
        }
        
        ; Limpiar la ruta del proyecto actual
        currentProjectPath := ""
    } else {
        ; Si VS Code no está abierto, preguntar igualmente
        result := MsgBox("eliminar todo excepto el timestamp?`n`ny = si`nn = no", "limpieza", "YesNo")
        
        if (result = "Yes") {
            CleanProjectKeepTimestamp()
        }
        
        currentProjectPath := ""
    }
}

; --- Función: Limpiar proyecto pero mantener timestamp ---
CleanProjectKeepTimestamp() {
    global currentProjectPath
    
    if (currentProjectPath == "" || !DirExist(currentProjectPath)) {
        ToolTip("ruta invalida. no se puede limpiar.")
        Sleep(2000)
        ToolTip()
        return
    }
    
    readmePath := currentProjectPath . "\README.md"
    
    ; Leer el timestamp del README existente
    timestampLine := ""
    if (FileExist(readmePath)) {
        try {
            content := FileRead(readmePath, "UTF-8")
            ; Buscar la línea del timestamp
            Loop Parse, content, "`n", "`r" {
                if (InStr(A_LoopField, "creado:")) {
                    timestampLine := A_LoopField
                    break
                }
            }
        }
    }
    
    ; Si no se encontró timestamp, usar uno genérico
    if (timestampLine == "") {
        timestampLine := "creado: " . FormatTime(, "dd/MM/yy HH:mm:ss")
    }
    
    ; Eliminar todos los archivos y subcarpetas
    try {
        Loop Files, currentProjectPath . "\*.*", "FD" {
            if (A_LoopFileAttrib ~= "D") {
                ; Es una carpeta
                DirDelete(A_LoopFileFullPath, true)
            } else {
                ; Es un archivo
                FileDelete(A_LoopFileFullPath)
            }
        }
        
        ; Crear nuevo README solo con timestamp
        newReadme := "# Registro de Timestamp`n`n"
        newReadme .= timestampLine . "`n`n"
        newReadme .= "---`n`n"
        newReadme .= "*Proyecto limpiado - Solo se conservó el registro temporal*`n"
        
        FileAppend(newReadme, readmePath, "UTF-8")
        
        ToolTip("✅ Proyecto limpiado. Solo queda el timestamp en README.md")
        Sleep(3000)
        ToolTip()
    } catch as err {
        MsgBox("❌ Error al limpiar proyecto: " . err.Message)
    }
}