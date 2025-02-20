import { Router } from 'express';
import { QuestionController } from '@controllers/questions.controller';
import { CreateQuestionDto } from '@dtos/questions.dto';
import { Routes } from '@interfaces/routes.interface';
import { ValidationMiddleware } from '@middlewares/validation.middleware';

export class QuestionRoute implements Routes {
  public path = '/questions';
  public router = Router();
  public question = new QuestionController();

  constructor() {
    this.initializeRoutes();
  }

  private initializeRoutes() {
    this.router.get(`${this.path}`, this.question.getQuestions);
    this.router.get(`${this.path}/:id(\\d+)`, this.question.getQuestionById);
    this.router.post(`${this.path}`, ValidationMiddleware(CreateQuestionDto, true), this.question.createQuestion);
    this.router.put(`${this.path}/:id(\\d+)`, ValidationMiddleware(CreateQuestionDto, true, true), this.question.updateQuestion);
    this.router.delete(`${this.path}/:id(\\d+)`, this.question.deleteQuestion);
  }
}
