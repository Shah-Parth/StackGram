// src/elasticsearch/init.ts
import elasticClient from '.';

async function initializeIndex() {
  const indexExists = await elasticClient.indices.exists({ index: 'questions' });

  if (!indexExists) {
    await elasticClient.indices.create({
      index: 'questions',
      body: {
        mappings: {
          properties: {
            title: { type: 'text' },
            body: { type: 'text' },
          },
        },
      },
    });
  }
}

initializeIndex().catch(console.error);
