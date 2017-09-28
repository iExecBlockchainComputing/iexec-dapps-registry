const Web3 = require("web3");

require("file-loader?name=../index.html!../index.html");
require("file-loader?name=./chess.js!./chess.js");
require("../css/app.css");



window.addEventListener('load', function() {

    // Checking if Web3 has been injected by the browser (Mist/MetaMask)
//    if (typeof web3 !== 'undefined') {
        // Use Mist/MetaMask's provider
 //       window.web3 = new Web3(web3.currentProvider);
  //  } else {
   //     console.log('No web3? You should consider trying MetaMask!')
        // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
        window.web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));


   // }


    web3.eth.defaultAccount = web3.eth.accounts[0];

    // Now you can start your app & access web3 freely:
    startApp()

})

function startApp() {



    var stockfishContract = web3.eth.contract([
        {
            "constant": false,
            "inputs": [
                {
                    "name": "submitTxHash",
                    "type": "bytes32"
                },
                {
                    "name": "user",
                    "type": "address"
                },
                {
                    "name": "appName",
                    "type": "string"
                },
                {
                    "name": "stdout",
                    "type": "string"
                }
            ],
            "name": "iexecSubmitCallback",
            "outputs": [
                {
                    "name": "",
                    "type": "bool"
                }
            ],
            "payable": false,
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "userMove",
                    "type": "string"
                }
            ],
            "name": "setParam",
            "outputs": [],
            "payable": false,
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [],
            "name": "flushGame",
            "outputs": [],
            "payable": false,
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "appName",
                    "type": "string"
                },
                {
                    "name": "param",
                    "type": "string"
                }
            ],
            "name": "iexecSubmit",
            "outputs": [],
            "payable": false,
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [],
            "name": "undoMove",
            "outputs": [],
            "payable": false,
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "getResult",
            "outputs": [
                {
                    "name": "game",
                    "type": "string"
                }
            ],
            "payable": false,
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "name": "userMove",
                    "type": "string"
                }
            ],
            "name": "checkValidity",
            "outputs": [
                {
                    "name": "validity",
                    "type": "bool"
                }
            ],
            "payable": false,
            "type": "function"
        },
        {
            "inputs": [
                {
                    "name": "_iexecOracleAddress",
                    "type": "address"
                }
            ],
            "payable": false,
            "type": "constructor"
        },
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": false,
                    "name": "status",
                    "type": "string"
                },
                {
                    "indexed": true,
                    "name": "user",
                    "type": "address"
                }
            ],
            "name": "Logs",
            "type": "event"
        },
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": false,
                    "name": "submitTxHash",
                    "type": "bytes32"
                },
                {
                    "indexed": true,
                    "name": "user",
                    "type": "address"
                },
                {
                    "indexed": false,
                    "name": "appName",
                    "type": "string"
                },
                {
                    "indexed": false,
                    "name": "stdout",
                    "type": "string"
                }
            ],
            "name": "IexecSubmitCallback",
            "type": "event"
        }
    ]);

