curl --location --request PUT "${ES_BASE_URI:-http://localhost:9200}/memberstats" \
--header 'Content-Type: application/json' \
--data-raw '{
  "settings": {
    "index": {
      "number_of_shards": 5,
      "number_of_replicas": 1,
      "max_ngram_diff": 17,
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
    "properties": {
      "userId": {
        "type": "long"
      },
      "handle": {
        "type": "text",
        "fields": {
          "phrase": {
            "type": "text",
            "analyzer": "ngram_analyzer",
            "search_analyzer": "standard"
          }
        },
        "analyzer": "keyword_analyzer"
      },
      "handleLower": {
        "type": "text"
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
            "type": "text"
          },
          "track": {
            "type": "text"
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
                "type": "text"
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
                    "type": "text"
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
                    "type": "text"
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
                    "type": "text"
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
                    "type": "text"
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
                    "type": "text"
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
                "type": "text"
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
                    "type": "text"
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
                    "type": "text"
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
                "type": "text"
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
                "type": "text"
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
}'