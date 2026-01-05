// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CertificateRegistry {
  

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    struct Certificate {
        bool issued;       
        bool revoked;      
        address issuer;    
        uint256 issuedAt;   
    }
   mapping(bytes32 => Certificate) private certificates;


    /// @notice Issue a new certificate (hash)
    function issue(bytes32 certHash) external onlyOwner {
        
        require(!certificates[certHash].issued, "Already issued");

        certificates[certHash] = Certificate({
            issued: true,
            revoked: false,
            issuer: msg.sender,
            issuedAt: block.timestamp
        });
    }

    /// @notice Revoke an existing certificate
    function revoke(bytes32 certHash) external onlyOwner {
        require(certificates[certHash].issued, "Not issued");
        require(!certificates[certHash].revoked, "Already revoked");

        certificates[certHash].revoked = true;
    }

   

    /// @notice Verify certificate validity
    function verify(bytes32 certHash)
        external
        view
        returns (bool isValid, bool isRevoked)
    {
        Certificate memory cert = certificates[certHash];

        isValid = cert.issued && !cert.revoked;
        isRevoked = cert.revoked;
    }

    /// @notice Get full certificate details (optional)
    function getCertificate(bytes32 certHash)
        external
        view
        returns (
            bool issued,
            bool revoked,
            address issuer,
            uint256 issuedAt
        )
    {
        Certificate memory cert = certificates[certHash];
        return (cert.issued, cert.revoked, cert.issuer, cert.issuedAt);
    }
}
