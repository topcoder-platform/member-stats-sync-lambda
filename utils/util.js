const _ = require('lodash')

/**
 * Generate Elastic Search Index Doc ID from Keys of DynamoDB record stream.
 * @param {Object} keys Keys of DynamoDB record stream.
 * @return {string} ID for Elastic Search Index Doc 
 * from concatenation of DynamoDB record stream keys
 */
exports.generateESIndexID = function(keys){
  var id = '';
  var jsonKeys = Object.keys(keys);
  for(var i=0; i<jsonKeys.length; i++){
    var key = jsonKeys[i];
    var jsonKeys2 = Object.keys(keys[key]);
    for(var j=0; j<jsonKeys2.length; j++){
      var key2 = jsonKeys2[j];
      if(i==jsonKeys.length-1 && j==jsonKeys2.length-1){
        id += keys[key][key2];
      }else{
        id += keys[key][key2] + "_";
      }
    }
  }
  return id;
}

/**
 * Converts a DynamoDB payload into a document that can be inserted into ES.
 * @param {Object} doc DynamoDB payload
 * @returns {Object} Elastic document
 */
exports.convertToEsDocument = function (payload) {
  const stringifiedNestedFields = [
    'DATA_SCIENCE', 'DESIGN', 'DEVELOP', 'maxRating'
  ]
  for (const key in payload) {
    if (!payload.hasOwnProperty(key)) {
      continue
    }
    const element = payload[key];
    if (element.N) {
      payload[key] = Number(element.N)
    } else if (element.S) {
      if (_.includes(stringifiedNestedFields, key)) {
        payload[key] = JSON.parse(element.S)
      } else {
        payload[key] = String(element.S)
      }
    } else {
      payload[key] = exports.convertToEsDocument(element)
    }
  }
  return payload
}