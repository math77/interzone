// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;


import {ERC721Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import {ReentrancyGuardUpgradeable} from "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";

import {IMetadataRenderer} from "./interfaces/IMetadataRenderer.sol";


import {InterZoneCreate} from "./InterZoneCreate.sol";
import {OwnableSkeleton} from "./OwnableSkeleton.sol";


contract InterZone is ERC721Upgradeable, ReentrancyGuardUpgradeable, OwnableSkeleton {

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
  error NotContractOwner();
  error SupplySoldOut();


  modifier onlyOwner() { 
    if(owner() != _msgSender()) revert NotContractOwner(); 
    _; 
  }
  

  function initialize(
    string memory _interZoneName,
    string memory _interZoneDescription,
    address _initialOwner
  ) external initializer {

    __ERC721_init(_interZoneName, _interZoneDescription);
    __ReentrancyGuard_init();

    _setOwner(_initialOwner);
  }


  function mint() external nonReentrant {

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

  function setNewOwner(address newOwner) external onlyOwner {
    _setOwner(newOwner);
  }

}
