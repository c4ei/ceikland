/**
 * https://snowtrace.io/address/0x096BBfB78311227b805c968b070a81D358c13379#code
Contract Name: StakingHelper
Compiler Version: v0.7.5+commit.eb77ed08
Optimization Enabled: Yes with 200 runs
Other Settings: default evmVersion, GNU AGPLv3 license

-----Decoded View---------------
Arg [0] : _staking (address): 0x41A611C1Ad5cF78BA56Db7CA85ab57dB2b32d6Aa <-- 0x4456b87af11e87e329ab7d7c7a246ed1ac2168b9
Arg [1] : _Time (address): 0x5c38E12d3bb0AdE04B3305C7461A1Cfd08F258D9 <-- 0xb54f16fb19478766a268f172c9480f8da1a7c9c3

#############################################################
contract address : 0x2D5277D332c66F214066A174dde5F61bE427E655
#############################################################

*/

// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.7.5;


interface IERC20 {
    function decimals() external view returns (uint8);
  /**
   * @dev Returns the amount of tokens in existence.
   */
  function totalSupply() external view returns (uint256);

  /**
   * @dev Returns the amount of tokens owned by `account`.
   */
  function balanceOf(address account) external view returns (uint256);

  /**
   * @dev Moves `amount` tokens from the caller's account to `recipient`.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transfer(address recipient, uint256 amount) external returns (bool);

  /**
   * @dev Returns the remaining number of tokens that `spender` will be
   * allowed to spend on behalf of `owner` through {transferFrom}. This is
   * zero by default.
   *
   * This value changes when {approve} or {transferFrom} are called.
   */
  function allowance(address owner, address spender) external view returns (uint256);

  /**
   * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * IMPORTANT: Beware that changing an allowance with this method brings the risk
   * that someone may use both the old and the new allowance by unfortunate
   * transaction ordering. One possible solution to mitigate this race
   * condition is to first reduce the spender's allowance to 0 and set the
   * desired value afterwards:
   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
   *
   * Emits an {Approval} event.
   */
  function approve(address spender, uint256 amount) external returns (bool);

  /**
   * @dev Moves `amount` tokens from `sender` to `recipient` using the
   * allowance mechanism. `amount` is then deducted from the caller's
   * allowance.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

  /**
   * @dev Emitted when `value` tokens are moved from one account (`from`) to
   * another (`to`).
   *
   * Note that `value` may be zero.
   */
  event Transfer(address indexed from, address indexed to, uint256 value);

  /**
   * @dev Emitted when the allowance of a `spender` for an `owner` is set by
   * a call to {approve}. `value` is the new allowance.
   */
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

interface IStaking {
    function stake( uint _amount, address _recipient ) external returns ( bool );
    function claim( address _recipient ) external;
}

contract StakingHelper {

    address public immutable staking;
    address public immutable Time;

    constructor ( address _staking, address _Time ) {
        require( _staking != address(0) );
        staking = _staking;
        require( _Time != address(0) );
        Time = _Time;
    }

    function stake( uint _amount, address recipient ) external {
        IERC20( Time ).transferFrom( msg.sender, address(this), _amount );
        IERC20( Time ).approve( staking, _amount );
        IStaking( staking ).stake( _amount, recipient );
        IStaking( staking ).claim( recipient );
    }
}