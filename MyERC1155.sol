// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract MyERC1155 is ERC1155, Ownable {
    constructor() ERC1155("") {
        isOwner = msg.sender;
    }

    address isOwner;

    function mint(address account, uint256 id, uint256 amount, bytes memory data)
        public
        onlyOwner
    {
        _mint(account, id, amount, data);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }


    function mintWithERC721(address ERC721Address, uint256 tokenId) public {

        require(IERC721(ERC721Address).balanceOf(msg.sender) >= 1);
       
        _mint(msg.sender, tokenId, 1, "");

        IERC721(ERC721Address).transferFrom(msg.sender, isOwner, tokenId);

    }
}