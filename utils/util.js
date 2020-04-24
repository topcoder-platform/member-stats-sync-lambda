const _ = require('lodash')

/**
 * Generate Elastic Search Index Doc ID from Keys of DynamoDB record stream.
 * @param {Object} keys Keys of DynamoDB record stream.
 * @return {string} ID for Elastic Search Index Doc 
 * from concatenation of DynamoDB record stream keys
 */

function getValue(keys, key) {
  obj = keys[key]
  if(obj) {
    if (obj["N"]) {
      return obj["N"]
    }

    if(obj["S"]) {
      return obj["S"]
    }
  }
}

exports.generateESIndexID = function(keys){
  var id = '';
  var idparts = [];

  // user id first
  userId = getValue(keys, "userId")
  if (userId) {
    idparts.push(userId + "")
  }

  // group id second
  userId = getValue(keys, "groupId")
  if (userId) {
    idparts.push(userId + "")
  } else {
    idparts.push("10")
  }
  
  var jsonKeys = Object.keys(keys);
  for(var i=0; i<jsonKeys.length; i++){
    var key = jsonKeys[i];

    if (key == "userId" || key == "groupId") {
      continue
    }

    v = getValue(keys, key)
    if (v) {
      idparts.push(v + "")
    }
  }

  return idparts.join("_");
}

/**
 * Converts a DynamoDB payload into a document that can be inserted into ES.
 * @param {Object} doc DynamoDB payload
 * @returns {Object} Elastic document
 */
exports.convertToEsDocument = function (payload) {
  for (const key in payload) {
    if (!payload.hasOwnProperty(key)) {
      continue
    }
    const element = payload[key];
    if (element.N) {
      payload[key] = Number(element.N)
    } else if (element.S) {
      let value = element.S
      try {
        value = JSON.parse(element.S)
      } catch(e){}
      if (!_.isString(value)) {
        payload[key] = value
      } else {
        payload[key] = String(element.S)
      }
    } else {
      payload[key] = exports.convertToEsDocument(element)
    }
  }
  return payload
}