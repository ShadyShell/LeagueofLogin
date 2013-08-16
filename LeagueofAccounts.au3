;~ ;Copyright ShadyShell 2013
;~ #include <File.au3>
$accountNumber = 0

;~ If Not FileExists("accountConfig.ini") Then
;~ 	_FileCreate("accountConfig.ini")
;~ 	Local $file = FileOpen("accountConfig.ini", 1)
;~ 	FileWrite($file, "[GameInfo]" & @CRLF)
;~ 	FileWrite($file, "#Leave path blank if League is installed at ""C:\Riot Games\League of Legends""" & @CRLF)
;~ 	FileWrite($file, "path=" & @CRLF & @CRLF)
;~ 	FileWrite($file, "[Account 1]" & @CRLF)
;~ 	FileWrite($file, "username=" & @CRLF)
;~ 	FileWrite($file, "password=")
;~ 	FileClose($file)
;~ 	MsgBox(64, "Config File Created", "An ini file was not detected and created." & @CRLF & "Please re-run this application after you have filled out the necessary fields.")
;~ Else
;~ 	$path = IniRead("accountConfig.ini", "GameInfo", "path", "default")
;~ 	$username = IniRead("accountConfig.ini", "Account 1", "username", "default")
;~ 	$password = IniRead("accountConfig.ini", "Account 1", "password", "default")

;~ 	If $username Or $password == "" Then
;~ 		MsgBox(16, "Go back to bot games", "Username and Password fields cannot be left blank.")
;~ 		Exit
;~ 	EndIf
;~ 	If $path == "" Then
;~ 		Run("C:\Riot Games\League of Legends\lol.launcher.exe")
;~ 	Else
;~ 		Run($path & "\lol.launcher.exe")
;~ 	EndIf
;~ 	WinWait("PVP.net Patcher", "")
;~ 	If Not WinActive("PVP.net Client", "") Then WinActivate("PVP.net Client", "")
;~ 	WinWaitActive("PVP.net Client", "")
;~ 	Sleep(1000)
;~ 	Send("{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}" & $username & "{TAB}" & $password)
;~ 	Sleep(500)
;~ 	Send("{ENTER}")
;~ EndIf

;~ Local $var = IniReadSectionNames("accountConfig.ini")
;~ For $i = 2 To $var[0]
;~ 	Local $var2 = IniReadSection("accountConfig.ini", $var[$i])
;~ 	For $j = 1 To $var2[0][0]
;~ 		MsgBox(4096, "", "Key: " & $var2[$j][0] & @CRLF & "Value: " & $var2[$j][1])
;~ 	Next
;~ Next


#include <GUIConstantsEx.au3>
#include <Array.au3>

; Here is the array
Global $aArray[5][2] = [["Andy", "Football"],["Jon", "Swimming"],["Jeremy", "Tennis"],["Carol", "Basketball"],["Vicky", "Hockey"]]
dim $usernames[25]
dim $passwords[25]

; And here we get the elements into a list
$sList = ""
$sList2 = ""
;~ For $i = 2 To $var[0]
;~ 	$sList &= "|" & $var[$i]
;~ Next

$var = IniReadSectionNames("accountConfig.ini")
For $i = 2 To $var[0]
	$sList &= "|" & $var[$i]

	$var2 = IniRead("accountConfig.ini", $var[$i], "username", "default")
	$var3 = IniRead("accountConfig.ini", $var[$i], "password", "default")
	;For $j = 1 To $var2[0][0]
	_ArrayInsert($usernames,$i-2,$var2)
	_ArrayInsert($passwords,$i-2,$var3)
		$sList2 &= "|" & $var2
		;MsgBox(4096, "", "Key: " & $var2[$j][0] & @CRLF & "Value: " & $var2[$j][1])
	;Next
Next

; Create a GUI
#include <GUIConstantsEx.au3>

$hGUI = GUICreate("Test", 500, 500)

; Create the combo
$hCombo = GUICtrlCreateCombo("", 10, 10, 200, 20)
; And fill it
GUICtrlSetData($hCombo, $sList)

; Create label
$hLabel = GUICtrlCreateLabel("", 220, 15, 200, 20)

GUISetState()
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit
		Case $hCombo
			$sName = GUICtrlRead($hCombo)
			$iIndex = _ArraySearch($var, $sName)
			If Not @error Then
				GUICtrlSetData($hLabel, $usernames[$iIndex-2])
			EndIf
	EndSwitch
WEnd