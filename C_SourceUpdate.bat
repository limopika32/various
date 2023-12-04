@echo off

rem オペレーションシステムとかでWindowsでダウンロードした奴をLinux側のディスクにぶち込んでやるぜ
rem ※予めsambaの設定などをWindowsで設定しておく必要あり

cd C:\Users\user\Documents\10-Source\
xcopy C T:\csource\os1\ /D /E /V /C /H /Y