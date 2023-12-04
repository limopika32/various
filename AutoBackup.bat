@echo off
cd C:\Users\user\

rem Boxなどクラウドフォルダにぶち込むときは一時的なフォルダに保存してからクラウドにぶち込むと1回のアップロードで済みます
robocopy Documents C:\uBackup\tmp\Documents\ /E /Z /XJ /V /R:10 /W:5 /IT /NP /V /LOG:C:\uBackup\upload_latest.log
robocopy Downloads C:\uBackup\tmp\Downloads\ /E /Z /J /XJ /V /R:10 /W:5 /IT /NP /V /LOG+:C:\uBackup\upload_latest.log

rem zipに圧縮する作業。7z以外の場合はなんとかしてください。
cd C:\uBackup\
"C:\Program Files\7-Zip\7z.exe" u C:\uBackup\upd.zip C:\uBackup\tmp\ C:\uBackup\upload_latest.log
copy C:\uBackup\upd.zip C:\Users\user\Box\Backup\

rem Boxとワンドラにぶち込んでやるぜ
copy C:\uBackup\upload_latest.log C:\Users\user\Box\Backup\
copy C:\uBackup\upd.zip "%OneDrive%\backup\"

rem アップロード作業中で終了した場合などのクリーンアップ
del "*.tmp?"