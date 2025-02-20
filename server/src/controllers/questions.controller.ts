import { NextFunction, Request, Response } from 'express';
import { Container } from 'typedi';
import { Question } from '@entities/Question';
import { QuestionService } from '@services/questions.service';

export class QuestionController {
  public question = Container.get(QuestionService);

  public getQuestions = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const page = req.query.page ? parseInt(req.query.page as string, 10) : 1;
      const limit = req.query.limit ? parseInt(req.query.limit as string, 10) : 10;
      const { total, page: currentPage, questions } = await this.question.findAllQuestion(page, limit);
      res.status(200).json({ data: { total, page: currentPage, questions }, message: 'findAll' });
    } catch (error) {
      next(error);
    }
  };

  public getQuestionById = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const questionId = Number(req.params.id);
      const findOneQuestionData: Question = await this.question.findQuestionById(questionId);

      res.status(200).json({ data: findOneQuestionData, message: 'findOne' });
    } catch (error) {
      next(error);
    }
  };

  public createQuestion = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const questionData: Question = req.body.question;
      const userId = req.body.userId;
      const createQuestionData: Question = await this.question.createQuestion(questionData, userId);

      res.status(201).json({ data: createQuestionData, message: 'created' });
    } catch (error) {
      next(error);
    }
  };

  public updateQuestion = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const questionId = Number(req.params.id);
      const questionData: Question = req.body;
      const updateQuestionData: Question = await this.question.updateQuestion(questionId, questionData);

      res.status(200).json({ data: updateQuestionData, message: 'updated' });
    } catch (error) {
      next(error);
    }
  };

  public deleteQuestion = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const questionId = Number(req.params.id);
      const deleteQuestionData: Question = await this.question.deleteQuestion(questionId);

      res.status(200).json({ data: deleteQuestionData, message: 'deleted' });
    } catch (error) {
      next(error);
    }
  };
}
