function profileDevice(callback) {
    // Initialize the SDK
    onPingOneSignalsReady(function () {
        _pingOneSignals.init({
            // envId: "<envid>", // uncomment and replace <envid> with the PingOne console > Environment > Environment ID value
        }).then(function () {
            console.log("PingOne Signals initialized successfully");
        }).catch(function (e) {
            console.error("SDK Init failed", e);
        });

        // get device profiling data immediately
        getDeviceProfileData(callback)

        // update device profiling data every 1 second
        setInterval(() => getDeviceProfileData(callback), 1000);
    });
}

function onPingOneSignalsReady(callback) {
    if (window['_pingOneSignalsReady']) {
        callback();
    } else {
        document.addEventListener('PingOneSignalsReadyEvent', callback);
    }
}

/**
 * Calls the getData method and with the output, calls the callback function.
 *
 * @param callback
 */
function getDeviceProfileData(callback) {
    _pingOneSignals.getData()
        .then((result) => callback(result))
        .catch((error) => console.error('getData Error!', error));
}
