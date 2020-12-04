@echo off
echo -
echo RealWorld RWServer Test
echo -
cd C:\RWServer\
start C:\RWServer\core\FXServer.exe +exec configs\server-test.cfg +set onesync_enabled 1 +set onesync_enableInfinity 1 +set onesync_enableBeyond 1
exit