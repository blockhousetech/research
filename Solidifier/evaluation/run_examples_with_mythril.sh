#!/bin/bash

export SOLC=/solidity_0.4.26/build/solc/solc

# Azure benchmark
declare -a arr_azure=(
    "myth analyze /examples_mythril/azure/AssetTransfer.sol"
    "myth analyze /examples_mythril/azure/BasicProvenance.sol"
    "myth analyze /examples_mythril/azure/BazaarItemListing.sol"
    "myth analyze /examples_mythril/azure/DigitalLocker.sol"
    "myth analyze /examples_mythril/azure/DefectiveComponentCounter.sol"
    "myth analyze /examples_mythril/azure/FrequentFlyerRewardsCalculator.sol"
    "myth analyze /examples_mythril/azure/HelloBlockchain.sol"
    "myth analyze /examples_mythril/azure/PingPongGame.sol"
    "myth analyze /examples_mythril/azure/RefrigeratedTransportation.sol"
    "myth analyze /examples_mythril/azure/RefrigeratedTransportationWithTime.sol"
    "myth analyze /examples_mythril/azure/RoomThermostat.sol"
    "myth analyze /examples_mythril/azure/SimpleMarketplace.sol")

for i in "${arr_azure[@]}"
do
   echo "################### Executing time timeout 300 $i #######################"
   eval "time timeout 300 $i"
   ret_code=$?
   if [ "$ret_code" = "124" ]; then
        echo "######## Timeout ########"
   fi
   echo "################### End of execution #######################"
done

# Azure benchmark fixed
declare -a arr_azure_fixed=(
    "myth analyze /examples_mythril/azure_fixed/AssetTransfer.sol"
    "myth analyze /examples_mythril/azure_fixed/BasicProvenance.sol"
    "myth analyze /examples_mythril/azure_fixed/BazaarItemListing.sol"
    "myth analyze /examples_mythril/azure_fixed/DigitalLocker.sol"
    "myth analyze /examples_mythril/azure_fixed/DefectiveComponentCounter.sol"
    "myth analyze /examples_mythril/azure_fixed/HelloBlockchain.sol"
    "myth analyze /examples_mythril/azure_fixed/PingPongGame.sol"
    "myth analyze /examples_mythril/azure_fixed/RefrigeratedTransportation.sol"
    "myth analyze /examples_mythril/azure_fixed/RefrigeratedTransportationWithTime.sol"
    "myth analyze /examples_mythril/azure_fixed/SimpleMarketplace.sol")

for i in "${arr_azure_fixed[@]}"
do
   echo "################### Executing time timeout 300 $i #######################"
   eval "time timeout 300 $i"
   ret_code=$?
   if [ "$ret_code" = "124" ]; then
      echo "######## Timeout ########"
   fi
   echo "################### End of execution #######################"
done

# Others
declare -a arr_others=(
    "myth analyze /examples_mythril/others/Aliasing.sol"
    "myth analyze /examples_mythril/others/StorageDeterministicLayout.sol"
    "myth analyze /examples_mythril/others/OpenAuction.sol"
    "myth analyze /examples_mythril/others/OpenAuctionWithCall.sol"
    "myth analyze /examples_mythril/others/Voting.sol"
    "myth analyze /examples_mythril/others/Wallet.sol"
    "myth analyze /examples_mythril/others/WalletNoOverflow.sol"
    "myth analyze /examples_mythril/others/WalletNoOverflowButCall.sol"
    "myth analyze /examples_mythril/others/WalletNoOverflowButCallWithLocking.sol")

for i in "${arr_others[@]}"
do
   echo "################### Executing time timeout 300 $i #######################"
   eval "time timeout 300 $i"
   ret_code=$?
   if [ "$ret_code" = "124" ]; then
      echo "######## Timeout ########"
   fi
   echo "################### End of execution #######################"
done