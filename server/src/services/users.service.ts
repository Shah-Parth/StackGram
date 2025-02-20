import { hash } from 'argon2';
import { Service } from 'typedi';
import { DataSource } from 'typeorm';
import { HttpException } from '@exceptions/httpException';
import { User } from '@entities/User';

@Service()
export class UserService {
  private userRepositoy = this.dataSource.getRepository(User);

  constructor(private dataSource: DataSource) {}

  public async findAllUser(): Promise<User[]> {
    const users: User[] = await this.userRepositoy.find();
    return users;
  }

  public async findUserById(userId: number): Promise<User> {
    const findUser: User = await this.userRepositoy.findOne({ where: { id: userId } });
    if (!findUser) throw new HttpException(409, "User doesn't exist");

    return findUser;
  }

  public async createUser(userData: User): Promise<User> {
    const findUser: User = await this.userRepositoy.findOne({ where: { email: userData.email } });
    if (findUser) throw new HttpException(409, `This email ${userData.email} already exists`);

    // hash the password
    const hashedPassword = await hash(userData.password);
    userData.password = hashedPassword;
    // create a new user instance
    const newUser: User = this.userRepositoy.create(userData);

    // Save the new user to the database
    const savedUser = await this.userRepositoy.save(newUser);

    return savedUser;
  }

  public async updateUser(userId: number, userData: User): Promise<User> {
    const findUser: User = await this.userRepositoy.findOne({ where: { id: userId } });
    if (!findUser) throw new HttpException(409, "User doesn't exist");

    // hash the password
    const hashedPassword = await hash(userData.password);
    userData.password = hashedPassword;

    await this.userRepositoy.update(userId, userData);
    const updatedUser: User = await this.userRepositoy.findOne({ where: { id: userId } });

    return updatedUser;
  }

  public async deleteUser(userId: number): Promise<User> {
    const findUser: User = await this.userRepositoy.findOne({ where: { id: userId } });
    if (!findUser) throw new HttpException(409, "User doesn't exist");

    await this.userRepositoy.delete(userId);
    return findUser;
  }
}