var contract_address ="0x7c9d582cae3b95706409ba46b224f797147fac52";
    var contractInstance = stockfishContract.at(contract_address);


    var chess = new Chess();

    //Allows to disable enabled buttons
    var inputs = document.getElementsByTagName("input");

    //enableButtons is useful when a task is succeeded to enable buttons
    function getResults(enableButtons) {
        contractInstance.getResult(function(error, result) {
            if (!error) {

                //Parse the result to draw the diagram
                var moves = result.split(" ").reverse();

                //If moves have been made update the board
                for (var it = 0; it < moves.length; it++) {
                    var posFrom = moves[it].match(/^../);
                    var posTo = moves[it].match(/..$/);
                    if (posFrom && posTo) {
                        chess.move({
                            from: posFrom[0],
                            to: posTo[0]
                        });
                    }
                }

                var displayMoves = moves.join(" ");
                console.log("Result : " + displayMoves);
                var diagram = chess.ascii();

                if (Boolean(enableButtons)) {
                    for (var loop = 0; loop < inputs.length; loop++)
                        inputs[loop].disabled = false;
                }

                //Game over possibilities detection
                if (chess.game_over()) {
                    if (moves[0] == "none") { //The blacks lose because stockfish can't find a move
                        document.getElementById("movesHistory").innerHTML = "Whites win !\n" + diagram;
                    } else if (chess.in_draw() || chess.in_threefold_repetition()) {
                        document.getElementById("movesHistory").innerHTML = "Game over !\n" + diagram;
                    } else if (chess.in_checkmate()) {
                        document.getElementById("movesHistory").innerHTML = "Checkmate ! Blacks win !\n" + diagram;
                    } else if (chess.in_stalemate()) {
                        document.getElementById("movesHistory").innerHTML = "Stalemate ! Blacks win !\n" + diagram;
                    }
                    inputs[0].disabled = true; //Game over no more moves
                    inputs[1].disabled = true;
                } else if (chess.in_check()) {
                    document.getElementById("movesHistory").innerHTML = "Check !\n" + diagram;
                } else {
                    document.getElementById("movesHistory").innerHTML = displayMoves + "\n" + diagram;
                }
            } else {
                console.log(error);
            }
        });
    }

    //Get results at the beginning (buttons already enabled)
    getResults('false');

    document.getElementById("playBtn").addEventListener('click', function() {

        //Useful to the player to display the current state of the game if the move is invalid
        var diagram = chess.ascii();

        if (document.getElementById("moveBox").value.length != 4) {

            document.getElementById("movesHistory").innerHTML = "The move entered is invalid ! Please retry !\n" + diagram;

        } else {

            var posFrom = document.getElementById("moveBox").value.match(/^../);
            var posTo = document.getElementById("moveBox").value.match(/..$/);

            var possibilities = chess.moves({
                square: posFrom[0]
            });

            if (possibilities.length == 0 || chess.get(posFrom[0]).color == "b") {

                document.getElementById("movesHistory").innerHTML = "The move entered is invalid ! Please retry !\n" + diagram;

            } else {

                for (var it = 0; it < possibilities.length; it++) {

                    if (possibilities[it] == posTo) {
                        for (var loop = 0; loop < inputs.length; loop++)
                            inputs[loop].disabled = true;
                             contractInstance.setParam(document.getElementById("moveBox").value, function(error, result) {
                            if (!error) {
                                console.log("Move sent !");
                            } else {
                                console.log(error);
                            }
                        });
                        document.getElementById("moveBox").value = "";
                        document.getElementById("movesHistory").innerHTML = "Please wait, your transaction is being mined !";
                        return;
                    }

                }
                document.getElementById("movesHistory").innerHTML = "The move entered is invalid ! Please retry !\n" + diagram;

            }
        }
    })

    document.getElementById("undoBtn").addEventListener('click', function() {
        for (var loop = 0; loop < inputs.length; loop++)
            inputs[loop].disabled = true;
        contractInstance.undoMove(function(error, result) {
            if (!error) {
                console.log("Undo sent !");
            } else {
                console.log(error);
            }
        });
        document.getElementById("movesHistory").innerHTML = "Please wait, your transaction is being mined !";
    })

    document.getElementById("newGameBtn").addEventListener('click', function() {
        for (var loop = 0; loop < inputs.length; loop++)
            inputs[loop].disabled = true;
        contractInstance.flushGame(function(error, result) {
            if (!error) {
                console.log("Flush sent !");
            } else {
                console.log(error);
            }
        });
        document.getElementById("movesHistory").innerHTML = "Please wait, your transaction is being mined !";
    })

    var myEvent = contractInstance.Logs({});
    myEvent.watch(function(err, result) {
        if (err) {
            console.log("Erreur event ", err);
            return;
        }
        //I treat only the logs for me
        if (result.args.user == web3.eth.accounts[0]) {
            console.log("Feedback : " + result.args.status);
            if (result.args.status == "Task finished !") {
                getResults('true');
            } else if (result.args.status == "Invalid") {
                contractInstance.reDo(function(error, result) {
                    if (!error) {
                        console.log("ReDo sent !");
                        document.getElementById("movesHistory").innerHTML = "Stockfish error. Please accept transaction to retry !";
                    } else {
                        console.log(error);
                    }
                });
            } else if (result.args.status == "Running") {
                document.getElementById("movesHistory").innerHTML = "Stockfish is running. Please wait !";
            }
        }
    });
}
