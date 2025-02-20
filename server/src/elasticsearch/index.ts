// src/elasticsearch/client.ts
import { Client } from '@elastic/elasticsearch';
import { ELASTICSEARCH_HOST, ELASTICSEARCH_PORT, ELASTICSEARCH_USERNAME, ELASTICSEARCH_PASSWORD } from '@config';

const elasticClient = new Client({
  node: `http://${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}`, // Update with your ElasticSearch URL
  auth: {
    username: ELASTICSEARCH_USERNAME,
    password: ELASTICSEARCH_PASSWORD,
  },
});

export default elasticClient;
