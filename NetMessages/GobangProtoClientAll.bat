protoc --java_out=java SlotProto.proto
protoc --cpp_out=cpp SlotProto.proto
protoc --plugin=protoc-gen-as3=as\plugin\protoc-gen-as3.bat --as3_out=as\out SlotProto.proto
protoc --python_out=python SlotProto.proto
pause
