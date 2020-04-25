const config = require('config')
const Joi = require('joi')
const elasticsearch = require('elasticsearch')
const AWS = require('aws-sdk')

const createUpdateSchema = {
  userId: Joi.number().integer().required(),
  groupId: Joi.number().integer().required(),
  handleLower: Joi.string().required(),
  handle: Joi.string(),
  wins: Joi.number().integer(),
  challenges: Joi.number().integer(),
  DATA_SCIENCE: Joi.object(),
  DESIGN: Joi.object(),
  DEVELOP: Joi.object(),
  maxRating: Joi.object()
}

const esUrl = config.get('ES_ENDPOINT')
const esApiVersion = config.get('ES_VERSION')
const esAwsRegion = config.get('ES_REGION')
let esClient
AWS.config.region = esAwsRegion

var obj = {
  getESClient: async function () {
    if (!esClient) {
      // if (/.*amazonaws.*/.test(esUrl)) {
      //   console.log("Test Fail :::::::::::: remote")
      //   esClient = new elasticsearch.Client({
      //     apiVersion: esApiVersion,
      //     hosts: esUrl,
      //     connectionClass: require('http-aws-es'), // eslint-disable-line global-require
      //     amazonES: {
      //       region: esAwsRegion,
      //       credentials: new AWS.EnvironmentCredentials('AWS')
      //     }
      //   })
      // } else {
        esClient = new elasticsearch.Client({
          apiVersion: esApiVersion,
          hosts: esUrl
        })
      // }
    }
    return esClient
  },
  exists: async function (id) {
    const client = await this.getESClient()
    return await client.exists({
      index: config.get('ES_STATS_INDEX'),
      type: config.get('ES_STATS_MAPPING'),
      id: id
    })
  },
  get: async function (id) {
    const client = await this.getESClient()
    var response = await client.get({
      index: config.get('ES_STATS_INDEX'),
      type: config.get('ES_STATS_MAPPING'),
      id: id
    })
    return obj.checkStatus(response)
  },
  create: async function (id, data) {
    const { error } = Joi.validate(data, createUpdateSchema, { abortEarly: false });
    if (error)
      return error

    const client = await this.getESClient()

    if(!await obj.exists(id)) {
      var response = await client.create({
        index: config.get('ES_STATS_INDEX'),
        type: config.get('ES_STATS_MAPPING'),
        id,
        body: data
      })
      return obj.checkStatus(response)
    } else {
      var errMsg = { "errorMessage": "Doc Exists In ES : " + id }
      return obj.checkStatus(errMsg)
    }
  },
  update: async function (id, data) {
    const { error } = Joi.validate(data, createUpdateSchema, { abortEarly: false });
    if (error)
      return error

    const client = await this.getESClient()
    var response = await client.update({
      index: config.get('ES_STATS_INDEX'),
      type: config.get('ES_STATS_MAPPING'),
      id: id,
      body: {
        doc: data,
        doc_as_upsert: true
      }
    })
    return obj.checkStatus(response)
  },
  remove: async function (id) {
    const client = await this.getESClient()
    if(await obj.exists(id)) {
      var response = await client.delete({
        index: config.get('ES_STATS_INDEX'),
        type: config.get('ES_STATS_MAPPING'),
        id
      })
      return obj.checkStatus(response)
    } else {
      var errMsg = { "errorMessage": "Not Found In ES : " + id }
      return obj.checkStatus(errMsg)
    }
  },
  checkStatus: async function (response) {
    var status = { "statusCode": 0, "statusMessage": "" }
    if(response.errorMessage) {
      status.statusCode = 500
      status.statusMessage = response.errorMessage
    } else if (response._shards) {
      if (response._shards.successful > 0) {
        status.statusCode = 200
        status.statusMessage = "Ok, Success"
      } else {
        status.statusCode = 202
        status.statusMessage = "Accepted, Success"
      }
    }
    return status
  }
};

module.exports = obj;