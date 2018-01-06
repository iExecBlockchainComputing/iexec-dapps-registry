# iExec Sat Bridge

## DApp Description

This iExec application can link the Ethereum blockchain to a wide range of devices located anywhere on the globe. 

Truly global connectivity is only achievable using satellite technology. Small, portable satellite routers allow users to track and communicate with any devices they can connect to. Now smart contracts can query a marine buoy in the middle of the ocean for data or receive location updates from a high altitude balloon or even receive an emergency message from deep in the mountains.

## Why is it built on Ethereum

The dApp will be built on Ethereum to allow the use of smart contracts, Ethereum is the most advanced smart contract platform and has a really supportive community. Developers can write a smart contract that can send or receive instructions/data to their satellite connected device. We’re connecting Ethereum smart contracts to globally connected devices.

## Why does it use iExec

iExec's Dapp store is a great platform for this Dapp to be listed, exposing it to a large user base.
iExec processes all communication between the DApp and the satellite device, e.g. decoding/parsing message details, processing info if required.
In the future users can write their own message processing/instruction sets for their specific application. They can allow other users to connect to their devices allowing them to rent out the control of the device or purchase data. 

## Implementation Presentation

### System Diagram

![Sat Bridge](https://github.com/johngrantuk/iexec-dapp-samples/blob/dapp-challenge/Sat%20Bridge.jpg "Sat Bridge")

### Examples

**Ocean Temperatures:**

Vessel owners can instal Sat Bridge connected temperature sensors and sell the data to an Ethereum weather crowdsourcing Dapp.

1. Upon execution, the external Ethereum Weather Dapp smart contract sends query request to Sat Bridge
2. Dapp/iExec processes query and sends to relevant satellite device
3. Device receives query, collects data and reply
4. Dapp/iExec processes reply
5. Dapp/iExec returns result to the Weather Dapp

**Remote Logistics:**

Logistics companies can instal Sat Bridge to vehicles or packages. Sat Bridge can be configured to send regular location updates which could update a location Dapp. Additional information such as temperature, humidity, etc could be sent allowing customers to gain confidence in quality. 

1. Remote Sat Bridge device is configured to send regular location updates
2. Dapp/iExec processes received update
3. Dapp/iExec forwards data to subscribed external contracts
4. External contracts use location

## Roadmap

**Milestone 1: Develop blockchain/iExec/satellite protocol & Sat Bridge API**
+ Build out functionality to transfer message over complete network. External Contract -> Sat Bridge Dapp -> iExec -> Satellite Network -> Device -> Return
+ Sat Bridge API developed and documented. Allows approved external contracts to send/subscribe to specific device.

**Milestone 2: Proof Of Concept & Public Testing**
+ Instal live Sat Bridge device in sunny Scotland with following functionality:

   Send hourly temp, location and light level data to subscribed Weather Dapp (basic Dapp built to log data)
   Allow any user to send messages to control pan/tilt and snap of remote camera via Snap Dapp

**Milestone 3: Multi-device Registration**
+ Main Dapp developed to support multi-device:

   Allow users to register devices
   Allow users to send/receive messages to their registered device via Dapp
   Allow users to connect/approve external contracts for send/subscribe (via Sat Bridge API)

**Milestone 4: Dapp payment mechanism**

Establish dynamic message charges iExec charges & satellite network costs

**Future work - device marketplace**
