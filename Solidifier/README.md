# Solidifier

Solidifier is a bounded model checker for Solidity. It translates Solidity code into the [Boogie language](https://www.microsoft.com/en-us/research/project/boogie-an-intermediate-verification-language/)
which is later verified by [Corral](https://www.microsoft.com/en-us/research/project/q-program-verifier/).
Unlike many of the tools developed to analyse smart contracts that check for known possibly problematic/vulnerable behaviours,
Solidifier looks for violation to assertions. The semantic properties described in this way should better describe the intent
of developers and so they more finely capture mistakes and possibly vulnerabilities of smart contracts. The errors uncovered by
such tools might be reached via known vulnerability patterns but they might also uncover types of executions that we are completely
unaware of. For more details on how it works, you can read [our paper](https://arxiv.org/abs/2002.02710). Tools like [VeriSol](https://github.com/microsoft/verisol)
and [solc-verify](https://github.com/SRI-CSL/solidity/blob/boogie/SOLC-VERIFY-README.md) work similarly to ours trying to falsify/prove
semantic properties of smart contracts.


Contracts need to declare the following library to get access to verification primitives *assume* and *assert*.

```Solidity
library Verification {
    function Assume (bool b);
    function Assert (bool b);
    function CexPrintui (uint ui);
}
```

While *Verification.Assume(condition)* fails silently (stopping the contract's execution) when the *condition* is not met,
*Verification.Assert(condition)* fails with an error that is reported by Solidifier.
Note that Solidity errors such as accessing an array index out of bounds or having a modulo zero expression
causes a silent failure. For instance, Solidifier would not report an error for an execution that accesses an index out of bounds and
then reaches a *Verification.Assert(false)* statement. The *Verification* library can declare functions to print the value of expressions of basic types
to the counterexample trace; these are prefixed by *CexPrint*. For instance, *CexPrintui (uint ui)* declares a function that prints a unsigned integer.
Function *CexPrintad (address ad)* could have been declared to print addresses. Note that printing only happens if the counterexample reaches a given
printing statement; *Verification.CexPrintui(expression)*, for instance.

Solidifier implements two verification harnesses: a contract harness and a function harness.
The contract harness analyses the behaviour of an instance of a given contract.
From deployment to the blockchain, it analyses all possible sequences of function executions up to a certain depth.
The function harness analyses a single smart contract function executed once (up to a certain loop/recursion unwinding depth)
from a non-deterministically initialised state of the contract. For the moment depths are fixed and not parameterisable.

For contract *C* in Solidity file on *filepath*, verification with the contract harness can be executed with command:
> Solidifier filepath C

For contract *C* and its function *func* in Solidity file on *filepath*, verification with the function harness can be carried out with command:
> Solidifier filepath C func

Solidifier supports a core subset of Solidity. We currently support a subset of Solidity 0.4.* - 0.6.* but we plan to support versions 0.7.* in the future.
It is a research project and not a product. Solidifier comes "as is". Please report bugs you might find and we will try to fix them as soon as we can. Questions about Solidifier
are also welcome.

For each version supported we have a folder with a binary built for Ubuntu 18.04, subfolders with some examples,
and a [Dockerfile](https://docs.docker.com/engine/reference/builder/) that can be used to create a container with the binary and examples.
The examples in subfolders *azure* and *azure_fixed* are modified versions of [samples for the Azure blockchain](https://github.com/Azure-Samples/blockchain/tree/master/blockchain-workbench/application-and-smart-contract-samples).
While *azure* contain examples annotated with some properties, *azure_fixed* present changes to make the examples meet their corresponding properties.
In subfolder *others*, *Voting.sol* and *OpenAuction.sol* are modified versions of examples given in the [Solidity documentation](https://solidity.readthedocs.io/) whereas all the others were create by us.

Subfolder *evaluation* provides the material that we used to conduct an evaluation of Solidifier.
We provide a Dockerfile that can be used to create a container with the examples we used and the tools that we compared Solidifier against: [solc-verify](https://github.com/SRI-CSL/solidity/blob/boogie/SOLC-VERIFY-README.md),
[VeriSol](https://github.com/microsoft/verisol), and [Mythril](https://github.com/ConsenSys/mythril).

We provide instructions to build and use our Docker containers below.

## Licence

Solidifier is provided "as is" and without any sort of warranty.
Solidifier may be used by anyone to run the examples we provide in this repository.
It may be used for non-commercial purposes by researchers at bona fide academic institutions.
For commercial use, or use by people in other institutions such as companies or government laboratories, please [contact us](mailto:research@tbtl.com).

## Installation

We provide a Dockerfile that can be used to create a container with our binary and examples. To create the container, first
[install docker](https://docs.docker.com/install/), then run the following commands.

To build a docker image with Solidifier and our examples, move into the folder corresponding to the Solidifier version desired and run:
> docker build -t solidifier_image -f Dockerfile .

To start a container with this image run:
> docker run -it solidifier_image bin/bash

The *Solidifier* command is available within the container. So, for example one can run it on file *Wallet.sol* with the contract harness
for contract *Wallet* as follows. This command uses SOLC_SOLIDIFIER environment variable to identify which Solidity compiler to use.
> SOLC_SOLIDIFIER=/solc-static-linux-0.5.17 Solidifier /examples/others/Wallet.sol Wallet

The Solidifier binary can also be installed outside a docker container. It needs the solidity compiler and corral as *solc-solid* and *corral* in PATH.
The Dockerfile provides detailed instructions on how this can be achieved.

For the *evaluation* container, the following command can be executed to run all analyses and store results in appropriate log files:

> ./run_examples.sh > solidifier.log 2>&1 && ./run_examples_with_solc-verify.sh > solc-verify.log 2>&1 && ./run_examples_with_verisol.sh > verisol.log 2>&1 && ./run_examples_with_mythril.sh > mythril.log 2>&1
