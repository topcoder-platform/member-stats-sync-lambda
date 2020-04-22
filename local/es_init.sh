curl --location --request PUT "${ES_BASE_URI:-http://localhost:9200}/memberstats" \
--header 'Content-Type: application/json' \
--header 'Content-Type: text/plain' \
--data-raw '{
  "settings": {
    "index": {
      "number_of_shards": 5,
      "number_of_replicas": 1,
      "analysis": {
        "analyzer": {
          "keyword_analyzer": {
            "filter": [
              "lowercase"
            ],
            "type": "custom",
            "tokenizer": "keyword"
          },
          "ngram_analyzer": {
            "filter": [
              "lowercase"
            ],
            "type": "custom",
            "tokenizer": "my_ngram_tokenizer"
          }
        },
        "tokenizer": {
          "my_ngram_tokenizer": {
            "type": "nGram",
            "min_gram": "3",
            "max_gram": "20"
          }
        }
      }
    }
  },
  "mappings": {
    "stats": {
      "properties": {
        "userId": {
          "type": "long"
        },
        "handle": {
          "type": "string",
          "fields": {
            "phrase": {
              "type": "string",
              "analyzer": "ngram_analyzer",
              "search_analyzer": "standard"
            }
          },
          "analyzer": "keyword_analyzer"
        },
        "handleLower": {
          "type": "string"
        },
        "groupId": {
          "type": "long"
        },
        "maxRating": {
          "properties": {
            "rating": {
              "type": "long"
            },
            "subTrack": {
              "type": "string"
            },
            "track": {
              "type": "string"
            }
          }
        },
        "challenges": {
          "type": "long"
        },
        "wins": {
          "type": "long"
        },
        "COPILOT": {
          "properties": {
            "activeContests": {
              "type": "long"
            },
            "activeProjects": {
              "type": "long"
            },
            "contests": {
              "type": "long"
            },
            "failures": {
              "type": "long"
            },
            "fulfillment": {
              "type": "double"
            },
            "projects": {
              "type": "long"
            },
            "reposts": {
              "type": "long"
            }
          }
        },
        "DATA_SCIENCE": {
          "properties": {
            "MARATHON_MATCH": {
              "properties": {
                "challenges": {
                  "type": "long"
                },
                "mostRecentEventDate": {
                  "type": "long"
                },
                "mostRecentEventName": {
                  "type": "string"
                },
                "mostRecentSubmission": {
                  "type": "long"
                },
                "rank": {
                  "properties": {
                    "avgNumSubmissions": {
                      "type": "long"
                    },
                    "avgRank": {
                      "type": "long"
                    },
                    "bestRank": {
                      "type": "long"
                    },
                    "competitions": {
                      "type": "long"
                    },
                    "countryRank": {
                      "type": "long"
                    },
                    "defaultLanguage": {
                      "type": "string"
                    },
                    "maximumRating": {
                      "type": "long"
                    },
                    "minimumRating": {
                      "type": "long"
                    },
                    "mostRecentEventDate": {
                      "type": "long"
                    },
                    "mostRecentEventName": {
                      "type": "string"
                    },
                    "percentile": {
                      "type": "double"
                    },
                    "rank": {
                      "type": "long"
                    },
                    "rating": {
                      "type": "long"
                    },
                    "schoolRank": {
                      "type": "long"
                    },
                    "topFiveFinishes": {
                      "type": "long"
                    },
                    "topTenFinishes": {
                      "type": "long"
                    },
                    "volatility": {
                      "type": "double"
                    }
                  }
                },
                "wins": {
                  "type": "long"
                }
              }
            },
            "SRM": {
              "properties": {
                "challengeDetails": {
                  "type": "nested",
                  "properties": {
                    "challenges": {
                      "type": "long"
                    },
                    "failedChallenges": {
                      "type": "long"
                    },
                    "levelName": {
                      "type": "string"
                    }
                  }
                },
                "challenges": {
                  "type": "long"
                },
                "division1": {
                  "type": "nested",
                  "properties": {
                    "levelName": {
                      "type": "string"
                    },
                    "problemsFailed": {
                      "type": "long"
                    },
                    "problemsSubmitted": {
                      "type": "long"
                    },
                    "problemsSysByTest": {
                      "type": "long"
                    }
                  }
                },
                "division2": {
                  "type": "nested",
                  "properties": {
                    "levelName": {
                      "type": "string"
                    },
                    "problemsFailed": {
                      "type": "long"
                    },
                    "problemsSubmitted": {
                      "type": "long"
                    },
                    "problemsSysByTest": {
                      "type": "long"
                    }
                  }
                },
                "mostRecentEventDate": {
                  "type": "long"
                },
                "mostRecentEventName": {
                  "type": "string"
                },
                "mostRecentSubmission": {
                  "type": "long"
                },
                "rank": {
                  "properties": {
                    "competitions": {
                      "type": "long"
                    },
                    "countryRank": {
                      "type": "long"
                    },
                    "defaultLanguage": {
                      "type": "string"
                    },
                    "maximumRating": {
                      "type": "long"
                    },
                    "minimumRating": {
                      "type": "long"
                    },
                    "mostRecentEventDate": {
                      "type": "long"
                    },
                    "mostRecentEventName": {
                      "type": "string"
                    },
                    "percentile": {
                      "type": "double"
                    },
                    "rank": {
                      "type": "long"
                    },
                    "rating": {
                      "type": "long"
                    },
                    "schoolRank": {
                      "type": "long"
                    },
                    "volatility": {
                      "type": "double"
                    }
                  }
                },
                "wins": {
                  "type": "long"
                }
              }
            },
            "challenges": {
              "type": "long"
            },
            "wins": {
              "type": "long"
            }
          }
        },
        "DESIGN": {
          "properties": {
            "challenges": {
              "type": "long"
            },
            "mostRecentEventDate": {
              "type": "long"
            },
            "mostRecentSubmission": {
              "type": "long"
            },
            "subTracks": {
              "type": "nested",
              "properties": {
                "avgPlacement": {
                  "type": "double"
                },
                "challenges": {
                  "type": "long"
                },
                "id": {
                  "type": "long"
                },
                "mostRecentEventDate": {
                  "type": "long"
                },
                "mostRecentSubmission": {
                  "type": "long"
                },
                "name": {
                  "type": "string"
                },
                "numInquiries": {
                  "type": "long"
                },
                "passedScreening": {
                  "type": "long"
                },
                "screeningSuccessRate": {
                  "type": "double"
                },
                "submissionRate": {
                  "type": "double"
                },
                "submissions": {
                  "type": "long"
                },
                "winPercent": {
                  "type": "double"
                },
                "wins": {
                  "type": "long"
                }
              }
            },
            "wins": {
              "type": "long"
            }
          }
        },
        "DEVELOP": {
          "properties": {
            "challenges": {
              "type": "long"
            },
            "mostRecentEventDate": {
              "type": "long"
            },
            "mostRecentSubmission": {
              "type": "long"
            },
            "subTracks": {
              "type": "nested",
              "properties": {
                "challenges": {
                  "type": "long"
                },
                "id": {
                  "type": "long"
                },
                "mostRecentEventDate": {
                  "type": "long"
                },
                "mostRecentSubmission": {
                  "type": "long"
                },
                "name": {
                  "type": "string"
                },
                "rank": {
                  "properties": {
                    "activeCountryRank": {
                      "type": "long"
                    },
                    "activePercentile": {
                      "type": "double"
                    },
                    "activeRank": {
                      "type": "long"
                    },
                    "activeSchoolRank": {
                      "type": "long"
                    },
                    "maxRating": {
                      "type": "long"
                    },
                    "minRating": {
                      "type": "long"
                    },
                    "overallCountryRank": {
                      "type": "long"
                    },
                    "overallPercentile": {
                      "type": "double"
                    },
                    "overallRank": {
                      "type": "long"
                    },
                    "overallSchoolRank": {
                      "type": "long"
                    },
                    "rating": {
                      "type": "long"
                    },
                    "reliability": {
                      "type": "double"
                    },
                    "volatility": {
                      "type": "long"
                    }
                  }
                },
                "submissions": {
                  "properties": {
                    "appealSuccessRate": {
                      "type": "double"
                    },
                    "appeals": {
                      "type": "long"
                    },
                    "avgPlacement": {
                      "type": "double"
                    },
                    "avgScore": {
                      "type": "double"
                    },
                    "maxScore": {
                      "type": "double"
                    },
                    "minScore": {
                      "type": "double"
                    },
                    "numInquiries": {
                      "type": "long"
                    },
                    "passedReview": {
                      "type": "long"
                    },
                    "passedScreening": {
                      "type": "long"
                    },
                    "reviewSuccessRate": {
                      "type": "double"
                    },
                    "screeningSuccessRate": {
                      "type": "double"
                    },
                    "submissionRate": {
                      "type": "double"
                    },
                    "submissions": {
                      "type": "long"
                    },
                    "winPercent": {
                      "type": "double"
                    }
                  }
                },
                "wins": {
                  "type": "long"
                }
              }
            },
            "wins": {
              "type": "long"
            }
          }
        }
      }
    }
  }
}'