Certificate / Proof Registry

This smart contract is used to prove the authenticity of certificates on-chain.

Instead of storing the certificate itself, it stores a hash of the certificate, which acts as a permanent fingerprint.

What it does

Allows the owner (issuer) to issue a certificate hash

Prevents duplicate certificates

Allows the owner to revoke a certificate

Allows anyone to verify if a certificate is valid or revoked

How verification works

Hash the certificate off-chain (PDF / file / data)

Check the hash using the verify function

If issued and not revoked → certificate is valid

This ensures immutability, privacy, and public verifiability using blockchain.
