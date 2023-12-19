//SPDX-License-Identifier: MIT 

pragma solidity ^0.8.18;
import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {ProductStore} from "../src/ProductStore.sol";
import {MyToken} from "../src/MyToken.sol";
import {MyProductNft} from "../src/ProductNft.sol";

contract TestProductStore is Test{
    ProductStore productStore;
    MyToken myToken;
    MyProductNft myProductNft;
    
    function setUp() external {
        vm.prank(address(1));
        myToken = new MyToken(10000);
        myProductNft = new MyProductNft();
        productStore = new ProductStore(address(myToken), address(myProductNft));
    }

    function test_functions() public {
        productStore.listProduct("Product 1", 100);
        vm.prank(address(1));
        myToken.approve(address(productStore), 100);
        vm.prank(address(1));
        productStore.buyProduct(1);
    }

    function test_tokenURI() public {
        productStore.listProduct("Product 1", 100);
        vm.prank(address(1));
        myToken.approve(address(productStore), 100);
        vm.prank(address(1));
        productStore.buyProduct(1);
        console.log(myProductNft.tokenURI(1));
    }

    function testFail_ifNotMinted() public {
        vm.prank(address(1));
        console.log(myProductNft.tokenURI(2));
    }

    function testFail_ifAlreadySold() public {
        productStore.listProduct("Product 1", 100);
        vm.prank(address(1));
        myToken.approve(address(productStore), 100);
        vm.prank(address(1));
        productStore.buyProduct(1);
        productStore.buyProduct(1);
    }

}