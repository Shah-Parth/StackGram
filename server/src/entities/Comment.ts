import { Entity, PrimaryGeneratedColumn, Column, ManyToOne } from 'typeorm';
import { User } from './User';
import { Question } from './Question';
import { Answer } from './Answer';

@Entity({ name: 'comments' })
export class Comment {
  @PrimaryGeneratedColumn()
  id: number;

  @Column('text')
  body: string;

  @ManyToOne(() => User, user => user.answers, { onDelete: 'CASCADE' })
  user: User;

  // A Comment can belong to a Question (if applicable)
  @ManyToOne(() => Question, question => question.comments, {
    nullable: true,
    onDelete: 'CASCADE',
  })
  question: Question;

  // OR a Comment can belong to an Answer (if applicable)
  @ManyToOne(() => Answer, answer => answer.comments, {
    nullable: true,
    onDelete: 'CASCADE',
  })
  answer: Answer;
}
