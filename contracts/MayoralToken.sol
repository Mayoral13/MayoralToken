pragma solidity ^0.8.11;
library SafeMath {
  /**
   * SafeMath mul function
   * @dev function for safe multiply
   **/
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }
  
  /**
   * SafeMath div funciotn
   * @dev function for safe devide
   **/
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a / b;
    return c;
  }
  
  /**
   * SafeMath sub function
   * @dev function for safe subtraction
   **/
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }
  
  /**
   * SafeMath add fuction 
   * @dev function for safe addition
   **/
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}

contract MayoralToken{
  //USING THE SAFEMATH LIBRARY FOR ARITHMETIC OPERATIONS
    using SafeMath for uint256;

    // *******VARIABLE DECLARATION***********/
    uint private TotalSupply;
    address private owner;
    string name;
    string symbol;
    uint decimal;
    bool private paused;
    mapping (address => uint)balanceOf;
    mapping (address => mapping(address => uint))allowed;
    enum Pause{isPaused,notPaused}
    Pause _PAUSE;
    //*******EVENT DECLARARTION********/
    event transfer(address indexed _from,address indexed _to,uint _value);
    event approve(address indexed _from,address indexed _to,uint _value);
    event mint(address indexed _from,uint _value);
    event burn(address indexed _from,uint _value);
    event PAUSE(address indexed _from);
    event UNPAUSE(address indexed _from);
    event increasedallowance(address indexed _from,address indexed _to, uint _value);
    event decreasedallowance(address indexed _from,address indexed _to, uint _value);
    event withdraw(address indexed _to,uint _value);
    event renounceownership(address indexed _to);

    //**********CONSTRUCTOR TO DECLARE OWNER ADDRESS  */

    constructor(string memory _name,string memory _symbol,uint _decimal,uint _supply){
      Mint(msg.sender, _supply);
      emit mint(msg.sender, _supply);
      name = _name;
      symbol = _symbol;
      decimal = _decimal;
      owner = msg.sender;
      balanceOf[owner] = TotalSupply;
      _PAUSE = Pause.notPaused;

    }
 
//***********MODIFIER TO ASSIGN ADDRESS OWNER AS OWNER FOR ACCESS CONTROL */
    modifier OnlyOwner(){
        owner == msg.sender;
        _;
    }

    //******FUNCTION TO PAUSE CONTRACT INCASE OF ISSUES */
    function PauseContract() public OnlyOwner returns(bool success){
      require(!paused,"Contract already paused");
        paused = true;
        _PAUSE = Pause.isPaused;
        emit PAUSE(msg.sender);
        return true;

    }

    //**********FUNCTION TO UNPAUSE CONTRACT */
    function UnpauseContract ()public OnlyOwner returns(bool success){
      require(paused = true,"Contract is already unpaused");
        paused = false;
        _PAUSE = Pause.notPaused;
        emit UNPAUSE(msg.sender);
        return true;
    }

    //****FUNCTION TO SHOW OWNER ADDRESS */

    function ShowOwner()public view returns(address){
      return owner;
    }

    //*******FUNCTION TO SHOW TOKEN NAME */

    function ReturnName()public view returns(string memory){
      return name;
    }

    //**********FUNCTION TO SHOW TOKEN SYMBOL */

    function ReturnSymbol()public view returns (string memory){
      return symbol;
    }

    //**********FUNCTION TO SHOW DECIMAL */

    function ReturnDecimal()public view returns (uint){
      return decimal;
    }
    
    //**********FUNCTION TO SHOW TOKEN SUPPLY */
    function ShowTotalSupply()public view returns (uint){
        return TotalSupply;
    }

    //**********FUNCTION TO SET ALLOWANCE */
    function SetAllowance(address _recieve,uint _value)OnlyOwner public returns(bool success){
      require(paused != true);
      require(balanceOf[msg.sender] >= _value,"You do not have sufficient funds");
      require(_recieve != address(0));
        allowed[msg.sender][_recieve] = _value;
        emit approve(msg.sender,_recieve,_value);
        return true;
    }

    //**********FUNCTION TO INCREASE ALLOWANCE */

    function IncreaseAllowance(address _recieve,uint _value)OnlyOwner public returns (bool success){
      require(paused != true);
      require(_recieve != address(0));
      require(balanceOf[msg.sender] > _value,"You do not have sufficient funds");
      allowed[msg.sender][_recieve] = allowed[msg.sender][_recieve].add(_value);
      emit increasedallowance(msg.sender, _recieve, _value);
      return true;
    }
    
     //**********FUNCTION TO DECREASE ALLOWANCE */
  

    function DecreaseAllowance(address _recieve,uint _value)OnlyOwner public returns (bool success){
      require(paused != true);
      require(_recieve != address(0));
      allowed[msg.sender][_recieve] = allowed[msg.sender][_recieve].sub(_value);
       emit decreasedallowance(msg.sender, _recieve, _value);
      return true;
    }

     //**********FUNCTION TO SEND TOKENS */

    function Transfer(address _from,address _to,uint _value) public returns(bool success){
      require(paused != true);
        require(balanceOf[msg.sender] >= _value,"You do not have sufficient funds");
        require(_to != address(0),"You cant send to zero account");
        balanceOf[_from] = balanceOf[_from].sub(_value);
        balanceOf[_to] = balanceOf[_to].add( _value);
        emit transfer(_from, _to,_value);
        return true;
    }

     //**********FUNCTION TO CHECK BALANCE OF HOLDERS */

    function CheckBalance(address _who)public view returns(uint){
        return balanceOf[_who];
    }

     //**********FUNCTION TO MINT MORE TOKENS */

    function Mint(address _from,uint _value)OnlyOwner public returns(bool success){
      require(paused != true);
      require(_from != address(0));
        require(_value != 0,"You have input an invalid amount");
        TotalSupply = TotalSupply.add(_value);
        balanceOf[_from] = balanceOf[_from].add(_value);
        return true;
    }

     //**********FUNCTION TO BURN TOKENS */

    function Burn(address _from,uint _value)OnlyOwner public returns(bool success){
      require(paused != true);
      require(_from != address(0));
      require(_value != 0,"You have input an invalid amount");
      require(_value <= TotalSupply,"You cannot burn entire supply");
      balanceOf[_from] = balanceOf[_from].sub(_value);
      return true;
    }

    //******WITHDRAW FUNCTION INCASE OF ACCIDENTAL ETHER TRANSFER */
    function Withdraw(address payable _to,uint _value)public OnlyOwner returns (bool success){
      require(_value <= address(this).balance);
      _to.transfer(_value);
      emit withdraw(_to,_value);
      return true;
      
    }

    //***********RENOUNCE OWNERSHIP */
    function Renounce(address _to)public OnlyOwner returns(bool success){
      require(_to != address(0),"You cannot set it as owner");
      owner = _to;
      emit renounceownership(_to);
      return true;
      

    }

    //*******CHECK ALLOWANCE */
    function CheckAllowance(address _to)public view returns(uint){
      return allowed[owner][_to];
    }
}   