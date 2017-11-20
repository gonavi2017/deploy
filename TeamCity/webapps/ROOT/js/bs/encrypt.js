// requires all files from the "crypt" directory

BS.Encrypt = {

  encryptData: function(data, publicKey) {
    BS.Crypto.rng_seed_time();

    var rsa = new BS.Crypto.RSAKey();
    rsa.setPublic(publicKey, "10001");
    return rsa.encrypt(data);
  }
};