; PlayzDownloader.nsi
; Fully customized NSIS script with versioning, icons, images, license, and shortcut options

;--------------------------------
; Define version and output location
!define VERSION "0.1.0"
OutFile "NSIS-Installer-Output\PlayzDownloaderInstaller_v${VERSION}.exe"

;--------------------------------
; Basic installer settings
Name "PlayzDownloader"
InstallDir "$PROGRAMFILES\PlayzDownloader"
ShowInstDetails show
ShowUninstDetails show
Icon "imgs\icon.ico"
UninstallIcon "imgs\icon.ico"

;--------------------------------
; Includes
!include "MUI2.nsh"
!include "nsDialogs.nsh"
!include "WinMessages.nsh"

;--------------------------------
; Images and license
!define MUI_WELCOMEFINISHPAGE_BITMAP "imgs\welcome.bmp"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "imgs\header.bmp"
!define MUI_HEADERIMAGE_RIGHT

;--------------------------------
; Page flow
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "license.txt"
!insertmacro MUI_PAGE_DIRECTORY
Page custom ShortcutOptionsCreate ShortcutOptionsLeave
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

;--------------------------------
; Variables
Var CREATE_DESKTOP_SHORTCUT
Var CREATE_STARTMENU_SHORTCUT

;--------------------------------
; Custom Page - Shortcut Options

Function ShortcutOptionsCreate
    nsDialogs::Create 1018
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}

    ${NSD_CreateCheckbox} 20u 20u 200u 12u "Create Desktop Shortcut"
    Pop $CREATE_DESKTOP_SHORTCUT
    ${NSD_SetState} $CREATE_DESKTOP_SHORTCUT ${BST_CHECKED}

    ${NSD_CreateCheckbox} 20u 50u 200u 12u "Create Start Menu Shortcut"
    Pop $CREATE_STARTMENU_SHORTCUT
    ${NSD_SetState} $CREATE_STARTMENU_SHORTCUT ${BST_CHECKED}

    nsDialogs::Show
FunctionEnd

Function ShortcutOptionsLeave
    ${NSD_GetState} $CREATE_DESKTOP_SHORTCUT $0
    StrCpy $CREATE_DESKTOP_SHORTCUT $0

    ${NSD_GetState} $CREATE_STARTMENU_SHORTCUT $0
    StrCpy $CREATE_STARTMENU_SHORTCUT $0
FunctionEnd

;--------------------------------
; Installation Section

Section "Install"

    SetOutPath "$INSTDIR"
    File /r "files\*.*"

    WriteUninstaller "$INSTDIR\Uninstall.exe"

    ; Desktop shortcut
    StrCmp $CREATE_DESKTOP_SHORTCUT ${BST_CHECKED} 0 +3
        CreateShortcut "$DESKTOP\PlayzDownloader.lnk" "$INSTDIR\PlayzDownloader.exe" "" "$INSTDIR\icon.ico"

    ; Start Menu shortcut
    StrCmp $CREATE_STARTMENU_SHORTCUT ${BST_CHECKED} 0 +4
        CreateDirectory "$SMPROGRAMS\PlayzDownloader"
        CreateShortcut "$SMPROGRAMS\PlayzDownloader\PlayzDownloader.lnk" "$INSTDIR\PlayzDownloader.exe" "" "$INSTDIR\icon.ico"

SectionEnd

;--------------------------------
; Uninstallation Section

Section "Uninstall"

    Delete "$INSTDIR\PlayzDownloader.exe"
    Delete "$INSTDIR\Uninstall.exe"
    RMDir /r "$INSTDIR"

    Delete "$DESKTOP\PlayzDownloader.lnk"
    Delete "$SMPROGRAMS\PlayzDownloader\PlayzDownloader.lnk"
    RMDir "$SMPROGRAMS\PlayzDownloader"

SectionEnd
