@ECHO OFF

rem 某講義のLinuxに接続する奴そのままですが

cd C:\Users\user\.ssh
echo Toybox (Lubuntu)
echo ================
echo:
echo SSHを開始しています...
ssh -X kit@toybox
pause
exit