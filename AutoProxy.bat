@echo off

echo  AutoProxy v1.2
echo ================
SET nw_retry=2

:RETRY
echo:
echo 学内ネットワーク を検証しています...

REM VPN用サーバーで判定する
for /f "usebackq tokens=*" %%a in (`ping {VPN SERVER IP HERE} -n 1`) do (
	echo %%a | find "宛先ネットワークに到達できません" >NUL
	if not ERRORLEVEL 1 (
		SET nw_private=2
	)
	echo %%a | find "要求がタイムアウトしました" >NUL
	if not ERRORLEVEL 1 (
		SET nw_private=3
	)
)

if %nw_private% EQU 2 (
	goto PRXON
) else if %nw_private% EQU 3 (
	goto PRXOFF
) else (
	goto NWERR
)


:PRXON
echo 学内ネットワークです。プロキシ設定を【有効】にしています...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "AutoConfigURL" /t REG_SZ /d "{PAC FILE ADDR HERE}" /f
goto FIN

:PRXOFF
echo 学内ネットワークではありません。プロキシ設定を [無効] にしています...

REM 既存のproxyがあれば消去(エラー表示解消)
SET prx_check=0
for /f "usebackq tokens=*" %%a in (`reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -f AutoConfigURL`) do (
	echo %%a | find "AutoConfigURL" >NUL
	if not ERRORLEVEL 1 (
		SET prx_check=1
	)
)
if %prx_check% EQU 1 (
	reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "AutoConfigURL" /f
) else (
	echo 既に無効に設定されています。
)
goto FIN

:NWERR
if %nw_retry% EQU 0 (
	echo ネットワーク検証中にエラーが発生しました。プロキシ設定は変更されませんでした。
	goto FIN
) else (
	SET /a nw_retry-=1
	echo ネットワーク検証中にエラーが発生しました。再試行します... 	- 残り %nw_retry%回
	ping 127.0.0.1 >NUL
	goto RETRY
)

:FIN
echo:
echo ----------------
echo この画面はあと約 3秒で閉じます...
ping 127.0.0.1 >NUL