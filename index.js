const util = require('./utils/util.js');
const elasticsearch = require('./utils/elastic-search.js');

exports.handleSync = async (event, context, callback) => {
  for (let count = 0; count < event.Records.length; count++) {
    var record = event.Records[count]
    if (record.eventName === "MODIFY" || record.eventName === "INSERT" || record.eventName === "REMOVE") {
      const keys = util.unmarshallKeys(record.dynamodb.Keys)
      if(keys.groupId) {
        var id = keys.userId + "_" + keys.groupId
        var doc = util.unmarshallToEsDocument(record.dynamodb.NewImage)
        await postDocumentToES(record.eventName, doc, id, callback)
      } else {
        var id = keys.userId + "_10"
        var doc = util.unmarshallToEsDocument(record.dynamodb.NewImage)
        doc.groupId = "10"
        await postDocumentToES(record.eventName, doc, id, callback)
      }
    }
  }
}

async function postDocumentToES(eventName, doc, id, callback) {
  if (eventName === "INSERT") {
    console.log("INSERT event listener");
    callback(null, await elasticsearch.create(id, doc))
  } else if (eventName === "MODIFY") {
    console.log("MODIFY event listener");
    callback(null, await elasticsearch.update(id, doc))
  } else if (eventName === "REMOVE") {
    console.log("REMOVE event listener");
    callback(null, await elasticsearch.remove(id))
  }
}

// function postDocumentToES is exported to support Jest mocking in Unit Test
//exports.postDocumentToES = postDocumentToES;