pragma solidity ^0.4.16;

contract VizBytesString {
    
    bytes3 bytes3Storage;
    byte[] dynamicStorageByteArray;
    bytes bytesStorage;
    
    string stringStorage;
    
    function instantiateArray(byte[3] byteArrayParam, bytes3 bytes3Param) public {
        // can't convert byte array to bytesArray
        // bytes3Storage = byteArrayParam;
        // not allowed bytes# is readonly
        // bytes3Storage[0] = 3;
        // allowed
        bytes3Storage = bytes3Param;
        
        // copies byteArrayParam from memory to storage
        dynamicStorageByteArray = byteArrayParam;
        // creates array literal in memory and copies to storage
        dynamicStorageByteArray = [byte(4), 5, 6];
        // can't because bytes# can't be converted to byte array
        // dynamicStorageByteArray = bytes3Storage;
        
        // not allowed
        // bytesStorage = byteArrayParam;
        // not allowed
        // bytesStorage = bytes3Param;
        // allowed
        bytesStorage[2] = 0x12;
        // allowed
        bytesStorage.length = 1;
        //allowed
        bytesStorage.push(0x12);
        
        stringStorage = "string";
        // string doesn't have length or push
        // uint8 length = stringStorage.length;
        // stringStorage.push("a");
    }
}
