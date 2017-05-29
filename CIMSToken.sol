pragma solidity ^0.4.10;

contract ricardianVoucher {
	// Generic Voucher Language https://tools.ietf.org/html/draft-ietf-trade-voucher-lang-07
	// The Ricardian Financial Instrument Contract http://www.systemics.com/docs/ricardo/issuer/contract.html
	
    // Owner of this smart contract
    address public owner;
    
    // Functions with this modifier can only be executed by the owner
    modifier onlyOwner() {
        if (msg.sender != owner) {
           throw;
        }
       _;
    }
    
    // Functions with this modifier can only be executed when voucherToken is in circulation
    modifier inCirculation {
        if ((now < validity_start) || (now < validity_end))
            throw;
        _;
    } 
    
    // Functions with this modifier can only be executed when voucherToken is in circulation
    modifier beforeCirculation {
        if (now > validity_start)
            throw;
        _;
    } 
  
    /* voucherToken MANAGEMENT */ 
	
	/* Public variables of the voucherToken */	
    string public standard = 'Token 0.1';
    uint256 public totalSupply;
    string public voucherTokenName;
    uint8 public decimals;
    string public voucherTokenSymbol;
    address public voucherTokenLogoBzz;  		// swarm hash of a voucher or voucherToken icon or logo
    uint8 public validity_start; 				// start date of the contract. Validity period of the voucher to redeem merchandises
    uint8 public validity_end; 					// end date of the contract. Provides restrictions on the validity period of the voucher
    
    /* Initializes voucherToken with initial supply voucherTokens to the creator of the contract */
    function ricardianVoucher(
        uint256 _totalSupply,
        string _voucherTokenName,
        uint8 _decimals,
        string _voucherTokenSymbol,
        address _voucherTokenLogoBzz,
        uint8 _validity_start, 					
        uint8 _validity_end			
        ) {
    	owner = msg.sender;
        totalSupply = _totalSupply;                        	// Update total supply
        balanceOf[owner] = totalSupply;       	            // Give the creator all initial voucherTokens
        voucherTokenName = _voucherTokenName;               // Set the name for display purposes
        voucherTokenSymbol = _voucherTokenSymbol;           // Set the symbol for display purposes
        decimals = _decimals; 								// Amount of decimals for display purposes
        voucherTokenLogoBzz = _voucherTokenLogoBzz;
        validity_start = _validity_start;
        validity_end = _validity_end;   
        provider[owner].member=true;
        providerIndex[0]= owner;
    }
    
    // balanceOf for each account, member or not member
    mapping(address => uint256) balanceOf; 
    
    /* CONTRACT MANAGEMENT */
    
    address public contractBzz; 				// swarm hash of the signer human readable contract
    string[] merchandises; 						// Provides restrictions on the object to be claimed. Domain-specific meaning of the voucher
    string[] definitions; 						// Includes terms and definitions that generally desire to be defined in a contract
    string[] conditions; 						// Provides any other applicable restrictions
    
    /* write contract terms */
    // only the owner can write the contract terms
    // contract terms can only be written before circulation 
    
    function linkContract (address _contractBzz) onlyOwner beforeCirculation { 
    	contractBzz = _contractBzz;
    }
    
    function writeMerchandises (uint8 _number, string _merchandise) onlyOwner beforeCirculation {
    	merchandises[_number] = _merchandise;
    }
    function writeDefinitions (uint8 _number, string _definition) onlyOwner beforeCirculation {
    	definitions[_number] = _definition;
    }
    function writeConditions (uint8 _number, string _condition) onlyOwner beforeCirculation  {
    	conditions[_number] = _condition;
    }
    
    /* VOUCHER CICULATION */  
    
    // Owner of account approves the transfer of an amount to another account
     mapping(address => mapping (address => uint256)) allowed;

    /* Send voucherTokens */
    function transfer(address _to, uint256 _amount) {
        if (balanceOf[msg.sender] >= _amount && _amount > 0) {
            balanceOf[msg.sender] -= _amount;
            balanceOf[_to] += _amount;
            Transfer(msg.sender, _to, _amount, now);
        } 
    }

    // Allow _spender to withdraw from your account, multiple times, up to the _amount amount.
    // If this function is called again it overwrites the current allowance with _amount.
     function approve (address _spender, uint256 _amount) {
         allowed[msg.sender][_spender] = _amount;
         Approval(msg.sender, _spender, _amount, now);
    }
     
     // Send _amount amount of voucherTokens from address _from to address _to
     // The transferFrom method is used for a withdraw workflow, allowing contracts to send
     // voucherTokens on your behalf, for example to "deposit" to a contract address and/or to charge
     // fees in sub-currencies; the command should fail unless the _from account has
     // deliberately authorized the sender of the message via some mechanism; we propose
     // these standardized APIs for approval:
     function transferFrom(address _from, address _to, uint256 _amount) {
         //same as above. Replace this line with the following if you want to protect against wrapping uints.
         //if (balanceOf[_from] >= _amount && allowed[_from][msg.sender] >= _amount && balanceOf[_to] + _amount > balanceOf[_to]) {
         if (balanceOf[_from] >= _amount && allowed[_from][msg.sender] >= _amount && _amount > 0) {
             balanceOf[_to] += _amount;
             balanceOf[_from] -= _amount;
             allowed[_from][msg.sender] -= _amount;
             Transfer(_from, _to, _amount, now);
                      } 
     }

    /* PROVIDERS MANAGEMENT */
    
    // Providers
    struct providers {
    	bool member;
    	string name; 			// the name you are normally known by in the street
        string shortname; 		// short name is displayed by trading software, 8 chars max
        string longname; 		// full legal name
        string postaddress; 	// formal address for snail-mail notices
        string country; 		// two letter ISO code that indicates the jurisdiction
        string registration; 	// legal registration code of the provider (legal person or legal entity)
        address Bzz; 			// swarm hash of the signer human readable registry document
        uint256 promise;
        bool promiseApproved;
        uint256 sales;
    }
   
    mapping(address => providers) provider;
    
    address[] providerIndex;

    function applyAsProvider (
    	string _name, 			// the name you are normally known by in the street
        string _shortname, 		// short name is displayed by trading software, 8 chars max
        string _longname, 		// full legal name
        string _address, 		// formal address for snail-mail notices
        string _country, 		// two letter ISO code that indicates the jurisdiction
        string _registration, 	// legal registration code of the provider (legal person or legal entity)
        address _Bzz 			// swarm hash of the signer human readable registry document
       ) {
    	provider[msg.sender].name=_name; 			
        provider[msg.sender].shortname=_shortname; 		
        provider[msg.sender].longname=_longname; 		
        provider[msg.sender].postaddress=_address; 		
        provider[msg.sender].country=_country; 		
        provider[msg.sender].registration=_registration; 	
        provider[msg.sender].Bzz=_Bzz;
        ApplicationProvider(msg.sender, _name, now);
    }
    
    function approveProvider (address _provider) onlyOwner {
    	provider[_provider].member=true;
    	providerIndex[providerIndex.length + 1] = _provider;
    	ApproveProvider (_provider, provider[_provider].name, now);
    }
    
    function deleteProvider (address _providerAddress) {
    	if (_providerAddress==msg.sender || msg.sender==owner) {
    	provider[_providerAddress].member=false;
    	DeleteProvider (_providerAddress, provider[_providerAddress].name, now);
    	}
    }
    
    /* ASSOCIATION MANAGEMENT */    
    
    function declareAssociation (
        	string _name, 			// the name you are normally known by in the street
            string _shortname, 		// short name is displayed by trading software, 8 chars max
            string _longname, 		// full legal name
            string _postaddress, 	// formal address for snail-mail notices
            string _country, 		// two letter ISO code that indicates the jurisdiction
            string _registration, 	// legal registration code of the provider (legal person or legal entity)
            address _Bzz 			// swarm hash of the signer human readable registry document
           ) onlyOwner beforeCirculation {
    		
        	provider[owner].name=_name; 			
            provider[owner].shortname=_shortname; 		
            provider[owner].longname=_longname; 		
            provider[owner].postaddress=_postaddress; 		
            provider[owner].country=_country; 		
            provider[owner].registration=_registration; 	
            provider[owner].Bzz=_Bzz;
            ApplicationProvider(owner, _name, now);
        }   
    
    /* PROMISES MANAGEMENT */
    

    function addPromise (uint256 _promise) {
    	if (provider[msg.sender].member==true) {
    	    provider[msg.sender].promise = _promise;
    		provider[msg.sender].promiseApproved = false;
    		AddPromise (msg.sender, _promise, now);
    	}
    }

	function approvePromise (address _provider) onlyOwner {
			provider[_provider].promiseApproved = true;
			balanceOf[_provider] = balanceOf[_provider] + provider[_provider].promise;
			totalSupply = totalSupply + provider[msg.sender].promise;
			ApprovePromise (_provider, provider[_provider].promise, now);

	}
	
    /* SALES MANAGEMENT */
    
        function redeemFrom (address _provider, uint256 _value, string _billDescription) 
        returns (bool) {
        if (provider[_provider].member == true) {
            if (balanceOf[msg.sender] < _value) throw;   // Check if the sender has enough
            balanceOf[msg.sender] -= _value;            // Subtract from the buyer 
            provider[_provider].sales += _value;         // Add so provider sales
            totalSupply -= _value;
            Redeem (msg.sender, _provider, _value, _billDescription, now);
            }
        }
    
    
    /* GET INFORMATION */
     

    // What is the balance of a particular account?
    function getBalance (address _owner) constant returns (uint256 _balance) {
        return balanceOf[_owner];
    }

	function getAllowance(address _owner, address _spender) constant returns (uint256 remaining) {
	    return allowed[_owner][_spender];
	}
	
	function getVoucher () constant returns (
	        uint256 _totalSupply,
	        string _voucherTokenName,
	        uint8 _decimals,
	        string _voucherTokenSymbol,
	        address _voucherTokenLogoBzz,
	        uint8 _validity_start, 				
	        uint8 _validity_ends 					
	        ) {
		return (totalSupply,
	        voucherTokenName,
	        decimals,
	        voucherTokenSymbol,
	        voucherTokenLogoBzz,
	        validity_start, 				
	        validity_end);
	}
	
	function getMerchandise (uint256 _number) constant returns (string _merchandise) {
		return merchandises[_number];
	}
	
	function getDefinition (uint256 _number) constant returns (string _definition) {
		return definitions[_number];
	}
	
	function getCondition (uint256 _number) constant returns (string _condition) {
		return conditions[_number];
	}
	
	function getProvider (address _provider) constant returns (string _name, 
	        string _shortname,
	        string _longname,
	        string _address,
	        string _country,
	        string _registration,
	        address _Bzz) {
		return (provider[_provider].name, 			
        provider[_provider].shortname,		
        provider[_provider].longname,		
        provider[_provider].postaddress, 		
        provider[_provider].country,		
        provider[_provider].registration,	
        provider[_provider].Bzz);
	}
    
    /* EVENTS */
	
    /* This generates public events on the blockchain that will notify clients */
    
        
    // Triggered when voucherTokens are transferred.
    event Transfer(address indexed _from, address indexed _to, uint256 _value, uint256 _timestamp);

     // Triggered whenever approve(address _spender, uint256 _value) is called.
    event Approval(address indexed _owner, address indexed _spender, uint256 _value, uint256 _timestamp);

     // Triggered whenever a redemption is called.
    event Redeem (address _customer, address _provider, uint256 _sale, string _billDescription, uint256 _timestamp);
     
	//Triggered when a new provider applies
	event ApplicationProvider (address indexed _from, string _name, uint256 _timestamp);
	
	//Triggered when a new provider is approved
	event ApproveProvider (address indexed _from, string _name, uint256 _timestamp);
	
	//Triggered when a provider is deleted
	event DeleteProvider (address indexed _from, string _name, uint256 _timestamp);	
    
    event AddPromise (address indexed _provider, uint256 _promise, uint256 _timestamp);
    
    event ApprovePromise (address indexed _provider, uint256 _promise, uint256 _timestamp);
    
    /* OVERALL */

    /* This unnamed function is called whenever someone tries to send ether to it */
    function () {
        throw;     // Prevents accidental sending of ether
    }
}
