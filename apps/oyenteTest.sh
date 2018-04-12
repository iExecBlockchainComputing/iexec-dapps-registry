#!/bin/bash
echo "--------------This is my customScript in docker--------------------"
echo "--------------A test for fully operational oyente test-------------"
echo "--------------Copy contracts into the docker-----------------------"
docker cp contracts.zip confident_euler:/oyente
echo "--------------Go into the docker-----------------------------------"
docker exec -it cf6f8d0b1444 bash ./customScript.sh
