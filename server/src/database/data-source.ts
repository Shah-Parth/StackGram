import { DataSource } from 'typeorm';
import { Container } from 'typedi';
import { join } from 'path';
import { POSTGRES_USER, POSTGRES_PASSWORD, POSTGRES_HOST, POSTGRES_PORT, POSTGRES_DB } from '@config';

export const AppDataSource = new DataSource({
  type: 'postgres',
  host: POSTGRES_HOST,
  port: parseInt(POSTGRES_PORT, 10),
  username: POSTGRES_USER,
  password: POSTGRES_PASSWORD,
  database: POSTGRES_DB,
  synchronize: false,
  logging: false,
  entities: [join(__dirname, '../entities/*.ts')],
  migrations: [join(__dirname, '../migrations/*.ts')],
  subscribers: [join(__dirname, '../subscribers/*.ts')],
});

// Register DataSource with TypeDI
Container.set(DataSource, AppDataSource);
