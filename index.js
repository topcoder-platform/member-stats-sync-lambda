var esDomain = {
  endpoint: process.env.ES_ENDPOINT, //'http://search-es-order-f7zsro3nwrf26fx6w55unvbgve.eu-west-1.es.amazonaws.com', //process.env.ES_ENDPOINT,
  region: process.env.ES_REGION, //'eu-west-1', //
  index: process.env.ES_INDEX, //'stats',
  doctype: process.env.ES_DOCTYPE //'member'
};

const AWS = require('aws-sdk');
const path = require('path');
const endpoint =  new AWS.Endpoint(esDomain.endpoint);
const creds = new AWS.EnvironmentCredentials('AWS');
const util = require('./utils/util.js');

exports.handleSync = (event, context, callback) => {
  event.Records.forEach(record => {
    if(record.eventName === "MODIFY" || record.eventName === "INSERT" || record.eventName === "REMOVE") {
      exports.postDocumentToES(record.eventName, record.dynamodb.NewImage, record.dynamodb.Keys, context);
    }
  }); 
}

function postDocumentToES(eventName, doc, keys, context) {
  var req = new AWS.HttpRequest(endpoint);
  var send = new AWS.NodeHttpClient();

  // generate ID for Elastic Search Document
  var id = util.generateESIndexID(keys);

  // constructing AWS Http Request based on eventName from the record 
  if(eventName === "MODIFY"){
    req.method = 'POST';
    req.path = path.join('/', esDomain.index, esDomain.doctype, id);
    req.region = esDomain.region;
    req.body = JSON.stringify(doc);
  }else if(eventName === "INSERT"){
    req.method = 'PUT';
    req.path = path.join('/', esDomain.index, esDomain.doctype, id);
    req.region = esDomain.region;
    req.body = JSON.stringify(doc); 
  }else if(eventName === "REMOVE"){
    req.method = 'DELETE';
    req.path = path.join('/', esDomain.index, esDomain.doctype, id);
    req.region = esDomain.region;
  }
  req.headers['presigned-expires'] = false;
  req.headers['Host'] = endpoint.host;
  // Sign the request (Sigv4)
  var signer = new AWS.Signers.V4(req, 'es');
  signer.addAuthorization(creds, new Date());

  // Post document to ES
  send.handleRequest(req, null, function(httpResp) {
      var body = '';
      httpResp.on('data', chunk => {body += chunk; console.log(JSON.stringify(body));});
      httpResp.on('end', chunk => context.succeed());
  }, function(err) {
      console.log('Error: ' + err);
      context.fail();
  });
}

// function postDocumentToES is exported to support Jest mocking in Unit Test
exports.postDocumentToES = postDocumentToES;