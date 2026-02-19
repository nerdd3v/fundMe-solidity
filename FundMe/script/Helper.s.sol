//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

abstract contract CodeConstants{
    uint8 public constant decimals = 8;
    uint256 public constant version = 4;

    uint256 public constant ETH_SEPOLIA_CHAIN_ID = 11155111;
    uint256 public constant LOCAL_CHAIN_ID = 31337;
}

contract Helper is CodeConstants{
    struct NetworkConfig{
        address priceFeedAddress;
    }

    mapping (uint256 => address) priceFeed_chain_mapping;

    NetworkConfig public activeNetwork;

    constructor(uint256 chainid){
        if(chainid == LOCAL_CHAIN_ID){
            activeNetwork = createSepoliaConfigurtion();
        }
        else{
            activeNetwork = createLocalChainConfiguration();
        }
    }

    function getFeedAddress()public view returns(address){
        return activeNetwork.priceFeedAddress;
    }

    function createSepoliaConfigurtion()public returns(NetworkConfig memory){
        NetworkConfig memory config = NetworkConfig({priceFeedAddress: 0x694AA1769357215DE4FAC081bf1f309aDC325306});

        priceFeed_chain_mapping[ETH_SEPOLIA_CHAIN_ID] = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
        return config;
    }

    function createLocalChainConfiguration()public returns(NetworkConfig memory){
        //mock address
        NetworkConfig memory config = NetworkConfig({priceFeedAddress: 0x694AA1769357215DE4FAC081bf1f309aDC325306 /*mock address */});
        priceFeed_chain_mapping[LOCAL_CHAIN_ID] = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
        return config;
    }

}