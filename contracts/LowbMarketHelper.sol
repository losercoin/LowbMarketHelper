// contracts/LowbMarket.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./LowbMarket.sol";

contract LowbMarketHelper {

    address public lowbMarketAddress;

    constructor(address lowbMarket_) {
        lowbMarketAddress = lowbMarket_;
    }

    function getOffers(uint from, uint to) public view returns (LowbMarket.Offer[] memory) {
        require(from > 0 && to >= from, "Invalid index");
        LowbMarket market = LowbMarket(lowbMarketAddress);
        LowbMarket.Offer[] memory offers = new LowbMarket.Offer[](to-from+1);
        for (uint i=from; i<=to; i++) {
            offers[i-from] = market.itemsOfferedForSale(i);
        }
        return offers;
    }

    function getNewOffers(uint from, uint to) public view returns (uint[] memory) {
        require(from > 0 && to >= from, "Invalid index");
        LowbMarket market = LowbMarket(lowbMarketAddress);
        uint[] memory offers = new uint[](to-from+1);
        for (uint i=from; i<=to; i++) {
            offers[i-from] = market.newTokenOffer(i);
        }
        return offers;
    }

    function getBidsOf(address addr, uint from, uint to) public view returns (LowbMarket.Bid[] memory) {
        require(from > 0 && to >= from, "Invalid index");
        LowbMarket market = LowbMarket(lowbMarketAddress);
        LowbMarket.Bid[] memory bids = new LowbMarket.Bid[](to-from+1);
        for (uint i=from; i<=to; i++) {
            bids[i-from] = market.itemBids(i, addr);
        }
        return bids;
    }

    function getHighestBids(uint from, uint to) public view returns (LowbMarket.Bid[] memory) {
        require(from > 0 && to >= from, "Invalid index");
        LowbMarket market = LowbMarket(lowbMarketAddress);
        LowbMarket.Bid[] memory bids = new LowbMarket.Bid[](to-from+1);
        LowbMarket.Bid memory bid;
        for (uint i=from; i<=to; i++) {
            bid = market.itemBids(i, address(0));
            while (bid.nextBidder != address(0)) {
                bid = market.itemBids(i, bid.nextBidder);
                if (bid.value >= bids[i-from].value) {
                    bids[i-from] = bid;
                }
            }
        }
        return bids;
    }
}