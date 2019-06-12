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