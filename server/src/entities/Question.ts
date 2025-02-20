// src/entity/Question.ts
import { Entity, PrimaryGeneratedColumn, Column, AfterInsert, AfterUpdate, AfterRemove, ManyToOne, OneToMany, OneToOne, JoinColumn } from 'typeorm';
import { User } from './User';
import { Answer } from './Answer';
import { Comment } from './Comment';
import elasticClient from '@elasticsearch';

@Entity({ name: 'questions' })
export class Question {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'text', default: '', nullable: false })
  title: string;

  @Column({ type: 'text', default: '', nullable: false })
  body: string;

  @Column({ name: 'creation_date', type: 'integer' })
  creationDate: number;

  @Column('integer')
  score: number;

  @ManyToOne(() => User, user => user.questions, { onDelete: 'CASCADE' })
  user: User;

  // A question can have multiple Answers
  @OneToMany(() => Answer, answer => answer.question, { cascade: true })
  answers: Answer[];

  // A question can have multiple Comments
  @OneToMany(() => Comment, comment => comment.question, { cascade: true })
  comments: Comment[];

  @OneToOne(() => Answer, { nullable: true })
  @JoinColumn({ name: 'accepted_answer_id' })
  acceptedAnswer: Answer | null;

  @AfterInsert()
  async indexQuestion() {
    await elasticClient.index({
      index: 'questions',
      id: this.id.toString(),
      body: {
        title: this.title,
        body: this.body,
      },
    });
  }

  @AfterUpdate()
  async updateQuestionIndex() {
    await elasticClient.index({
      index: 'questions',
      id: this.id.toString(),
      body: {
        title: this.title,
        body: this.body,
      },
    });
  }

  @AfterRemove()
  async removeQuestionIndex() {
    await elasticClient.delete({
      index: 'questions',
      id: this.id.toString(),
    });
  }
}
