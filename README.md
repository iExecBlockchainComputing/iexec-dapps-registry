# stockfish


### Prerequisite:

init your iexec vagrant local vm see :
https://github.com/iExecBlockchainComputing/iexec-node/blob/master/vagrant/README.md


### Configure and start your local xtremweb server and worker

see : https://github.com/iExecBlockchainComputing/iexec-node/blob/master/vagrant/discoverXtremweb.md

### Provision stockfish app into xtremweb

compile Stockfish
```
cd ~/iexecdev/
git clone https://github.com/iExecBlockchainComputing/Stockfish.git
cd Stockfish/src

make -e EXTRALDFLAGS="-static-libgcc -static-libstdc++ " ARCH=x86-64 build

```

Check a move on your compiled stockfish compile

```
cd ~/iexecdev/Stockfish/src
./stockfish <~/iexecdev/bridge_stockfish/test/stockfishSimpleTest.txt
```
expected result :

```
...
...
bestmove d7d5 ponder d2d4
```

send Stockfish to xtremweb
```
cd ~/iexecdev/xtremweb-hep/build/dist/${XTREMWEB_VERSION}/bin/
./xwsendapp stockfish deployable Linux amd64 /home/vagrant/iexecdev/Stockfish/src/stockfish

```
you should see an id as answer like :
```
xw://vagrant-ubuntu-trusty-64/14447543-cd16-4c05-bbbc-7204895af9ba
```


### Manually check that stockfish app in xtremweb works well
 
check your stockfish app is register in xtremweb :
```
cd ~/iexecdev/xtremweb-hep/build/dist/${XTREMWEB_VERSION}/bin/
./xwapps
```
you should see an id as answer like :
```
UID='14447543-cd16-4c05-bbbc-7204895af9ba', NAME='stockfish'
```
check that a worker is register 
```
./xwworkers
```
you should see an id as answer like :
```
 UID='014c4e9b-5dea-43a1-8fad-a531ee59aba3', NAME='vagrant-ubuntu-trusty-64'
```

submit a test move to xtremweb :
```
./xwsubmit stockfish --xwstdin ~/iexecdev/bridge_stockfish/test/stockfishSimpleTest.txt

```
you should see an id as answer like :
```
xw://vagrant-ubuntu-trusty-64/83cfea36-a153-4c08-950c-8164a00741bf
```
check the status of the task :
```
./xwstatus xw://vagrant-ubuntu-trusty-64/83cfea36-a153-4c08-950c-8164a00741bf
```

The xwstatus command must end with PENDING -> RUNNING -> COMPLETED state
```
UID='2d34665e-78b8-43b1-96db-5940a4967866', STATUS='COMPLETED', COMPLETEDDATE='2017-08-13 19:18:43', LABEL=NULL
```

call xwdownload command to download and see the move result :
```
./xwdownload xw://vagrant-ubuntu-trusty-64/bf28a23b-b12b-4efb-8707-297a0db00b7b
```

```
 UID='bf28a23b-b12b-4efb-8707-297a0db00b7b', STATUS='COMPLETED', COMPLETEDDATE='2017-08-14 13:19:09', LABEL=NULL
.....
 INFO : Downloaded to : /home/vagrant/iexecdev/xtremweb-hep/build/dist/xwhep-10.5.2/bin/bcdc474c-5a5c-4cf5-bb6a-0ef132d930d4_ResultsOf_bf28a23b-b12b-4efb-8707-297a0db00b7b.zip
```

In the zip you must find a stdout.txt file wih the following content :
```
Stockfish 140817 64 by T. Romstad, M. Costalba, J. Kiiski, G. Linscott
Unknown command:
info depth 1 seldepth 1 multipv 1 score cp 10 nodes 31 nps 3875 tbhits 0 time 8 pv d7d5
info depth 2 seldepth 2 multipv 1 score cp 64 nodes 59 nps 7375 tbhits 0 time 8 pv d7d5 e4d5
info depth 3 seldepth 3 multipv 1 score cp 41 nodes 186 nps 23250 tbhits 0 time 8 pv d7d5 c2c3 d5e4
info depth 4 seldepth 5 multipv 1 score cp 13 nodes 565 nps 62777 tbhits 0 time 9 pv d7d5 e4d5 d8d5 d2d3
info depth 5 seldepth 5 multipv 1 score cp -29 nodes 1521 nps 138272 tbhits 0 time 11 pv g8f6 d2d3 d7d5 b1d2 c8d7
info depth 6 seldepth 8 multipv 1 score cp -15 nodes 3100 nps 258333 tbhits 0 time 12 pv b8c6 b1c3 e7e5 d2d3 d7d6 c1d2
info depth 7 seldepth 8 multipv 1 score cp -33 nodes 6697 nps 352473 tbhits 0 time 19 pv d7d5 d2d4 d5e4 b1c3 e7e5 f1b5 b8c6 d4e5 d8d1 e1d1
info depth 8 seldepth 10 multipv 1 score cp -7 nodes 8638 nps 411333 tbhits 0 time 21 pv d7d5
bestmove d7d5 ponder d2d4
```

### Deploy and launch your local stockfish front end

in another console launch your local ethereum node or use testrpc
more details here :
https://github.com/iExecBlockchainComputing/iexec-node/blob/master/vagrant/discoverTruffleTestRpcGeth.md
```
cd gethUtils/
./mine42externalexposed.sh
```
when you see your miner active :
```
... 🔨 mined potential block,  ...
```
you can continue.

or 
```
testrpc
```


in another console  :
```
npm install
./buildAndDeploy.sh  

```

wait for : 
```
Listening on http://0.0.0.0:8000
Document root is /home/vagrant/iexecdev/iexec-node/poc/stockfish/front/build/app
Press Ctrl-C to quit.
```

### Play with stockfish 

play chess at : 

http://localhost:8000
