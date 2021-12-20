pragma ton-solidity >= 0.39.0;

import "./IBurnableTokenRoot.sol";

/*
rootOwner -> IBurnableByRootTokenRoot(root).burnTokens(...) ->
             IBurnableByRootTokenWallet(wallet).burnByRoot(...) ->
             IBurnableTokenRoot(root).tokensBurned(...) ->
             IBurnTokensCallback(callbackTo).burnCallback(...) -> ...
*/

interface IBurnableByRootTokenRoot is IBurnableTokenRoot {

    /*
        @notice Allows for rootOwner burn tokens from any TokenWallet
        @dev This method can be disabled using `disableBurnByRoot()`
        @dev Can be called only by rootOwner
        @param amount Amount tokens to burn
        @param walletOwner TokenWallet owner address
        @param remainingGasTo Receiver of the remaining EVERs
        @param callbackTo address of contract, which implement IBurnTokensCallback.burnCallback
               if it equals to 0:0 then no callbacks
        @param payload Custom data will be delivered into IBurnTokensCallback.burnCallback
    */
    function burnTokens(
        uint128 amount,
        address walletOwner,
        address remainingGasTo,
        address callbackTo,
        TvmCell payload
    ) external;


    /*
        @notice Allows to disable `burnTokens` method forever
        @dev Can be called only by rootOwner
    */
    function disableBurnByRoot() external responsible returns(bool);

    /*
        @notice Get `burnTokens` disabled status
    */
    function isBurnByRootDisabled() external view responsible returns(bool);
}
