pragma solidity 0.6.2;

//based https://swcregistry.io/docs/SWC-133#access-controlsol

//line 61

library ECDSA {
    function recover(bytes32 hash, bytes memory signature) internal pure returns (address) {
        // Check the signature length
        if (signature.length != 65) {
            revert("ECDSA: invalid signature length");
        }

        // Divide the signature in r, s and v variables
        bytes32 r;
        bytes32 s;
        uint8 v;

        assembly {
            r := mload(add(signature, 0x20))
            s := mload(add(signature, 0x40))
            v := byte(0, mload(add(signature, 0x60)))
        }

        if (uint256(s) > 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5D576E7357A4501DDFE92F46681B20A0) {
            revert("ECDSA: invalid signature 's' value");
        }

        if (v != 27 && v != 28) {
            revert("ECDSA: invalid signature 'v' value");
        }

        // If the signature is valid (and not malleable), return the signer address
        address signer = ecrecover(hash, v, r, s);
        require(signer != address(0), "ECDSA: invalid signature");

        return signer;
    }

    function toEthSignedMessageHash(bytes32 hash) internal pure returns (bytes32) {
        // 32 is the length in bytes of hash,
        // enforced by the type signature above
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
    }
}

contract HashCollision {
    using ECDSA for bytes32;
    mapping(address => bool) isAdmin;
    mapping(address => bool) isRegularUser;
    // Add admins and regular users.
    function addUsers(
        address[] calldata admins,
        address[] calldata regularUsers,
        bytes calldata signature
    )
        external
    {
        if (!isAdmin[msg.sender]) {
            // Allow calls to be relayed with an admin's signature.
            //Because abi.encodePacked() packs all parameters in order, regardless of whether the parameters are part of an array, the user can move elements within or between arrays. As long as all elements are in the same order, abi.encodePacked() will return the same result. In some cases, using abi.encodePacked() with multiple variable-length parameters can cause hash collisions.
            bytes32 hash = keccak256(abi.encodePacked(admins, regularUsers));
            address signer = hash.toEthSignedMessageHash().recover(signature);
            require(isAdmin[signer], "Only admins can add users.");
        }
        for (uint256 i = 0; i < admins.length; i++) {
            isAdmin[admins[i]] = true;
        }
        for (uint256 i = 0; i < regularUsers.length; i++) {
            isRegularUser[regularUsers[i]] = true;
        }
    }
}