const util = require('../utils/util.js');
const insertRecord = require('../test_data/test_insert.json');

const trueID = "500_300";

test('Generate Elastic Search Document ID from DynamoDB Stream', () => {
    var id = util.generateESIndexID(insertRecord.Records[0].dynamodb.Keys);
    expect(id).toBe(trueID);
});