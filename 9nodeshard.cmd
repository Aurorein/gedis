@echo off

REM ȷ�� Go �Ѱ�װ����ӵ�ϵͳ·����
where go >nul 2>nul
if errorlevel 1 (
    echo Go δ��װ��δ��ӵ�ϵͳ·����
    exit /b 1
)

REM ���� main.go �ļ�
go build -o main.exe

REM ���ô��ڱ���
title Raft Cluster Startup

REM ������һ��ڵ�
start "Master Node1:8001" main.exe -httpport 8001 -raftport 9001 -node node1 -bootstrap true
start "Master Node2:8002" main.exe -httpport 8002 -raftport 9002 -node node2 -bootstrap true 
start "Master Node3:8003" main.exe -httpport 8003 -raftport 9003 -node node3 -bootstrap true

REM �ȴ���һ��ڵ�����
timeout /t 5 > nul

REM �����ڶ���ڵ�
start "Slave Node11:8004" main.exe -httpport 8004 -raftport 9004 -node node11 -joinaddr 127.0.0.1:8001
start "Slave Node12:8005" main.exe -httpport 8005 -raftport 9005 -node node12 -joinaddr 127.0.0.1:8001

REM �ȴ��ڶ���ڵ�����
timeout /t 5 > nul 

REM ����������ڵ�
start "Slave Node21:8006" main.exe -httpport 8006 -raftport 9006 -node node21 -joinaddr 127.0.0.1:8002
start "Slave Node22:8007" main.exe -httpport 8007 -raftport 9007 -node node22 -joinaddr 127.0.0.1:8002

REM �ȴ�������ڵ�����
timeout /t 5 > nul

REM ����������ڵ�
start "Slave Node31:8008" main.exe -httpport 8008 -raftport 9008 -node node31 -joinaddr 127.0.0.1:8003
start "Slave Node32:8009" main.exe -httpport 8009 -raftport 9009 -node node32 -joinaddr 127.0.0.1:8003

REM �ȴ����нڵ�����
timeout /t 5 > nul

REM ��ͣ�Ա�۲����
pause