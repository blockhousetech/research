#!/bin/bash

# Azure benchmark
declare -a arr_azure=(
    "myth analyze --modules Exceptions /examples_0.5.10/azure/AssetTransfer.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/azure/BasicProvenance.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/azure/BazaarItemListing.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/azure/DigitalLocker.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/azure/DefectiveComponentCounter.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/azure/FrequentFlyerRewardsCalculator.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/azure/HelloBlockchain.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/azure/PingPongGame.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/azure/RefrigeratedTransportation.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/azure/RefrigeratedTransportationWithTime.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/azure/RoomThermostat.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/azure/SimpleMarketplace.sol")

for i in "${arr_azure[@]}"
do
   echo "################### Executing time timeout 300 $i #######################"
   eval "time (timeout -s 9 300 $i)"
   ret_code=$?
   if [ "$ret_code" = "124" ]; then
        echo "######## Timeout ########"
   fi
   echo "################### End of execution #######################"
done

# Azure benchmark fixed
declare -a arr_azure_fixed=(
    "myth analyze --modules Exceptions /examples_0.5.10/azure_fixed/AssetTransfer.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/azure_fixed/BasicProvenance.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/azure_fixed/BazaarItemListing.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/azure_fixed/DigitalLocker.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/azure_fixed/DefectiveComponentCounter.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/azure_fixed/HelloBlockchain.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/azure_fixed/PingPongGame.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/azure_fixed/RefrigeratedTransportation.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/azure_fixed/RefrigeratedTransportationWithTime.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/azure_fixed/SimpleMarketplace.sol")

for i in "${arr_azure_fixed[@]}"
do
   echo "################### Executing time timeout 300 $i #######################"
   eval "time (timeout -s 9 300 $i)"
   ret_code=$?
   if [ "$ret_code" = "124" ]; then
      echo "######## Timeout ########"
   fi
   echo "################### End of execution #######################"
done

# Others
declare -a arr_others=(
    "myth analyze --modules Exceptions /examples_0.5.10/others/Aliasing.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/others/StorageDeterministicLayout.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/others/OpenAuction.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/others/OpenAuctionWithCall.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/others/Voting.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/others/Wallet.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/others/WalletNoOverflow.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/others/WalletNoOverflowButCall.sol"
    "myth analyze --modules Exceptions /examples_0.5.10/others/WalletNoOverflowButCallWithLocking.sol")

for i in "${arr_others[@]}"
do
   echo "################### Executing time timeout 300 $i #######################"
   eval "time (timeout -s 9 300 $i)"
   ret_code=$?
   if [ "$ret_code" = "124" ]; then
      echo "######## Timeout ########"
   fi
   echo "################### End of execution #######################"
done