#!/bin/bash

# Azure benchmark
declare -a arr_azure=(
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure/AssetTransfer.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure/BasicProvenance.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure/BazaarItemListing.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure/DigitalLocker.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure/DefectiveComponentCounter.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure/FrequentFlyerRewardsCalculator.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure/HelloBlockchain.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure/PingPongGame.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure/RefrigeratedTransportation.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure/RefrigeratedTransportationWithTime.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure/RoomThermostat.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure/SimpleMarketplace.sol")

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
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure_fixed/AssetTransfer.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure_fixed/BasicProvenance.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure_fixed/BazaarItemListing.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure_fixed/DigitalLocker.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure_fixed/DefectiveComponentCounter.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure_fixed/HelloBlockchain.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure_fixed/PingPongGame.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure_fixed/RefrigeratedTransportation.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure_fixed/RefrigeratedTransportationWithTime.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/azure_fixed/SimpleMarketplace.sol")

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
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/others/Aliasing.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/others/StorageDeterministicLayout.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/others/OpenAuction.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/others/OpenAuctionWithCall.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/others/Voting.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/others/Wallet.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/others/WalletNoOverflow.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/others/WalletNoOverflowButCall.sol"
    "/solidity/build/solc/solc-verify.py --solver z3 /examples_0.5.10/others/WalletNoOverflowButCallWithLocking.sol")

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