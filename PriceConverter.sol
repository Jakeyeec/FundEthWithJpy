// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


library PriceConverter {
    

    function getPrice() internal view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A6af2B75F23831ADc973ce6288e5329F63D86c6);
        (,int256 price,,,) = priceFeed.latestRoundData();
        //Price of eth in terms of Jpy
        return uint256(price * 1e10);
    }
    
    
    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInJpy = (ethPrice * ethAmount) / 1e18;
        return ethAmountInJpy;

    }
}