#!/bin/bash

# Azure benchmark
declare -a arr_azure=(
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure/AssetTransfer.sol AssetTransfer /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure/BasicProvenance.sol BasicProvenance /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure/BazaarItemListing.sol ItemListing /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure/BazaarItemListing.sol Bazaar /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure/DigitalLocker.sol DigitalLocker /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure/DefectiveComponentCounter.sol DefectiveComponentCounter /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure/FrequentFlyerRewardsCalculator.sol FrequentFlyerRewardsCalculator /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure/HelloBlockchain.sol HelloBlockchain /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure/PingPongGame.sol Starter /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure/PingPongGame.sol Player /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure/RefrigeratedTransportation.sol RefrigeratedTransportation /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure/RefrigeratedTransportationWithTime.sol RefrigeratedTransportationWithTime /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure/RoomThermostat.sol RoomThermostat /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure/SimpleMarketplace.sol SimpleMarketplace /txBound:128")

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
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure_fixed/AssetTransfer.sol AssetTransfer /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure_fixed/BasicProvenance.sol BasicProvenance /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure_fixed/BazaarItemListing.sol ItemListing /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure_fixed/BazaarItemListing.sol Bazaar /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure_fixed/DigitalLocker.sol DigitalLocker /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure_fixed/DefectiveComponentCounter.sol DefectiveComponentCounter /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure_fixed/HelloBlockchain.sol HelloBlockchain /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure_fixed/PingPongGame.sol Starter /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure_fixed/PingPongGame.sol Player /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure_fixed/RefrigeratedTransportation.sol RefrigeratedTransportation /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure_fixed/RefrigeratedTransportationWithTime.sol RefrigeratedTransportationWithTime /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/azure_fixed/SimpleMarketplace.sol SimpleMarketplace /txBound:128")

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
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/others/Aliasing.sol Aliasing /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/others/StorageDeterministicLayout.sol StorageDeterministicLayout /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/others/OpenAuction.sol SimpleAuction /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/others/OpenAuctionWithCall.sol SimpleAuction /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/others/Voting.sol Ballot /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/others/Wallet.sol Wallet /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/others/WalletNoOverflow.sol Wallet /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/others/WalletNoOverflowButCall.sol Wallet /txBound:128"
    "/root/.dotnet/tools/VeriSol /examples_0.5.10/others/WalletNoOverflowButCallWithLocking.sol Wallet /txBound:128")

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