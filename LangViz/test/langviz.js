const LangViz = artifacts.require('./LangViz.sol');


let langViz;
const REWARD = 1000;

contract('LangViz', function(accounts) {

	it('should add a translation and emit log', function(done) {
		LangViz.deployed().then(function(instance) {
			langViz = instance;
			assert.isOk(langViz);
			// add entry
			return langViz.addDictionaryEntries("a", "AA");
		}).then(function(result) {
			// console.log(JSON.stringify(result));
			//check if logs are emitted
			assert.notEqual(result.logs.length, 0, "No logs emitted")
			assert.equal(result.logs[0].event, "EntryAdded", "EventAdded logs not emitted");
			done();
		});
	});

	it('should initialize with zero balance', function() {
		//check balance
		return langViz.getBalance()
		.then(function(result) {
			// console.log(JSON.stringify(result));
			//check if balance is zero
			let balance = result.toNumber();
			assert.equal(balance, 0, "Initial balance not zero");
		});
	});

	it('should emit reward event', function() {
		//add dictionary entry
		return langViz.addDictionaryEntries("b", "BB")
		.then(function(result) {
			// console.log(JSON.stringify(result));
			//send a correct translation
			return langViz.translate("b", "BB");
		}).then(function(result) {
			// console.log(JSON.stringify(result))
			//check for Reward event
			assert.notEqual(result.logs.length, 0, "No logs emitted")
			assert.equal(result.logs[0].event, "Reward", "Reward event not emitted");
		});
	});

	it('should reward correct translation', function() {
		let initialBalance;
		//set initalBalance variable
		return langViz.getBalance()
		.then(function(result) {
			initialBalance = result.toNumber();
			//add dictionary entry
			return langViz.addDictionaryEntries("c", "C");
		}).then(function(result) {
			// console.log(JSON.stringify(result));
			//send a correct translation
			return langViz.translate("c", "C");;
		}).then(function(result) {
			// console.log(JSON.stringify(result));
			// check balance
			return langViz.getBalance();
		}).then(function(result) {
			// console.log(JSON.stringify(result));
			// assert final balance = initial balance + reward
			let finalBalance = result.toNumber();
			assert.equal(finalBalance, (initialBalance + REWARD), "Final balance not equalt to initial balance + reward");
		});
	});

	it('should not reward correct translation', function() {
		let initialBalance;
		//set initalBalance variable
		return langViz.getBalance()
		.then(function(result) {
			initialBalance = result.toNumber();
			//add dictionary entry
			return langViz.addDictionaryEntries("d", "D");
		}).then(function(result) {
			// console.log(JSON.stringify(result));
			//send a wrong translation
			return langViz.translate("d", "DD");;
		}).then(function(result) {
			// console.log(JSON.stringify(result));
			// check balance
			return langViz.getBalance();
		}).then(function(result) {
			// console.log(JSON.stringify(result));
			// assert final balance != initial balance + reward
			let finalBalance = result.toNumber();
			assert.notEqual(finalBalance, (initialBalance + REWARD), "Final balance not equalt to initial balance + reward");
		});
	});
});