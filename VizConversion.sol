pragma solidity ^0.4.16;

contract VizCoversion {
    
    function VizConversion() public pure {
        
        /* Implicit Conversion */
        uint8 uint8Impl = 3;
        uint16 uint16Impl = 256;
        // this throws error since
        // uint16 can't be implicitly cast to uint8
        // uint8Impl = uint16Impl;
        uint16Impl = uint8Impl;

        /* Explicit Conversion */
        uint8 uint8Expl;
        uint16 uint16Expl = 5;
        // error since uint16 can't be implicitly
        // cast to uint8
        // uint8Expl = uint16Expl;
        // can tell compiler to cast explicitly if
        // you are sure that e doesn't exceed uint8 range
        uint8Expl = uint8(uint16Expl);
        
        /* Deduced Conversion */
        uint8 uint8Ded = 8;
        uint16 uint16Ded = 10;
        // here deducedVar is deduced to uint8
        var deducedVar = uint8Ded;
        // can't assign uint16 to uint8
        // deducedVar = uint16Ded;
        // can explicitly cast uint16 to uint8 
        // if uint16 would never exceed 255
        deducedVar = uint8(uint16Ded);
    }
}
