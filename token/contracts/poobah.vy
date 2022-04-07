# @version 0.2.16

from web3 import Web3

implements: ERC20

# Storage Variables
TOTAL_SUPPLY: constant(uint256) = 10**27 # 10**(9 + DECIMALS)
NAME: constant(String[10]) = "POOB Token"
DECIMALS: constant(uint256) = 18
# balances: uint256

# balances mappings
_balances: HashMap[address, uint256]

@external
def __init__():
    self.balances[msg.sender] = TOTAL_SUPPLY

# `->` notation is equivalent to `returns` 
@external
@view
def name() -> String[10]:
    return NAME

@external
@view
def totalSupply() -> uint256:
    return TOTAL_SUPPLY

@external
@view
def balanceOf(address: address) -> uint256:
    return _balances[address]

@external
# def transfer(_to: address, _amount: uint256) -> bool
#     assert self._balances[msg.sender] >= _amount, 'Insufficient balance'
#     return x