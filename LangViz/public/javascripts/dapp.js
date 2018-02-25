//LangViz ABI
const abiDefinition = '[{"constant":true,"inputs":[],"name":"getBalance","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"reward","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"key","type":"bytes4"},{"name":"value","type":"string"}],"name":"addDictionaryEntries","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"key","type":"bytes4"},{"name":"translation","type":"string"}],"name":"translate","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[{"name":"initialSupply","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"name":"key","type":"bytes4"}],"name":"EntryAdded","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"to","type":"address"},{"indexed":false,"name":"key","type":"bytes4"}],"name":"Reward","type":"event"}]';
//LangViz address
const langVizAddress = '0x88163c67a7c48c19eee14d7efb25d7224c42bb46';

let langViz;

$(document).ready(function() {
    // Checking if Web3 has been injected by the browser (Mist/MetaMask)
    if (typeof web3 !== 'undefined') {
        // Use Mist/MetaMask's provider
        window.web3 = new Web3(web3.currentProvider);
      } else {
        console.log('Injected web3 Not Found!!!')
        // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
        window.web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'));
        // window.web3 = new Web3(new Web3.providers.HttpProvider(provider));
      }

      startApp();
    });

function startApp() {
  //instantiate contract
  let LangViz = web3.eth.contract(JSON.parse(abiDefinition));
  langViz = LangViz.at(langVizAddress);
  getBalance((err, balance) => {
    if(err) {
      return console.log(err);
    }
    $('#balance').text(balance);
  });
  getLogs();
}

let translate = function(key, translation, cb) {
  //send transaction
  langViz.translate.sendTransaction(key, translation, function(err, result) {
    if (err) {
      return cb(err);
    }
    return cb(null, result);
  });
}

let getBalance = function(cb) {
  //do balance call
  langViz.getBalance(function(err, result) {
    if (err) {
      return cb(err);
    }
    console.log(result.toString());
    return cb(null, result);
  });
}

function addEvent(eventText) {
  let eventDiv = document.createElement("div");
  let eventTextNode = document.createTextNode(eventText);
  eventDiv.appendChild(eventTextNode); 
  document.getElementById("eventcontainer").appendChild(eventDiv);    
}

let getLogs = function() {
  //listen on event
  var events = langViz.allEvents({fromBlock: 0, toBlock: 'latest'});
  events.watch(function(error, result) {
    if(!error) {
      addEvent(result.event + ': ' + JSON.stringify(result.args));
    }
  });
}