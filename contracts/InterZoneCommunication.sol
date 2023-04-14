//SPDX-License-Identifier: Unlicense
pragma solidity 0.8.18;

import "./lzApp/NonblockingLzApp.sol";


/**
 * The contractName contract does this and that...
 */
abstract contract InterZoneCommunication is NonblockingLzApp {

  enum PayloadType { 
    MintNewZone
  }

  constructor(address _lzEndpoint) NonblockingLzApp(_lzEndpoint) {}

  function _nonblockingLzReceive(uint16 _srcChainId, bytes memory _srcAddress, uint64, bytes memory _payload) internal virtual override {}

  //bytes calldata _adapterParams
  function sendMessage(uint16 _dstChainId, address payable _refundAddress, bytes memory _payload, uint256 fee) internal {

    //dstchainid, payload, refundAddr, zropayaddr, adapparams, msg.value
    _lzSend(_dstChainId, _payload, _refundAddress, address(0x0), bytes(""), fee);
  }

  function _createPayload(uint256 value, PayloadType ptype, address emitter) internal returns(bytes memory) {
    uint256[] memory arr;
    return abi.encode(arr, value, ptype, emitter);
  }

  function _createPayload(uint256[] memory values, uint256 value, PayloadType ptype, address emitter) internal returns(bytes memory) {
    return abi.encode(values, value, ptype, emitter);
  }
}
