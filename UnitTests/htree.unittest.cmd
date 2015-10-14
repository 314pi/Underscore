
::---------------------------------------------------------------------

:_UnitTest_htree
SETLOCAL
    SHIFT
    
    >>"%TEMP%\%0.trc" ECHO %0

    :: Create ref
    >>"%TEMP%\%0.trc" ECHO :: Create ref
 ::   SET _REF_=^>^>"%TEMP%\%0.ref" 2^>^>"%TEMP%\%0.trc" ECHO
    (
        ECHO:����#$#First
        ECHO:�   ����#$#secondA
        ECHO:�       ����#$#thierdA
        
REM        ECHO:ÀÄÄÄ#$#First
REM        ECHO:    ÃÄÄÄ#$#secondA
REM        ECHO:    ³   ÀÄÄÄ#$#thierdA
REM        ECHO:    ÀÄÄÄ#$#secondB
REM        ECHO:        ÀÄÄÄ#$#thierdA
    )>"%TEMP%\%0.ref"

    ::MKDIR "%TEMP%\#$#First\#$#secondA\#$#thierdA"
    ::MKDIR "%TEMP%\#$#First\#$#secondB\#$#thierdA"
    
    FOR %%A IN ("\#$#First\#$#secondA\#$#thierdA" "#$#First\#$#secondB\#$#thierdA" ) DO (
        IF NOT EXIST "%TEMP%%%~A" MKDIR "%TEMP%%%~A"
    )

::  %$Name% [drive:][path] [/F] [/A] [^>html_tree.html] [2^>ascii_tree.txt]
:: 
::  /F   Display the names of the files in each folder.
::  /A   Use ASCII instead of extended characters. (NO HTML)

    :: Create dump
    >>"%TEMP%\%0.trc" ECHO :: Create dump

    CALL %0 %TEMP% >"%TEMP%\%0.html" 2>"%TEMP%\%0.tmp" 
    find "#$#" <"%TEMP%\%0.tmp" >"%TEMP%\%0.dump"

GOTO :EOF *** :_UnitTest__htree ***

::---------------------------------------------------------------------