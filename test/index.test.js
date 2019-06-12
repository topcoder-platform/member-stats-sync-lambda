const index = require('../index.js');
const insertRecord = require('../test_data/test_insert.json');

test('Post Document to Elastic Search', () => {
    index.postDocumentToES = jest.fn();
    index.handleSync(insertRecord, {}, {});
    expect(index.postDocumentToES).toHaveBeenCalledTimes(1);
    expect(index.postDocumentToES).toBeCalledWith(insertRecord.Records[0].eventName, insertRecord.Records[0].dynamodb.NewImage, insertRecord.Records[0].dynamodb.Keys, {});
});