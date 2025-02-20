import { App } from '@/app';
import { AuthRoute } from '@routes/auth.route';
import { UserRoute } from '@routes/users.route';
import { QuestionRoute } from './routes/questions.route';
import { ValidateEnv } from '@utils/validateEnv';
import { AppDataSource } from './database/data-source';
import Container from 'typedi';

ValidateEnv();

const app = new App([new AuthRoute(), new UserRoute(), new QuestionRoute()]);

AppDataSource.initialize()
  .then(() => {
    Container.set('dataSource', AppDataSource);
    console.log('Database connected');
    app.listen();
  })
  .catch(err => {
    console.error(err);
  });
