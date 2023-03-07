// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract MyERC721 is ERC721, Ownable {
    constructor() ERC721("MyToken", "MTK") {
        isOwner = msg.sender;
    }
    uint ERC20Price;
    address isOwner;

    
    function tokenPrice(uint price) public {
        ERC20Price = price;
    }

    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }

    function mintWithRRC20(address ERC20Address, uint256 tokenId) public {

        require(IERC20(ERC20Address).balanceOf(msg.sender) >= ERC20Price,"Balance Not Enough");

        _mint(msg.sender, tokenId);
        
        IERC20(ERC20Address).transferFrom(msg.sender, isOwner, ERC20Price);

    }

    function withdraw() public onlyOwner{

        require(IERC20(ERC20Address).balanceOf(address(this)) >=1, "No Balance Available");
        IERC20(ERC20Address).transfer(msg.sender, IERC20(ERC20Address).balanceOf(address(this)));
    }
    

}