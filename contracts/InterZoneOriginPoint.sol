// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";

import {IMetadataRenderer} from "./interfaces/IMetadataRenderer.sol";

import {InterZoneCreate} from "./InterZoneCreate.sol";
import {InterZone} from "./InterZone.sol";


contract InterZoneOriginPoint is ERC721, ReentrancyGuard, Ownable {

  uint256 private _tokenId;
  uint256 private constant MAX_SUPPLY = 10;

  struct InterZoneData {
    address owner;
    address interZoneAddress;
    uint8 colorId;
  }

  IMetadataRenderer public renderer;
  InterZoneCreate private _interZoneCreateAddress;

  mapping(uint256 tokenId => InterZoneData interZoneData) public interZoneDataToTokenId;


  error NonexistentToken();
  error SupplySoldOut();
  

  constructor() ERC721("InterZoneOriginPoint", "ZONEORIGIN") Ownable() {}


  function mint() external payable nonReentrant {

    if(_tokenId == MAX_SUPPLY) revert SupplySoldOut();

    unchecked {
      _mint(msg.sender, _tokenId++);
    }

    address interZoneAddress = InterZoneCreate(_interZoneCreateAddress).createNewInterZone("", "", _msgSender());

    interZoneDataToTokenId[_tokenId] = InterZoneData({
      owner: msg.sender,
      interZoneAddress: interZoneAddress,
      colorId: uint8(uint256(keccak256(abi.encodePacked(block.timestamp, interZoneAddress)))) % 6
    });
  }

  function tokenURI(uint256 tokenId) public view override returns (string memory) {

    if(!_exists(tokenId)) {
      revert NonexistentToken();
    }

    return renderer.tokenURI(tokenId, interZoneDataToTokenId[tokenId].colorId);
  }

  function setInterZoneCreateAddress(InterZoneCreate interZoneCreateAddress) external onlyOwner {
    _interZoneCreateAddress = interZoneCreateAddress;
  }

  function setRenderer(IMetadataRenderer newRenderer) external onlyOwner {
    renderer = newRenderer;
  }


  function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 /*batchSize*/) internal virtual override {
    if(from != address(0)) {

      interZoneDataToTokenId[tokenId].owner = to;

      address contractAddr = interZoneDataToTokenId[tokenId].interZoneAddress;

      InterZone(contractAddr).setNewOwner(to);
    }
  }

}
