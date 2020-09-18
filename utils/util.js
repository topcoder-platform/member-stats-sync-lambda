const _ = require('lodash')
const AWS = require('aws-sdk')

/**
 * Unmarshall the DynamoDB Keys
 * @param {Object} doc DynamoDB keys
 * @returns {Object} Elastic document
 */
exports.unmarshallKeys = function (keys) {
  return AWS.DynamoDB.Converter.unmarshall(keys)
}

/**
 * Unmarshall DynamoDB payload into a document that can be inserted into ES.
 * @param {Object} doc DynamoDB payload
 * @returns {Object} Elastic document
 */
exports.unmarshallToEsDocument = function (payload) {
  var payload = AWS.DynamoDB.Converter.unmarshall(payload)
  if(payload.hasOwnProperty("DESIGN")) {
    payload.DESIGN = JSON.parse(payload.DESIGN);
  }
  if(payload.hasOwnProperty("DATA_SCIENCE")) {
    payload.DATA_SCIENCE = JSON.parse(payload.DATA_SCIENCE);
  }
  if(payload.hasOwnProperty("maxRating")) {
    payload.maxRating = JSON.parse(payload.maxRating);
  }
  if(payload.hasOwnProperty("DEVELOP")) {
    payload.DEVELOP = JSON.parse(payload.DEVELOP);
  }
  return payload
}