pragma solidity ^0.4.24;

contract Game {
    
address public owner;

  constructor() public {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }
uint256 public endtime = 1534193343;
uint256 public maxtime = 1534150143;
uint256 public stime = 1534107243;
uint256 public gametype = 0.5 ether;

     
mapping(address => uint256) private dzeros;
mapping(address => uint256) private entrance;
mapping(address => uint256) private uvalue;

  function () public payable {
 
        bool accept=false;
        if(now<=endtime && now>stime) {
            
         if (now<=maxtime || entrance[msg.sender]==1) {
        //Check values
        if (msg.value == 0 || msg.value == 0.005 ether || msg.value == 0.01 ether || msg.value == 0.05 ether || msg.value == 0.08 ether || msg.value == 0.1 ether) {
        accept=true; }
       
        //Values are accepted
        if (accept) {
            
         
        //IF value zero count zeros
        if (msg.value == 0) {
            dzeros[msg.sender] = dzeros[msg.sender]+1;
            
            if(dzeros[msg.sender]==1 && now<=maxtime) { entrance[msg.sender]=1;}
            
        }
        //IF zero count bigger 10 move revert
        if(msg.value == 0 && dzeros[msg.sender]>10){ accept=false; }
        if (msg.value > 0 && dzeros[msg.sender]<=0) { accept=false;  }
            
            
        //IF total spent eth > gametype by one gamer revert
        if ((uvalue[msg.sender]+msg.value)<=gametype && accept==true) { 
            uvalue[msg.sender] = uvalue[msg.sender]+msg.value;   } else { accept=false;}  
        
        }
        
        }
        }
        
        if(!accept) { revert(); } 
        
   }
 
  
  function sendToWinner(address payee, uint256 ratio) public onlyOwner {
     if(now>endtime){
    require(payee != address(this));
    payee.transfer(address(this).balance*ratio/100);
       }
  }
  
    function sendToService(address payee) public onlyOwner {
      if(now>endtime){
    require(payee != address(this));
    payee.transfer(address(this).balance);
       }
  }
  
  
  
}
