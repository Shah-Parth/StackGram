// import { hash } from 'bcrypt';
import { Service } from 'typedi';
import { DataSource } from 'typeorm';
import { HttpException } from '@exceptions/httpException';
import { plainToInstance } from 'class-transformer';
import { User } from '@entities/User';
import { Question } from '@entities/Question';

@Service()
export class QuestionService {
  private userRepository = this.dataSource.getRepository(User);
  private questionRepository = this.dataSource.getRepository(Question);

  constructor(private dataSource: DataSource) {}

  public async findAllQuestion(page: number, limit: number): Promise<{ total: number; page: number; questions: Question[] }> {
    const [rawQuestions, total] = await this.questionRepository.findAndCount({
      relations: [
        'user', // The user who asked the question
        'answers', // All answers for the question
        'answers.user', // The user associated with each answer
        'answers.comments', // Comments for each answer
        'answers.comments.user', // The user associated with each answer comment
        'comments', // Comments directly on the question
        'comments.user', // The user associated with each question comment
      ],
      skip: (page - 1) * limit,
      take: limit,
    });
    const questions = plainToInstance(Question, rawQuestions);
    return { total, page, questions };
  }

  public async findQuestionById(questionId: number): Promise<Question> {
    const findQuestion: Question = await this.questionRepository.findOne({
      where: { id: questionId },
      relations: [
        'user', // The user who asked the question
        'answers', // All answers for the question
        'answers.user', // The user associated with each answer
        'answers.comments', // Comments for each answer
        'answers.comments.user', // The user associated with each answer comment
        'comments', // Comments directly on the question
        'comments.user', // The user associated with each question comment
      ],
    });
    if (!findQuestion) throw new HttpException(409, "Question doesn't exist");

    return findQuestion;
  }

  public async createQuestion(questionData: Partial<Question>, userId: number): Promise<Question> {
    // Find the user who is creating the question
    const user = await this.userRepository.findOneBy({ id: userId });
    if (!user) throw new Error(`User with id ${userId} not found`);

    // Check if a question with the same title already exists
    const existingQuestion = await this.questionRepository.findOneBy({ title: questionData.title });
    if (existingQuestion) throw new Error(`A question with the title "${questionData.title}" already exists`);

    // Create a new question instance
    const newQuestion = this.questionRepository.create({
      ...questionData,
      user: user, // Associate the question with the user
    });

    // Save the new question to the database
    const savedQuestion = await this.questionRepository.save(newQuestion);

    return savedQuestion;
  }

  public async updateQuestion(questionId: number, questionData: Question): Promise<Question> {
    const findQuestion: Question = await this.questionRepository.findOneBy({ id: questionId });
    if (!findQuestion) throw new HttpException(409, "Question doesn't exist");

    await this.questionRepository.update({ id: questionId }, questionData);
    const updatedQuestion: Question = await this.questionRepository.findOneBy({ id: questionId });

    return updatedQuestion;
  }

  public async deleteQuestion(questionId: number): Promise<Question> {
    const findQuestion: Question = await this.questionRepository.findOneBy({ id: questionId });
    if (!findQuestion) throw new HttpException(409, "Question doesn't exist");

    await this.questionRepository.delete({ id: questionId });
    return findQuestion;
  }
}
