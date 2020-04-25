module.exports = {
  ES_ENDPOINT: process.env.ES_ENDPOINT || "",
  ES_REGION: process.env.ES_REGION || "",
  ES_VERSION: process.env.ES_VERSION || "",
  ES_STATS_INDEX: process.env.ES_STATS_INDEX || "",
  ES_STATS_MAPPING: process.env.ES_STATS_MAPPING || "",
  DB_STATS_PUBLIC_STREAM: process.env.DB_STATS_PUBLIC_STREAM || "",
  DB_STATS_PRIVATE_STREAM: process.env.DB_STATS_PRIVATE_STREAM || "",
  LAMBDA_ROLE: process.env.LAMBDA_ROLE || ""
}