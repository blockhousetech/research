#!/bin/bash

export SOLC_SOLIDIFIER=/solc-static-linux-0.5.17

# Azure benchmark
declare -a arr_azure=(
    "Solidifier /examples/azure/AssetTransfer.sol AssetTransfer"
    "Solidifier /examples/azure/BasicProvenance.sol BasicProvenance"
    "Solidifier /examples/azure/BazaarItemListing.sol ItemListing"
    "Solidifier /examples/azure/BazaarItemListing.sol Bazaar"
    "Solidifier /examples/azure/DigitalLocker.sol DigitalLocker"
    "Solidifier /examples/azure/DefectiveComponentCounter.sol DefectiveComponentCounter"
    "Solidifier /examples/azure/FrequentFlyerRewardsCalculator.sol FrequentFlyerRewardsCalculator"
    "Solidifier /examples/azure/HelloBlockchain.sol HelloBlockchain"
    "Solidifier /examples/azure/PingPongGame.sol Starter"
    "Solidifier /examples/azure/PingPongGame.sol Player"
    "Solidifier /examples/azure/RefrigeratedTransportation.sol RefrigeratedTransportation"
    "Solidifier /examples/azure/RefrigeratedTransportationWithTime.sol RefrigeratedTransportationWithTime"
    "Solidifier /examples/azure/RoomThermostat.sol RoomThermostat"
    "Solidifier /examples/azure/SimpleMarketplace.sol SimpleMarketplace")

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
    "Solidifier /examples/azure_fixed/AssetTransfer.sol AssetTransfer"
    "Solidifier /examples/azure_fixed/BasicProvenance.sol BasicProvenance"
    "Solidifier /examples/azure_fixed/BazaarItemListing.sol ItemListing"
    "Solidifier /examples/azure_fixed/BazaarItemListing.sol Bazaar"
    "Solidifier /examples/azure_fixed/DigitalLocker.sol DigitalLocker"
    "Solidifier /examples/azure_fixed/DefectiveComponentCounter.sol DefectiveComponentCounter"
    "Solidifier /examples/azure_fixed/HelloBlockchain.sol HelloBlockchain"
    "Solidifier /examples/azure_fixed/PingPongGame.sol Starter"
    "Solidifier /examples/azure_fixed/PingPongGame.sol Player"
    "Solidifier /examples/azure_fixed/RefrigeratedTransportation.sol RefrigeratedTransportation"
    "Solidifier /examples/azure_fixed/RefrigeratedTransportationWithTime.sol RefrigeratedTransportationWithTime"
    "Solidifier /examples/azure_fixed/SimpleMarketplace.sol SimpleMarketplace")

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
    "Solidifier /examples/others/Aliasing.sol Aliasing t"
    "Solidifier /examples/others/StorageDeterministicLayout.sol StorageDeterministicLayout t"
    "Solidifier /examples/others/OpenAuction.sol SimpleAuction"
    "Solidifier /examples/others/OpenAuctionWithCall.sol SimpleAuction"
    "Solidifier /examples/others/Voting.sol Ballot"
    "Solidifier /examples/others/Wallet.sol Wallet"
    "Solidifier /examples/others/WalletNoOverflow.sol Wallet"
    "Solidifier /examples/others/WalletNoOverflowButCall.sol Wallet"
    "Solidifier /examples/others/WalletNoOverflowButCallWithLocking.sol Wallet")

for i in "${arr_others[@]}"
do
   echo "################### Executing time (timeout 300 $i)#######################"
   eval "time (timeout -s 9 300 $i)"
   ret_code=$?
   if [ "$ret_code" = "124" ]; then
      echo "######## Timeout ########"
   fi
   echo "################### End of execution #######################"
done