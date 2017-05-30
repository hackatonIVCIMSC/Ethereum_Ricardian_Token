if (typeof web3 !== 'undefined')
	web3 = new Web3(web3.currentProvider);
else
	web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));

var RicardianTokenContract = web3.eth.contract(
		
);

var RTC = RicardianTokenContract
		.at("");

var accounts = web3.eth.accounts;
var nrAcc = accounts.length;

web3.eth.defaultAccount = accounts[0];
var myCoinbase = web3.eth.defaultAccount;

var name = RTC.name;
var symbol = RTC.symbol;
var decimals = RTC.decimals;
var totalSupply = RTC.totalSupply;
var owner = RTC.owner;
