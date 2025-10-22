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
    
    readmeContent := "# Proyecto: " . newFolderName . "`n`n"
    readmeContent .= "## 📅 Fecha de creación`n"
    readmeContent .= timestampFull . "`n`n"
    readmeContent .= "## 📍 Ruta del proyecto`n"
    readmeContent .= "🗂️ **Raíz:** " . fullFolderPath . "`n"
    readmeContent .= "🎨 **Frontend:** " . fullFolderPath . "\client`n"
    readmeContent .= "⚙️ **Backend:** " . fullFolderPath . "\server`n"
    readmeContent .= "📚 **Documentación:** " . fullFolderPath . "\docs`n`n"
    readmeContent .= "---`n`n"
    readmeContent .= "## 🗂️ Estructura del proyecto`n`n"
    readmeContent .= "- **`/client`**`n"
    readmeContent .= "  Frontend: interfaz de usuario (HTML, CSS, JavaScript).`n"
    readmeContent .= "  - `/css` → estilos`n"
    readmeContent .= "  - `/js` → lógica interactiva`n"
    readmeContent .= "  - `/assets/images` → imágenes, diagramas, recursos visuales`n`n"
    readmeContent .= "- **`/server`**`n"
    readmeContent .= "  Backend: lógica del servidor, API, rutas.`n"
    readmeContent .= "  - `server.js` → punto de entrada`n"
    readmeContent .= "  - `/routes` → endpoints (a crear según necesidad)`n`n"
    readmeContent .= "- **`/docs`**`n"
    readmeContent .= "  Documentación adicional: anotaciones, esquemas de red, wireframes, enunciados.`n`n"
    readmeContent .= "- **`.gitignore`**`n"
    readmeContent .= "  Archivos excluidos de control de versiones.`n`n"
    readmeContent .= "---`n`n"
    readmeContent .= "## 🎯 Propósito del proyecto`n"
    readmeContent .= "<!-- COMPLETAR: Describe brevemente el objetivo de este proyecto -->`n`n"
    readmeContent .= "## ▶️ Cómo usar`n"
    readmeContent .= "1. Abre la carpeta en VS Code.`n"
    readmeContent .= "2. Edita los archivos en `/client` para el frontend.`n"
    readmeContent .= "3. (Opcional) Configura el backend en `/server`.`n"
    readmeContent .= "4. Guarda diagramas o capturas en `/docs` o `/client/assets/images`.`n`n"
    readmeContent .= "---`n"
    readmeContent .= "*Generado automáticamente por el script de entorno de desarrollo.*`n"
    
    try {
        FileAppend(readmeContent, fullFolderPath . "\README.md", "UTF-8")
    } catch as err {
        MsgBox("Error al crear README.md: " . err.Message)
    }
    
    ; === ABRIR VS CODE ===
    if (FileExist(vsCodePath)) {
        Run('"' . vsCodePath . '" "' . fullFolderPath . '"')
        ToolTip("✅ Proyecto '" . newFolderName . "' creado exitosamente`nEstructura fullstack lista para usar")
        Sleep(3000)
        ToolTip()
    } else {
        MsgBox("❌ Error: No se encontró VS Code en:`n" . vsCodePath . "`n`nVerifica la ruta en el script.`n`n⚠️ El proyecto se creó correctamente, pero no se pudo abrir VS Code.")
    }
}

; --- Función: Cerrar Proyecto ---
CloseProject() {
    global currentProjectPath
    
    ; Verificar si hay un proyecto activo
    if (currentProjectPath == "") {
        ToolTip("⚠️ No hay proyecto activo para cerrar")
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
        result := MsgBox("¿Desea eliminar todo el proyecto excepto el timestamp en README.md?`n`n(Y) Sí, eliminar archivos`n(N) No, mantener todo", "Limpieza de proyecto", "YesNo 32")
        
        if (result = "Yes") {
            CleanProjectKeepTimestamp()
        } else {
            ToolTip("✅ Proyecto cerrado. Archivos conservados.")
            Sleep(2000)
            ToolTip()
        }
        
        ; Limpiar la ruta del proyecto actual
        currentProjectPath := ""
    } else {
        ; Si VS Code no está abierto, preguntar igualmente
        result := MsgBox("¿Desea eliminar todo el proyecto excepto el timestamp en README.md?`n`n(Y) Sí, eliminar archivos`n(N) No, mantener todo", "Limpieza de proyecto", "YesNo 32")
        
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
        ToolTip("⚠️ No se puede limpiar: ruta de proyecto no válida")
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
                if (InStr(A_LoopField, "## 📅 Fecha de creación")) {
                    timestampLine := A_LoopField
                    ; Leer la siguiente línea que contiene el timestamp
                    continue
                }
                if (timestampLine != "" && A_LoopField != "") {
                    timestampLine .= "`n" . A_LoopField
                    break
                }
            }
        }
    }
    
    ; Si no se encontró timestamp, usar uno genérico
    if (timestampLine == "") {
        timestampLine := "## 📅 Fecha de creación`n" . FormatTime(, "dd/MM/yy HH:mm:ss")
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