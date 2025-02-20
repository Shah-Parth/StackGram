import { Entity, PrimaryGeneratedColumn, Column, OneToMany, AfterInsert, AfterUpdate, AfterRemove } from 'typeorm';
import { Question } from './Question';
import { Answer } from './Answer';
import { Comment } from './Comment';
import elasticClient from '@elasticsearch';

@Entity({ name: 'users' })
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column({ unique: true })
  email: string;

  @Column({ select: false })
  password: string;

  @OneToMany(() => Question, question => question.user, { cascade: true })
  questions: Question[];

  @OneToMany(() => Answer, answer => answer.user, { cascade: true })
  answers: Answer[];

  @OneToMany(() => Comment, comment => comment.user, { cascade: true })
  comments: Comment[];

  @AfterInsert()
  async indexUser() {
    console.log('A new user has been inserted');
    await elasticClient.index({
      index: 'users',
      id: this.id.toString(),
      body: {
        name: this.name,
      },
    });
  }

  @AfterUpdate()
  async updateUser() {
    console.log('A user has been updated');
    await elasticClient.update({
      index: 'users',
      id: this.id.toString(),
      body: {
        doc: {
          name: this.name,
        },
      },
    });
  }

  @AfterRemove()
  async deleteUser() {
    console.log('A user has been deleted');
    await elasticClient.delete({
      index: 'users',
      id: this.id.toString(),
    });
  }
}
