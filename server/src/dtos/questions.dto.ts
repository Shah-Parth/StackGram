import { IsString, IsNotEmpty, MinLength, MaxLength, IsOptional } from 'class-validator';

export class CreateQuestionDto {
  @IsString()
  @IsNotEmpty()
  @MinLength(5) // adjust as needed
  @MaxLength(100) // adjust as needed
  public title: string;

  @IsString()
  @IsNotEmpty()
  public body: string;
}

export class UpdateQuestionDto {
  @IsString()
  @IsOptional()
  @MinLength(5)
  @MaxLength(100)
  public title?: string;

  @IsString()
  @IsOptional()
  public body?: string;
}
