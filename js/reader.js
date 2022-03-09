let html5QrCode;
let qrCodeSuccessCallback;
let config;
let result;

window.onload = () => {
    html5QrCode = new Html5Qrcode("reader");

    qrCodeSuccessCallback = (decodedText, decodedResult) => {
        stopScanning();
        result = formatText(decodedText);
        document.getElementById("qr-reader-results").innerHTML = "Result of the scan is: " + result;
    };
    config = { fps: 10, qrbox: { width: 400, height: 400 } };

    document
        .getElementById("qr-code-scan-start-button")
        .addEventListener("click", () => {
            startScanning();
        });
    document
        .getElementById("qr-code-scan-stop-button")
        .addEventListener("click", () => {
            stopScanning();
        });
};

function startScanning() {
    html5QrCode.start(
        { facingMode: "environment" },
        config,
        qrCodeSuccessCallback
    );
}

function stopScanning() {
    html5QrCode
        .stop()
        .then((ignore) => {
            html5QrCode.clear();
        })
        .catch((err) => {
            // Stop failed, handle it.
        });
}

function formatText(text) {
    console.log("The scanned text is: " + text);
    const myArr = text.split('=');
    console.log("The split id is: " + myArr[1]); // here is our id
    return myArr[1];
};