// SPDX-License-Identifier: MIT

// Set the Solidity version
pragma solidity ^0.8.12;

// import the Chainlink AggregatorV3Interface to get ETH-USD conversion rate later
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract ChargingStation {
    
    // The address of the owner of this charging station
    address public admin;

    // Set price in USD cents per kwH
    uint256 public setprice = 30;

    // Set a required minimum deposit in USD
    uint256 public setdeposit = 50;

    // Constructor will run when someone deploys the contract [1]
    constructor() {
        // Setting the admin to be the person who has deployed this contract
        admin = msg.sender;
    }

    // Function to get the current ETH price in USD from chainlink in Kovan testnet [2]
    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x9326BFA02ADD2366b30bacB125260Af641031331 // [3]
            // 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e  address for Rinkeby testnet that was previously used
        );
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        // ETH/USD rate
        return uint256(answer * 10000000000);
    }

    // Function to get the conversion rate of USD in ETH [4]
    function getUSDConversionRate(uint256 USDAmount)
        public
        view
        returns (uint256)
    {
        uint256 ethPrice = getPrice();
        uint256 USDAmountInETH = (USDAmount / (ethPrice / (10**18)));
        // The actual ETH/USD conversation rate
        return USDAmountInETH;
    }

    function getAdmin() public view returns (address) {
        // Return the admin address
        return admin;
    }


    // Function to get the final electricity costs in WEI [4]
    function getElectricityCost() public view returns (uint256) {
        // Convert USD to WEI and return the electricity cost in WEI
        return getUSDConversionRate((setprice * 10**18) / 100);
    }

    // Function to get the final minimum deposit in WEI [4]
    function getMinimumDeposit() public view returns (uint256) {
        // Convert USD to WEI and return the minimum deposit amount in WEI
        return getUSDConversionRate(setdeposit * 10**18);
    }
}