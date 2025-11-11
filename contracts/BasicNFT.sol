// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.30;

contract BasicNFT {
    mapping(uint256 => address) public owners;

    mapping(address => uint256) public balance;

    uint256 public nextTokenId;

    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed tokenId
    );

    function mint(address to) external returns (uint256) {
        require(to != address(0), "Cannot mint to zero address");

        uint256 tokenId = nextTokenId;
        owners[tokenId] = to;
        balance[to]++;

        emit Transfer(address(0), to, tokenId);

        return tokenId;
    }

    function transfer(address to, uint256 tokenId) external {
        require(owners[tokenId] == msg.sender, "not owner");
        require(to != address(0), "Cannot transfer to zero address");

        address from = msg.sender;

        owners[tokenId] = to;

        balance[from]--;
        balance[to]++;

        emit Transfer(from, to, tokenId);
    }

    function ownerOf(uint256 tokenId) external view returns (address) {
        address owner = owners[tokenId];
        require(owner != address(0), "Token doesn't exist");
        return owner;
    }

    function balanceOf(address owner) external view returns (uint256) {
        require(owner != address(0), "Invalid Proccess");
        return balance[owner];
    }
}
