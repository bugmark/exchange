contract SimpleRegistry {

  mapping (bytes32 => string) public registry;

  function register(bytes32 key, string value) {
    registry[key] = value;
  }

  function get(bytes32 key) public constant returns(string) {
    return registry[key];
  }

}
