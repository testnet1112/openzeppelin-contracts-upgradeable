pragma solidity ^0.5.0;

import "zos-lib/contracts/Initializable.sol";
import "./ERC20Detailed.sol";
import "./ERC20Mintable.sol";
import "./ERC20Pausable.sol";


/**
 * @title Standard ERC20 token, with minting and pause functionality.
 *
 */
contract StandaloneERC20 is Initializable, ERC20Detailed, ERC20Mintable, ERC20Pausable {
    function initialize(
        string memory name, string memory symbol, uint8 decimals, uint256 initialSupply, address initialHolder,
        address[] memory minters, address[] memory pausers, address sender
    ) public initializer {
        ERC20Detailed.initialize(name, symbol, decimals);

        // Mint the initial supply
        _mint(initialHolder, initialSupply);

        // Initialize the minter and pauser roles, and renounce them
        ERC20Mintable.initialize(sender);
        _removeMinter(sender);

        ERC20Pausable.initialize(sender);
        _removePauser(sender);

        // Add the requested minters and pausers (this can be done after renouncing since
        // these are the internal calls)
        for (uint256 i = 0; i < minters.length; ++i) {
            _addMinter(minters[i]);
        }

        for (uint256 i = 0; i < pausers.length; ++i) {
            _addPauser(pausers[i]);
        }
    }

    function initialize(
        string memory name, string memory symbol, uint8 decimals, address[] memory minters, address[] memory pausers, address sender
    ) public initializer {
        ERC20Detailed.initialize(name, symbol, decimals);

        // Initialize the minter and pauser roles, and renounce them
        ERC20Mintable.initialize(sender);
        _removeMinter(sender);

        ERC20Pausable.initialize(sender);
        _removePauser(sender);

        // Add the requested minters and pausers (this can be done after renouncing since
        // these are the internal calls)
        for (uint256 i = 0; i < minters.length; ++i) {
            _addMinter(minters[i]);
        }

        for (uint256 i = 0; i < pausers.length; ++i) {
            _addPauser(pausers[i]);
        }
    }

    uint256[50] private ______gap;
}