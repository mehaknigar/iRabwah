const functions = require('firebase-functions');

exports.nonce = functions.https.onRequest(async (req, res) => {
    return res.status(200).json('Bearer EAAAEPiimzzKr3bRxlMWYo5bn5pdvpY87i-N_CuQcZXcmf6f40_MDChhR0ZMp14l'); //  !!! THIS CODE MUST NEED TO BE REPLACED BY YOURS !!! 
})
