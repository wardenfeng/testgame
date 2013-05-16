ProtocolCoderAs GobangProto.xml --client
move /Y SlotProto.as client\Slot\src
xcopy /E /Y protobuf client\Slot\src\protobuf
del initializer.as.inc
rd protobuf /s /q
pause
