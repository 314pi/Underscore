@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Getting PID of current Window
SET $AUTHOR=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
SET $SOURCE=%~f0
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)      %$NAME% [VAR]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#) 
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#) 
::@(#) 
::@(#) 
::@ (#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@ (#)
::@ (#)ENVIRONMENT
::@(-)  Variables affected
::@ (#)
::@ (#)
::@ (#)FILES, 
::@(-)  Files used, required, affected
::@ (#)
::@ (#)
::@ (#)BUGS / KNOWN PROBLEMS
::@(-)  If any known
::@ (#)
::@ (#)
::@(#)REQUIRES
::@(-)  Dependecies
::@(#)  getWindowPid.cmd
::@(#) 
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@ (#)  
::@ (#)  
::@ (#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@(#)  Author: aGerman
::@(#)  URL: http://www.dostips.com/forum/viewtopic.php?f=3&t=6133
::@ (#) 
::@(#)
::@(#)SOURCE
::@(-)  Where to find this source
::@(#)  %$Source%
::@(#)
::@ (#)AUTHOR
::@(-)  Who did what
::@ (#)  %$AUTHOR%
::*** HISTORY **********************************************************
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Description/init
SET $VERSION=2016-07-07&SET $REVISION=00:00:00&SET $COMMENT=Initial/ErikBachmann
::**********************************************************************
::@(#){COPY}%$VERSION:~0,4% %$Author%
::**********************************************************************
::ENDLOCAL

:MAIN
    :: Initiating global environmen
    ::CALL "%~dp0\_PreScript" %* || (CALL %~dp0\_PostScript & EXIT /B 1 )

    :: Initiating Local environmen
    CALL :Init %*

    CALL :Process
    CALL :Finalize

    :: Retur Title
    IF DEFINED _TitleTag ENDLOCAL&SET %_TitleTag%=%_Title%
GOTO :EOF

::----------------------------------------------------------------------

:: Local initiation for this script only
:init
    SET _TitleTag=%~1
GOTO :EOF

::---------------------------------------------------------------------

:: 
:Process
    :: Get PID for current windows
    CALL "%~dp0\getWindowPid" _PID>nul

    FOR /F "tokens=9*" %%A IN ('tasklist /V /FI "PID eq %_PID%" ^|find "%_PID%"') DO SET "_TITLE=%%~B"
GOTO :EOF

::---------------------------------------------------------------------

:: 
:Finalize
    ECHO:%_TITLE%
GOTO :EOF

::*** End of File *****************************************************