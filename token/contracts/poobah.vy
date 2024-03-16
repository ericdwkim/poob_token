# @version >=0.2.16 < 0.3.7

from vyper.interfaces import ERC20

implements: ERC20

# Storage Variables
MAX_SUPPLY: constant(uint256) = 1000000
INIT_SUPPLY: constant(uint256) = 10000
totalSupply: public(uint256)
NAME: constant(String[10]) = "POOB"
DECIMALS: constant(uint256) = 18
balances: uint256

_balances: public(HashMap[address, uint256])
_allowance: public(HashMap[address, HashMap[address, uint256]])
totalSupply: public(uint256)

@external
def __init__(
    _token: address
    ):
    self.balances[msg.sender] = MAX_SUPPLY

@external
@view
def name() -> String[10]:
    return NAME

@external
@view
def totalSupply() -> uint256:
    return MAX_SUPPLY

@external
@view
def balanceOf(_owner: address) -> uint256:
    return _balances[address]

@internal
def _transfer(_from: address, _to: address, _value: uint256):
    assert not (_to in [self, ZERO_ADDRESS])
    self._balances[_from] -= _value
    self._balances[_to] += _value
    log Transfer(_from, _to, _value)

@external
def transfer(_to: address, _amount: uint256) -> bool:
    self._transfer(msg.sender, _to, _value)
    return True

@external
def transferFrom(_from: address, _to: address, _value: uint256) -> bool:
    if self._allowance[_from][msg.sender] < MAX_UINT256:
        self._allowance[_from][msg.sender] -= _value
    self._transfer(_from, _to, _value)
    return True

"""
@param _owner The addrs which owns POOB
@param _spender The addrs which spends POOB
@return the amount of POOB avalable for the spender
"""
@external
def allowance(_owner: address, _spender: address) -> uint256:
    return _allowed[_owner][_spender]

"""
@param _spender The addrs which spends POOB
@param _value The amount of POOB to be spent
@return Success boolean
"""

@external 
def approve(_spender: address, _value: uint256) -> bool:
    self._allowance[msg.sender][_spender] = _value
    log Approval(msg.sender, _spender, _value)

@external
def mint(_account: address, _value: uint256) -> bool:
    if self.totalSupply + _value <= MAX_SUPPLY:
        self.totalSupply += _value
        self.balances[_account] += _value

    log Transfer(empty(address), _account, _value)
    return True

event Transfer:
    sender: indexed(address)
    receiver: indexed(address)
    value: uint256

event Approval:
    owner: indexed(address)
    spender: indexed(address)
    value: uint256
