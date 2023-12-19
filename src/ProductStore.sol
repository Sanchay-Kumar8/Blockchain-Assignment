//SPDX-License-Identifier: MIT 

pragma solidity ^0.8.18;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract ProductStore {
    
    address public owner;

    IERC20 public tokenAddress;
    IERC721 public nftAddress;

    struct Product {
        string name;
        uint price;
        bool ifSold;
        address ownerOfProduct;
    }

    Product[] public products;
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    receive() external payable {}

    constructor(address _tokenAddress, address _nftAddress) {
        tokenAddress = IERC20(_tokenAddress);
        nftAddress = IERC721(_nftAddress);
        owner = msg.sender;
    }

    function listProduct(string memory _name, uint _price) public onlyOwner{
        Product memory product;
        product.name = _name;
        product.price = _price;
        product.ifSold = false;
        product.ownerOfProduct = msg.sender;
        products.push(product);
        
    }

    function buyProduct(uint _tokenId) public {
        require(tokenAddress.balanceOf(msg.sender) >= products[_tokenId - 1].price, "You do not have enough tokens to but this product");
        require(_tokenId > 0 && _tokenId <= products.length, "Invalid tokenId");
        require(!products[_tokenId - 1].ifSold, "Product has been sold");
        require(msg.sender != owner, "You cannot buy your own product");

        tokenAddress.transferFrom(msg.sender, address(this), products[_tokenId - 1].price);
        products[_tokenId - 1].ifSold = true;
        products[_tokenId - 1].ownerOfProduct = msg.sender;
        IERC721(nftAddress).mint(msg.sender, _tokenId);

    }
}
