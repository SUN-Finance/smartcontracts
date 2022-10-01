//SPDX-License-Identifier: MIT

pragma solidity >=0.4.4 <0.7.0;
pragma experimental ABIEncoderV2;
import "./Utilidades/Utilidades.sol";

//interface de nuestro token
interface IERC20{
//devuelve la cantidad de tokens en existencia
function totalSupply() external view returns(uint256);

//devuelve la cantidad de tokens para una direccion indicada por parametro
function balanceOf(address account) external view returns(uint256);

//devuelve el numero de tokens que un persona podra gastar en nombre del propietario
function allowance(address owner, address spender) external view returns(uint256);

//devuelve booleano indicando el resultado de la operacion
function transfer(address recipient, uint256 amount) external returns(bool);

//devuelve un valor booleano con el resultado de la operacion de gasto
function approve(address spender, uint256 amount) external returns(bool);

//devuelve un varlor booleano con el resultado de la operacion de pase de una cantidad de tokens usando el metodo 
function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

function transferencia_loteria(address sender, address receiver, uint256 numTokens) external  returns (bool);
//EVENTOS
//evento que se debe emitir cuando una cantidad de tokens pase de un origen a un destino
event Transfer(address indexed from, address indexed to, uint256 tokens);

//evento que se debe emitir cuando se establece una asignacion con el metodo allowance()
event Approval(address indexed owner, address indexed spender, uint256 tokens);

}



contract cLotta is IERC20{

        //usings
        using Utilidades for uint256;

    //propiedades
    string public constant name = "cLotta";
    string public constant symbol = "CLOTTA";
    uint8 public constant decimals = 18;
    uint256 totalSupply_;

    event Transfer(address indexed from, address indexed to, uint256 tokens);
    event Approval(address indexed owner, address indexed spender, uint256 tokens);

 
    //mapping
    mapping(address => uint256) balances;

    mapping(address => mapping(address => uint256)) allowed;


    //constructor
    constructor (uint256 initialSupply) public{
        totalSupply_ = initialSupply;
        balances[msg.sender] = totalSupply_;
    }
    
    
    //funciones

    function totalSupply() public override view returns(uint256){
        return totalSupply_;
    }

    function balanceOf(address account) public override view returns(uint256){
        return balances[account];       
    }

    function increaseTotalSupply(uint256 newTokenAmount) public{
        
        totalSupply_ += newTokenAmount;
        balances[msg.sender] += newTokenAmount;
    }

    function allowance(address owner, address delegate) public override view returns(uint256){
        return allowed[owner][delegate];
    }

    function transfer(address recipient, uint256 amount) public override  returns(bool){
        require(amount <= balances[msg.sender]);

        balances[msg.sender] = balances[msg.sender].sub(amount);
        balances[recipient] = balances[recipient].add(amount);

        emit Transfer(msg.sender, recipient, amount);

        return true;
    }

    function approve(address delegate,uint256 amount) public override returns(bool){
        allowed[msg.sender][delegate] = amount;
        
        emit Approval(msg.sender, delegate, amount);
        return true;
    }
function transferFrom(address owner, address buyer, uint256 numTokens) public override returns (bool){
        require (numTokens <= balances[owner]);
        require (numTokens <= allowed[owner][msg.sender]);
        
        balances[owner] = balances[owner].sub(numTokens);
        allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numTokens);
        balances[buyer] = balances[buyer].add(numTokens);
        emit Transfer(owner,buyer,numTokens);
        return true;
    }

    function transferencia_loteria(address sender, address receiver, uint256 numTokens) public override returns (bool){
        require(numTokens <= balances[sender]);
        balances[sender] = balances[sender].sub(numTokens);
        balances[receiver] = balances[receiver].add(numTokens);
        emit Transfer(sender,receiver,numTokens);
        return true;
    }
   

   
}