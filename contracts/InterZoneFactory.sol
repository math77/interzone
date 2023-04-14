// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import {Clones} from "@openzeppelin/contracts/proxy/Clones.sol";
import {InterZone} from "./InterZone.sol";


contract InterZoneFactory {

  using Clones for address;

  address public immutable interZoneImplementation;
  address private _interZoneCreateAddress;

  address public owner;

  error AddressCannotBeZero();
  error InvalidCaller();
  error OnlyOwner();


  modifier onlyOwner() {
    if(msg.sender != owner) {
      revert OnlyOwner();
    }
    _;
  }

  modifier onlyInterZoneCreateContract() { 
    if(msg.sender != _interZoneCreateAddress) revert InvalidCaller();
    _; 
  }

  constructor(address _implementation) {
    if(_implementation == address(0)) revert AddressCannotBeZero();

    interZoneImplementation = _implementation;
  }


  function deployInterZone(
    string memory interZoneName,
    string memory interZoneDescription,
    address initialOwner
  ) external onlyInterZoneCreateContract returns (address) {
    address _newInterZone = interZoneImplementation.clone();

    InterZone(_newInterZone).initialize({
      _interZoneName: interZoneName,
      _interZoneDescription: interZoneDescription,
      _initialOwner: initialOwner
    });

    return _newInterZone;
  }

  function setInterZoneCreateAddress(address interZoneCreateAddress) external onlyOwner {
    if(interZoneCreateAddress == address(0)) revert AddressCannotBeZero();

    _interZoneCreateAddress = interZoneCreateAddress;
  }
}
