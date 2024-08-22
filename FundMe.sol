// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import {PriceConverter} from "./PriceConverter.sol";


contract FundMe{


    using PriceConverter for uint256;


    uint256 public minimumJpy = 500e18;
    
    address public owner;


    /*______________________________________________________________________*/

    constructor() {
        owner = msg.sender;
    }
    //"PINK"

    modifier onlyOwner() {
        require(msg.sender == owner, "sender is not owner");
        _;
    }
    /*______________________________________________________________________*/

    address[] public funders;
    mapping(address funder => uint256 HowMuchFunded) public addressToAmountFunded;
    
    
    function fund() public payable {
        
        require(msg.value.getConversionRate() >= minimumJpy,"did not send enough ether dude");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;

        }
        funders = new address[](0);

        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "call failed");
    }

   

    }


//Address 0x8A6af2B75F23831ADc973ce6288e5329F63D86c6
//Jpy!!!