// ***************************************************************************
// Copyright (c) 2017 SAP AG or an SAP affiliate company. All rights reserved.
// ***************************************************************************
// This sample code is provided AS IS, without warranty or liability of any kind.
//
// You may use, reproduce, modify and distribute this sample code without limitation,
// on the condition that you retain the foregoing copyright notice and disclaimer
// as to the original code.
// ***************************************************************************

// This example uses async.

'use strict';

var async = require('async');
var hana = require('@sap/hana-client');
var hanaStream = require('../extension/Stream.js');

// // HANA Cloud Example
// // DigiCert Global Root CA: https://cacerts.digicert.com/DigiCertGlobalRootCA.crt.pem
//
// var connOptions = {
//     serverNode: '12345678-abcd-12ab-34cd-1234abcd.hana.hanacloud.ondemand.com:443',
//     uid: 'User1',
//     pwd: 'Password123',
//     encrypt: 'true',
//     ssltruststore: '-----BEGIN CERTIFICATE-----MIIDrzCCApegAwIBAgIQCDvgVpBCRrGhdWrJWZHHSjANBgkqhkiG9w0BAQUFADBhMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMSAwHgYDVQQDExdEaWdpQ2VydCBHbG9iYWwgUm9vdCBDQTAeFw0wNjExMTAwMDAwMDBaFw0zMTExMTAwMDAwMDBaMGExCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xIDAeBgNVBAMTF0RpZ2lDZXJ0IEdsb2JhbCBSb290IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4jvhEXLeqKTTo1eqUKKPC3eQyaKl7hLOllsBCSDMAZOnTjC3U/dDxGkAV53ijSLdhwZAAIEJzs4bg7/fzTtxRuLWZscFs3YnFo97nh6Vfe63SKMI2tavegw5BmV/Sl0fvBf4q77uKNd0f3p4mVmFaG5cIzJLv07A6Fpt43C/dxC//AH2hdmoRBBYMql1GNXRor5H4idq9Joz+EkIYIvUX7Q6hL+hqkpMfT7PT19sdl6gSzeRntwi5m3OFBqOasv+zbMUZBfHWymeMr/y7vrTC0LUq7dBMtoM1O/4gdW7jVg/tRvoSSiicNoxBN33shbyTApOB6jtSj1etX+jkMOvJwIDAQABo2MwYTAOBgNVHQ8BAf8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUA95QNVbRTLtm8KPiGxvDl7I90VUwHwYDVR0jBBgwFoAUA95QNVbRTLtm8KPiGxvDl7I90VUwDQYJKoZIhvcNAQEFBQADggEBAMucN6pIExIK+t1EnE9SsPTfrgT1eXkIoyQY/EsrhMAtudXH/vTBH1jLuG2cenTnmCmrEbXjcKChzUyImZOMkXDiqw8cvpOp/2PV5Adg06O/nVsJ8dWO41P0jmP6P6fbtGbfYmbW0W5BjfIttep3Sp+dWOIrWcBAI+0tKIJFPnlUkiaY4IBIqDfv8NZ5YBberOgOzW6sRBc4L0na4UU+Krk2U886UAb3LujEV0lsYSEY1QSteDwsOoBrp+uvFRTp2InBuThs4pFsiv9kuXclVzDAGySj4dzp30d8tbQkCAUw7C29C79Fv1C5qfPrmAESrciIxpg0X40KPMbp1ZWVbd4=-----END CERTIFICATE-----'
// };

// HANA Platform Example
var connOptions = {
    serverNode: 'myserver:30015',
    uid: 'User1',
    pwd: 'Password123'
};

var conn = hana.createConnection();
conn.connect(connOptions);

try {
    conn.exec('drop table TEST_LOBS');
} catch (err) {
    // ignore the error
}

// Create test table
conn.exec('create table TEST_LOBS(ID integer primary key, DATA blob)');

// Insert rows
var stmt = conn.prepare('insert into TEST_LOBS valueS(?, ?)');
var buffer = null;
var ids = [1, 2, 3, 4, 5];

for (var i = 0; i < ids.length; i++) {
    buffer = new Buffer(new Array(1024 * 64 + ids[i]).join('ab'), "ascii");
    stmt.exec([ids[i], buffer]);
}

console.log('Fetch rows ......');

// Fetch rows using stream
async.eachOfLimit(ids, ids.length, function (id, i, cb) {
    var stmt = conn.prepare('select ID, DATA from TEST_LOBS where ID = ?');
    var rs = stmt.execQuery([id]);
    rs.next(function (err, ret) {
        if (err) {
            console.log(err);
        } else {
            var id = rs.getValue(0);
            var lob = [];
            var totalBytes = 0;
            var lobStream = hanaStream.createLobStream(rs, 1, { readSize: 6000 });

            lobStream.on('data', function (buffer) {
                if (buffer) {
                    totalBytes += buffer.length;
                }
            });
            lobStream.on('end', function () {
                console.log(id + ', total bytes --- ' + totalBytes);
            });
            lobStream.on('error', function (error) {
                console.log(error);
            });
        }
    });
});
