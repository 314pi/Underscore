::@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Pre processing template
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
::@(#)      %$NAME% [function] {arguments}
::@(#)   
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Used as a pre processing template with _postScript.cmd
::@(#)  No detailed example currently available
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)     CALL _preScript
::@(#)     :: processing
::@(#)     CALL %$NAME%
::@(#) 
::@ (#) 
::@ (#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@ (#)
::@ (#)ENVIRONMENT
::@(-)  Variables affected
::@(#)  $ErrorLevel     Increased with OS errorlevel
::@(#)
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
::@(#)  _UTC                    Current time
::@(#)  _registry.write_string  Write data to registry
::@(#)  _debug.cmd
::@(#)  _getopt
::@(#)
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@ (#)  
::@ (#)  
::@ (#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@ (#)  URL: 
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
::SET $VERSION=xx.xxx&SET $REVISION=YYYY-MM-DDThh:mm&SET $COMMENT=Description/init
::SET $VERSION=2015-02-19&SET $REVISION=00:00:00&SET $COMMENT=Initial/ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
::ENDLOCAL

:_PreScript
    IF NOT DEFINED $Root   SET $Root=%~dp0
    IF NOT DEFINED $Source SET $Source=%~f0
    SET PATH=%$Root%;%Path%
    SET $LogFile=%$Source:~0,-4%.log
    SET $TraceFile=%$Source:~0,-4%.trc

    CALL _GetOpt %*
    CALL _DEBUG

    SET $ErrorLevel=0
    %_VERBOSE_% %$NAME% v.%$Version% -- %$Description%
    %_DEBUG_% %$Revision% - %$Comment%
    %_VERBOSE_%:
    %_LOG_% %$NAME% v.%$Version% -- %$Description%
    %_TRACE_% %$NAME% v.%$Version% -- %$Description%
    %_TRACE_% %$Revision% - %$Comment% >%$LogFile%
    %_DEBUG_% %$Revision% - %$Comment% >%$LogFile%

::    CALL _registry.read_string "HKEY_LOCAL_MACHINE\SOFTWARE\ClicketyClick.dk\%$Name%" "ProgramFilesDir"
    CALL _UTC>nul
    CALL _registry.write_string ^
        "HKEY_LOCAL_MACHINE\SOFTWARE\ClicketyClick.dk\%$Name%" ^
        "Status" "Started" 
    CALL _registry.write_string ^
        "HKEY_LOCAL_MACHINE\SOFTWARE\ClicketyClick.dk\%$Name%" ^
        "Start" "%UTC%"
    CALL _registry.write_string ^
        "HKEY_LOCAL_MACHINE\SOFTWARE\ClicketyClick.dk\%$Name%" ^
        "CmdLine" "%*" 
    CALL _registry.write_string ^
        "HKEY_LOCAL_MACHINE\SOFTWARE\ClicketyClick.dk\%$Name%" ^
        "Version" "%$Version% %$Revision%"
    
    IF defined @%$NAME%.?       GOTO usage
    IF defined @%$NAME%.h       GOTO usage
    IF defined @%$NAME%.manual  SET DEBUG=1 && GOTO usage

GOTO :EOF    
    
::----------------------------------------------------------------------

:usage
    ::CALL what %~dpnx0
    CALL what %$Source%
    SET $ErrorLevel=1
    EXIT /b 1
GOTO :EOF

::----------------------------------------------------------------------