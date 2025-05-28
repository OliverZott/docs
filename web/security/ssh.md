# SSH

## General

**Private Key** (id_rsa) → Stays secret on your local machine.

**Public Key** (id_rsa.pub) → Shared openly, placed on servers you connect to.

- When you try to SSH into a server, your private key signs the authentication request
- The server checks if the public key matches

## Generate

- `ssh-keygen`  ...often one SSH key for various apps
  - Set a Passphrase (optional but recommended) - When prompted, enter a passphrase for extra security.

- `ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa`
  - `-t rsa`  ...Uses RSA encryption algorithm
  - `-b 4096` ...Creates a 4096-bit key
  - `-f ~/.ssh/id_rsa` ...Saves the private key in your user .ssh folder

- Default location:
  - windows: `C:\Users\<user>\.ssh`
  - linux: `$HOME/.ssh/` or in short `~/.ssh`

## Example - DataGrip

To connect to external database with datagrip via SSH:

1. local machine: `ssh-keygen`
1. external server:

    ```shell
    sudo su
    nano /root/.ssh/authorized_keys  # add pub key from lcoal machine there
    ```

1. local machine: set private key in datagrip properties under SSH/SSL

## Cryptographic Breakdown of SSH Authentication

SSH uses the **RSA**, **ECDSA**, or **Ed25519** algorithm for key authentication.

- **RSA (Rivest-Shamir-Adleman**
  - Uses modular arithmetic for encryption/decryption
  - 2048-bit RSA is the minimum recommended, but 4096-bit is better for long-term security
  - Slower compared to Elliptic Curve Cryptography (ECC)
- **ECDSA (Elliptic Curve Digital Signature Algorithm)**
  - Uses Elliptic Curve Cryptography (ECC) instead of modular arithmetic
  - Usually 256-bit ECDSA is sufficient for most cases

- **Ed25519 (Curve25519-Based Algorithm**
  - Uses the Curve25519 elliptic curve
  - 256-bit Ed25519 is stronger than 4096-bit RSA, but with much smaller key sizes
  - Very strong against quantum computing threats

The process follows these cryptographic steps:

### **1 - Key Generation**

- **Private Key (`id_rsa`)** → Generated on the client machine.
- **Public Key (`id_rsa.pub`)** → Derived from the private key using a **one-way function** (cannot be reversed to obtain the private key).
- The public key is **uploaded to the server** (`~/.ssh/authorized_keys`).

### **2 - Client Starts Authentication**

- The SSH client wants to authenticate with the server and **does not** send the private key.
- Instead, the client requests access and signals that it will use public-key authentication.

### **3 - Server Issues a Challenge (Nonce)**

- The server **generates a random challenge** (a nonce) and sends it to the client.
- This nonce is unique for each session, ensuring that previous authentication attempts cannot be replayed.

### **4 - Client Signs the Challenge Using Its Private Key**

- The client **encrypts the nonce** using its **private key** and sends the **signed response** back.
- This signature is mathematically computed using the RSA (or ECDSA/Ed25519) algorithm:

  ```txt
  Signature = Encrypt(Nonce, PrivateKey)
  ```

- Since only the **correct private key** can generate a valid signature, this proves ownership.

### **5 - Server Verifies the Signature**

- The server **decrypts** the signature using the **stored public key**:

  ```txt
  DecryptedNonce = Decrypt(Signature, PublicKey)
  ```

- If the decrypted nonce **matches the original** challenge sent earlier, authentication succeeds.

### **6 - Secure Session Established**

- If authentication passes, the client is granted access.
- At this point, **SSH starts encrypting** all communication using **symmetric encryption** (AES, ChaCha20, etc.).
- The session remains secure, preventing eavesdropping or interception.
