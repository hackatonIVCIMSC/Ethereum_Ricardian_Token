contract CIMSToken {
    function receiveApproval(address _from, uint256 _value, address _token,
    bytes _extraData);

    /* Public variables of the token */
    string public standard = 'Token 0.1';
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    address owner;
    address logoAddr;

    uint validStart;
    uint validEnd;

    mapping (address => uint256) redeemHistory;

    uint256 totalRedeem;

    /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;

    string[] merchandises; /* Provides restrictions on the object to be claimed. Domain-specific meaning of the voucher */
    string[] definitions;  /* Includes terms and definitions that generally desire to be defined in a contract */
    string[] conditions;

    /* This generates a public event on the blockchain that will notify clients */
    event Transfer(address indexed from, address indexed to, uint256 value, uint timestamp);

    /* This notifies clients about the amount burnt */
    event Burn(address indexed from, uint256 value);

    event Redeem(address _from, address _to, uint256 _value, uint timestamp);

    event SubmissionProvider(address providerAddr, string shortname, uint timestamp);

    event ApprovalProvider(address providerAddr, uint timestamp);

    event SubmitPromise(address providerAddr, uint promise, uint timestamp);

    event AcceptPromise (address providerAddr, uint allowance, uint timestamp);

    event Sale(address buyer, address provider, uint256 value, string description,
        uint timestamp);

    struct Providers {
        bool member;
        string _brandname; /* the name you are normally known by in the street */
        string _shortname; /* short name is displayed by trading software, 8 chars */
        string _longname; /* full legal name */
        string _postAddress; /* formal address for snail-mail notices*/
        string _country; /* two letter ISO code that indicates the jurisdiction */
        string _registration; /* legal registration code of the legal person or legal entity */
        address _registryBzz; /* swarm hash of the signer human readable registry document */
        uint promise;
        uint sales;
        uint256 allowance;
    }


    address[] providerIndex;
    mapping(address=>Providers) provider;

    modifier onlyOwner {
       if (msg.sender != owner) throw;
       _;
    }

    modifier onlyProvider {
       bool check;
       if(balanceOf[msg.sender]!=0) throw; _;
    }

    /* Initializes contract with initial supply tokens to the creator of the contract */
    function MyToken() {
        totalSupply = 100000000;		/* Update total supply */
        balanceOf[msg.sender] = totalSupply;	/* Give the creator all initial tokens */
        name = "kgEqC";		/* Set the name for display purposes */
        symbol = "Џ";		/* Set the symbol for display purposes */
        decimals = 2;		/* Amount of decimals for display purposes */
        addProvider("KOMPU A.C.M.S.", "KOMPU",
            "NAFED HOUSE, Siddhartha Enclave, Ashram Chowk, New Delhi 110 014, India",
            "Kompu Agricultural co-operative Marketing Society","India","91-11-26341807",
            0x0);
        validStart = now + 30 * 1 days;
        validEnd = now + 1000 * 1 days;
    }

    function addMerchandise(uint index, string merchandise) onlyOwner {
        merchandises[index] = merchandise;
    }

    function addDefinitions (uint index, string definition) onlyOwner {
        definitions[index] = definition;
    }

    function addConditions (uint index, string condition) onlyOwner {
        conditions[index] = condition;
    }

     function addProvider (string brandnameNew, string shortnameNew,
        string memory longnameNew, string addressNew, string countryNew,
        string registrationNew,
        address registryBzzNew) {

	    provider[msg.sender]._brandname = brandnameNew;
        provider[msg.sender]._shortname = shortnameNew;
        provider[msg.sender]._longname = longnameNew;
        provider[msg.sender]._postAddress = addressNew;
        provider[msg.sender]._country = countryNew;
        provider[msg.sender]._registration = registrationNew;
        provider[msg.sender]._registryBzz = registryBzzNew;

        SubmissionProvider (msg.sender, shortnameNew, now);

    }

    function getProviderAddressByIndex(uint index) constant returns (address) {
        return providerIndex[index];
    }

    function getProviderInfo (address providerAddr)
        constant returns (bool, string, string, string, string, string, string,
            address, uint, uint, uint256) {

        return (provider[providerAddr].member, provider[providerAddr]._brandname,
                provider[providerAddr]._shortname, provider[providerAddr]._longname,
                provider[providerAddr]._postAddress, provider[providerAddr]._country,
                provider[providerAddr]._registration, provider[providerAddr]._registryBzz,
                provider[providerAddr].promise, provider[providerAddr].sales,
                provider[providerAddr].allowance);
    }

    function approveProvider(address providerAddr) onlyOwner {
        provider[providerAddr].member = true;
        providerIndex[providerIndex.length++]=msg.sender;
        ApprovalProvider(providerAddr, now);
    }

    function submitPromise(uint promiseNew) onlyOwner returns (bool) {
        provider[msg.sender].promise = promiseNew;
        return true;
    }

    function acceptPromise(address providerAddr) returns (bool){
        provider[providerAddr].allowance = provider[providerAddr].promise;

        return true;
    }

    /* Send coins */
    function transfer(address _to, uint256 _value) {
        if (_to == 0x0) throw;
        if (balanceOf[msg.sender] < _value) throw;
        if (balanceOf[_to] + _value < balanceOf[_to]) throw; /* Check for overflows */
        balanceOf[msg.sender] -= _value;    /* Subtract from the sender */
        balanceOf[_to] += _value;           /* Add the same to the recipient */
        Transfer(msg.sender, _to, _value, now);  /* Notify anyone listening that this transfer took place */
    }

    /* Get Allowance*/
    function withdrawAllowance(uint value) {
        if (provider[msg.sender].allowance < value) {
            throw;
        } else {
            balanceOf[msg.sender] += value;
            provider[msg.sender].allowance -= value;
            totalSupply += value;
        }
    }

    /* updateProvider */
    function updateProvider (string brandnameNew, string shortnameNew,
        string longnameNew, string memory _longname, string addressNew,
        string countryNew, string registrationNew, address registryBzzNew) {

	    provider[msg.sender]._brandname = brandnameNew;
        provider[msg.sender]._shortname = shortnameNew;
        provider[msg.sender]._longname = longnameNew;
        provider[msg.sender]._postAddress = addressNew;
        provider[msg.sender]._country = countryNew;
        provider[msg.sender]._registration = registrationNew;
        provider[msg.sender]._registryBzz = registryBzzNew;
    }

    function redeemFrom (address providerAddr, uint256 _value, string buildDescription)
        returns (bool) {

        bool isProvider = false;

        for(uint i=0; i<providerIndex.length; i++) {
            if(providerIndex[i] == providerAddr) {
                isProvider = true;
                break;
            }
        }

        if (isProvider) {
            if (balanceOf[msg.sender] < _value) throw;   /* Check if the sender has enough*/
            balanceOf[msg.sender] -= _value;         /* Subtract from the buyer */

            provider[providerAddr].sales += _value;

            if (_value < totalSupply ) {
                throw;
            } else {
                totalSupply -= _value;
                Redeem (msg.sender, providerAddr, _value, now);
            }

        }

        return true;
    }

}
