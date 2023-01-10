//=============================
// NodeJS to SAP Hana 
//Author : Anan P.
//Email : hs1gab@gmail.com 
//=============================
const hana = require('@sap/hana-client');
const connectionParams = {
  serverNode: '<host>:<port>',
  uid: '<user>',
  pwd: '<password>'
};

const client = hana.createClient(connectionParams);

client.connect((err) => {
  if (err) {
    return console.error('Connect error', err);
  }

  const sql = 'SELECT * FROM users';

  client.exec(sql, (err, rows) => {
    if (err) {
      return console.error('Execute error:', err);
    }

    // console.log('Results:', rows[1].USERNAME);
    console.log('Results:', rows);
    client.disconnect();
  });
});
