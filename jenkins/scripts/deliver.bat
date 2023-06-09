@echo off

REM Build the application
npm run build

REM Start the application
start "" npm start

REM Wait for the application to start
ping 127.0.0.1 -n 10 > nul

REM Finish
echo Application deployed successfully.
