

export STOCKFISH_CONTRACT_ADDRESS=$(cat ./build/contracts/stockfish.json | grep "address\":" | cut -d: -f2 | cut -d\" -f2)
echo "STOCKFISH_CONTRACT_ADDRESS is :$STOCKFISH_CONTRACT_ADDRESS"
echo "update address in ./app/js/app.js"
sed -i "s/.*var contract_address =.*/var contract_address =\"${STOCKFISH_CONTRACT_ADDRESS}\";/g" ./app/js/app.js

./node_modules/.bin/webpack

php -S 0.0.0.0:8000 -t ./build/app
