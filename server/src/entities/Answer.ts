import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, AfterInsert, AfterUpdate, AfterRemove, OneToMany } from 'typeorm';
import { User } from './User';
import { Question } from './Question';
import { Comment } from './Comment';
import elasticClient from '@/elasticsearch';

@Entity({ name: 'answers' })
export class Answer {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'text', default: '', nullable: false })
  body: string;

  @Column({ name: 'creation_date', type: 'integer' })
  creationDate: number;

  @Column('integer')
  score: number;

  @Column('boolean')
  accepted: boolean;

  @ManyToOne(() => User, user => user.answers, { onDelete: 'CASCADE' })
  user: User;

  // Each answer belongs to a question
  @ManyToOne(() => Question, question => question.answers, { onDelete: 'CASCADE' })
  question: Question;

  // An answer can have multiple comments
  @OneToMany(() => Comment, comment => comment.answer, { cascade: true })
  comments: Comment[];

  @AfterInsert()
  async IndexAnswer() {
    await elasticClient.index({
      index: 'answers',
      id: this.id.toString(),
      body: {
        body: this.body,
        userId: this.user.id,
        questionId: this.question.id,
      },
    });
  }

  @AfterUpdate()
  async UpdateAnswerIndex() {
    await elasticClient.update({
      index: 'answers',
      id: this.id.toString(),
      body: {
        doc: {
          body: this.body,
          userId: this.user.id,
          questionId: this.question.id,
        },
      },
    });
  }

  @AfterRemove()
  async DeleteAnswerIndex() {
    await elasticClient.delete({
      index: 'answers',
      id: this.id.toString(),
    });
  }
}
