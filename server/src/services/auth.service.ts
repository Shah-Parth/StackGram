import { hash, verify } from 'argon2';
import { sign } from 'jsonwebtoken';
import { Service } from 'typedi';
import { DataSource } from 'typeorm';
import { SECRET_KEY } from '@config';
import { HttpException } from '@exceptions/httpException';
import { DataStoredInToken, TokenData } from '@interfaces/auth.interface';
import { User } from '@entities/User';

const createToken = (user: User): TokenData => {
  const dataStoredInToken: DataStoredInToken = { id: user.id };
  const expiresIn: number = 60 * 60;

  return { expiresIn, token: sign(dataStoredInToken, SECRET_KEY, { expiresIn }) };
};

const createCookie = (tokenData: TokenData): string => {
  return `Authorization=${tokenData.token}; HttpOnly; Max-Age=${tokenData.expiresIn};`;
};

@Service()
export class AuthService {
  private userRepositoy = this.dataSource.getRepository(User);

  constructor(private dataSource: DataSource) {}

  public async signup(userData: User): Promise<User> {
    const findUser: User = await this.userRepositoy.findOne({ where: { email: userData.email } });
    if (findUser) throw new HttpException(409, `This email ${userData.email} already exists`);

    const hashedPassword = await hash(userData.password);
    const createUserData: User = this.userRepositoy.create({ ...userData, password: hashedPassword });

    await this.userRepositoy.save(createUserData);
    return createUserData;
  }

  public async login(userData: User): Promise<{ cookie: string; findUser: User }> {
    const findUser: User = await this.userRepositoy.findOne({ where: { email: userData.email }, select: ['id', 'name', 'email', 'password'] });
    if (!findUser) throw new HttpException(409, `This email ${userData.email} was not found`);
    const isPasswordMatching: boolean = await verify(findUser.password, userData.password);
    if (!isPasswordMatching) throw new HttpException(409, 'Your password is not matching');

    const tokenData = createToken(findUser);
    const cookie = createCookie(tokenData);

    findUser.password = undefined;
    return { cookie, findUser };
  }

  public async logout(userData: User): Promise<User> {
    const findUser: User = await this.userRepositoy.findOne({ where: { email: userData.email, password: userData.password } });
    if (!findUser) throw new HttpException(409, "User doesn't exist");

    return findUser;
  }
}
