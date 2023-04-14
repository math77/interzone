// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;


import {IMetadataRenderer} from "./interfaces/IMetadataRenderer.sol";

import { Base64 } from "./libraries/Base64.sol";


contract InterZoneMetadata is IMetadataRenderer {


  string[] public colors = ["#fff44f", "#9acd32","#006adf","#cd56ff","#ffa800", "#df1b1b"];


  function tokenURI(uint256 tokenId, uint256 colorId) external view override returns (string memory) {
    
    return string(
      abi.encodePacked(
        'data:application/json;base64,',
        Base64.encode(
          abi.encodePacked(
            '{"name":"InterZoneNoWhere #',
            toString(tokenId),
            '","description": "NoWhere",',
            '","image": "data:image/svg+xml;base64,',
            Base64.encode(makeSvg(colorId)),
            '"}'
          ))));
  }

  function makeSvg(uint256 colorId) public view returns (bytes memory) {
    string memory svgHead = "<svg width='551' height='550' viewBox='0 0 551 550' fill='none' xmlns='http://www.w3.org/2000/svg'> <rect width='550' height='550' fill='black'/><g filter='url(#filter0_f_406_22)'> <circle cx='275' cy='275' r='100' fill='";
    string memory svgEnd = "<line x1='78.5' y1='92' x2='78.5' y2='109' stroke='white' stroke-width='3'/> <line x1='148.5' y1='82' x2='148.5' y2='99' stroke='white' stroke-width='3'/> <line x1='128.5' y1='82' x2='128.5' y2='99' stroke='white' stroke-width='3'/> <line x1='98.5' y1='85' x2='98.5' y2='102' stroke='white' stroke-width='3'/> <path d='M196.454 59.2756C196.894 61.7699 195.203 64.6762 191.359 67.8343C187.551 70.9628 181.781 74.2096 174.459 77.3794C159.822 83.7156 139.087 89.6995 115.726 93.8186C92.3655 97.9378 70.8342 99.4066 54.9128 98.4586C46.948 97.9843 40.4156 96.9068 35.7672 95.2694C31.0747 93.6165 28.492 91.4637 28.0522 88.9694C27.6124 86.4751 29.3031 83.5688 33.1472 80.4107C36.9553 77.2822 42.7252 74.0354 50.0474 70.8656C64.6844 64.5293 85.4196 58.5455 108.78 54.4263C132.141 50.3072 153.672 48.8384 169.594 49.7864C177.558 50.2606 184.091 51.3382 188.739 52.9756C193.432 54.6285 196.015 56.7813 196.454 59.2756Z' fill='#205A7B' stroke='black'/> <path d='M135.68 49.9046C135.936 51.3572 135.455 52.9204 134.26 54.529C133.065 56.1388 131.182 57.7541 128.729 59.275C123.826 62.3151 116.737 64.9222 108.625 66.3525C100.513 67.7828 92.9599 67.7577 87.3128 66.5778C84.4878 65.9875 82.1658 65.1137 80.4919 64.0098C78.8191 62.9068 77.8323 61.6025 77.5762 60.1498C77.32 58.6972 77.8012 57.134 78.9958 55.5254C80.1913 53.9156 82.0743 52.3003 84.5271 50.7794C89.4301 47.7392 96.5192 45.1322 104.631 43.7019C112.743 42.2716 120.296 42.2967 125.943 43.4766C128.768 44.0669 131.09 44.9407 132.764 46.0446C134.437 47.1476 135.424 48.4519 135.68 49.9046Z' fill='#205A7B' stroke='black'/> <circle cx='59.5' cy='74.5' r='2.5' fill='#F6FB10'/> <circle cx='93.5' cy='79.5' r='2.5' fill='#F6FB10'/> <circle cx='135.5' cy='71.5' r='2.5' fill='#F6FB10'/> <circle cx='160.5' cy='56.5' r='2.5' fill='#F6FB10'/> <g filter='url(#filter1_f_406_22)'> <path d='M484.854 271.067C499.59 302.667 494.01 340.163 472.963 375.278C451.918 410.39 415.432 443.069 368.482 464.962C321.531 486.856 273.045 493.8 232.62 487.352C192.192 480.903 159.882 461.076 145.146 429.475C130.41 397.874 135.99 360.378 157.037 325.263C178.082 290.151 214.568 257.473 261.518 235.579C308.469 213.686 356.955 206.742 397.38 213.19C437.808 219.638 470.118 239.466 484.854 271.067Z' stroke='white'/> </g> <g filter='url(#filter2_f_406_22)'> <path d='M460.483 285.842C472.056 310.661 466.819 340.536 448.855 368.82C430.893 397.098 400.244 423.718 361.15 441.948C322.055 460.178 281.962 466.546 248.755 462.128C215.541 457.71 189.288 442.518 177.715 417.699C166.142 392.88 171.379 363.004 189.343 334.721C207.305 306.443 237.954 279.823 277.048 261.593C316.142 243.363 356.236 236.995 389.443 241.412C422.657 245.831 448.91 261.023 460.483 285.842Z' stroke='white'/> </g> <g filter='url(#filter3_f_406_22)'> <path d='M418.721 306.527C424.426 318.761 419.076 334.909 405.462 351.22C391.876 367.498 370.175 383.781 343.572 396.186C316.97 408.591 290.547 414.748 269.345 414.693C248.099 414.638 232.289 408.356 226.584 396.122C220.879 383.887 226.229 367.739 239.844 351.428C253.43 335.15 275.131 318.867 301.733 306.462C328.336 294.057 354.758 287.9 375.961 287.955C397.207 288.011 413.016 294.292 418.721 306.527Z' stroke='white'/> </g> <g filter='url(#filter4_f_406_22)'> <path d='M311.264 374.941L311.987 329.46L351.736 351.575L311.264 374.941Z' stroke='#FDF300'/> </g> <path d='M550 55L338.442 81.1059L209.87 145.367L111.688 260.835L72.5325 387.348L55 491.772V548' stroke='#EF0EF3' stroke-width='2'/> <defs> <filter id='filter0_f_406_22' x='135' y='135' width='280' height='280' filterUnits='userSpaceOnUse' color-interpolation-filters='sRGB'> <feFlood flood-opacity='0' result='BackgroundImageFix'/> <feBlend mode='normal' in='SourceGraphic' in2='BackgroundImageFix' result='shape'/> <feGaussianBlur stdDeviation='20' result='effect1_foregroundBlur_406_22'/> </filter> <filter id='filter1_f_406_22' x='132.382' y='206.382' width='365.237' height='287.777' filterUnits='userSpaceOnUse' color-interpolation-filters='sRGB'> <feFlood flood-opacity='0' result='BackgroundImageFix'/> <feBlend mode='normal' in='SourceGraphic' in2='BackgroundImageFix' result='shape'/> <feGaussianBlur stdDeviation='2' result='effect1_foregroundBlur_406_22'/> </filter> <filter id='filter2_f_406_22' x='167.061' y='235.564' width='304.077' height='232.412' filterUnits='userSpaceOnUse' color-interpolation-filters='sRGB'> <feFlood flood-opacity='0' result='BackgroundImageFix'/> <feBlend mode='normal' in='SourceGraphic' in2='BackgroundImageFix' result='shape'/> <feGaussianBlur stdDeviation='2' result='effect1_foregroundBlur_406_22'/> </filter> <filter id='filter3_f_406_22' x='219.824' y='283.455' width='205.657' height='135.738' filterUnits='userSpaceOnUse' color-interpolation-filters='sRGB'> <feFlood flood-opacity='0' result='BackgroundImageFix'/> <feBlend mode='normal' in='SourceGraphic' in2='BackgroundImageFix' result='shape'/> <feGaussianBlur stdDeviation='2' result='effect1_foregroundBlur_406_22'/> </filter> <filter id='filter4_f_406_22' x='306.75' y='324.617' width='50' height='55.1982' filterUnits='userSpaceOnUse' color-interpolation-filters='sRGB'> <feFlood flood-opacity='0' result='BackgroundImageFix'/> <feBlend mode='normal' in='SourceGraphic' in2='BackgroundImageFix' result='shape'/> <feGaussianBlur stdDeviation='2' result='effect1_foregroundBlur_406_22'/> </filter> </defs> </svg>";

    return abi.encodePacked(svgHead, colors[colorId], "'/> </g>", svgEnd);

  }

  function toString(uint256 value) internal pure returns (string memory) {
    // Inspired by OraclizeAPI's implementation - MIT license
    // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

    if (value == 0) {
      return "0";
    }
    uint256 temp = value;
    uint256 digits;
    while (temp != 0) {
      digits++;
      temp /= 10;
    }
    bytes memory buffer = new bytes(digits);
    while (value != 0) {
      digits -= 1;
      buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
      value /= 10;
    }
    return string(buffer);
  }

}
