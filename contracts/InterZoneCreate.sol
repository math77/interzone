// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;


import {InterZoneFactory} from "./InterZoneFactory.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";


contract InterZoneCreate is Ownable {

  InterZoneFactory private _interZoneFactoryAddress;

  constructor() Ownable() {}

  function createNewInterZone(
    string memory interZoneName, 
    string memory interZoneDescription,
    address initialOwner
  ) external returns (address newInterZoneAddress) {
    newInterZoneAddress = InterZoneFactory(_interZoneFactoryAddress).deployInterZone(interZoneName, interZoneDescription, initialOwner);
  }

  function setInterZoneFactoryAddress(InterZoneFactory factoryAddr) external onlyOwner {
    require(address(factoryAddr) != address(0), "CANNOT BE ZERO ADDRESS");

    _interZoneFactoryAddress = factoryAddr;
  }
}
