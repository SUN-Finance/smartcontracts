// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 <0.7.0;
pragma experimental ABIEncoderV2;

/*
/ Libreria de Utilidades basicas con objetos enteros, string y demas.
/
/
/
*/

library Utilidades{
//################### SAFEMATCH ###################
//enteros positivos

//--------------
//restas
function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
}
//--------------

//--------------
//sumas
function add(uint256 a, uint256 b) internal pure returns (uint256){
    uint256 c = a + b;
    assert(c >= a);
    return c;
}
//--------------

//--------------
//multiplicacion
function mul(uint a, uint b) internal pure returns (uint256){
    if(a == 0){
        return 0;
    }

    uint256 c = a * b;
    require(c / a == b, "SafeMatch: overflow");

    return c;
}
//--------------
//################### SAFEMATCH ###################

//################### STRING   ###################
//Compararar cadenas
function Compare(string memory a, string memory b) internal pure returns(bool){
    bytes32 hash_a = keccak256(abi.encodePacked(a));
    bytes32 hash_b = keccak256(abi.encodePacked(b));

    if(hash_a == hash_b){
        return true;
    }else{
        return false;
    }
}

//concatenar cadenas
 function concatenar(string memory a, string memory b)internal pure returns (string memory){
           return string(abi.encodePacked(a,b));
}
//split de cadenas

//es null o vacia

//################### STRING   ###################

//################### INT   ###################

 function iToString(uint  dato) internal pure returns(string memory){

        if(dato == 0){
            return "0";
        }

      
        uint256 temp = dato;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (dato != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(dato % 10)));
            dato /= 10;
        }
        return string(buffer);
    }

//################### INT   ######################

//################### KECCAK256 ###################
//obtener keccak string
function skeccak(string memory dato) internal pure returns(bytes32){
    return keccak256(abi.encodePacked(dato));
} 

//obtener keccak int
function ikeccak(uint dato) internal pure returns(bytes32){
    return keccak256(abi.encodePacked(dato));
}

//obtener keccak address
function dkeccak(address dato) internal pure returns(bytes32){
    return keccak256(abi.encodePacked(dato));
}

//################### KECCAK256 ###################

}