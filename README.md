
## Table Descriptions

### Users
| Column    | Type    | Description                  | Constraints    |
|-----------|---------|-----------------------------|----------------|
| id        | number  | Primary key                 | PK             |
| name      | string  | User's name                 |                |
| email     | string  | User's email                | Unique         |
| password  | string  | User's password (hidden)    | Not selectable |

Relationships:
- Has many Questions (OneToMany)
- Has many Answers (OneToMany)
- Has many Comments (OneToMany)

### Questions
| Column          | Type    | Description                  | Constraints    |
|-----------------|---------|------------------------------|----------------|
| id              | number  | Primary key                  | PK             |
| title           | text    | Question title               | Not null       |
| body            | text    | Question content             | Not null       |
| creation_date   | integer | Creation timestamp           |                |
| score           | integer | Question score               |                |
| user_id         | number  | Foreign key to Users         | FK             |
| accepted_answer_id | number | Foreign key to accepted Answer | FK, Nullable |

Relationships:
- Belongs to User (ManyToOne)
- Has many Answers (OneToMany)
- Has many Comments (OneToMany)
- Has one accepted Answer (OneToOne)

### Answers
| Column        | Type    | Description                  | Constraints    |
|---------------|---------|------------------------------|----------------|
| id            | number  | Primary key                  | PK             |
| body          | text    | Answer content               | Not null       |
| creation_date | integer | Creation timestamp           |                |
| score         | integer | Answer score                 |                |
| accepted      | boolean | Is accepted answer flag      |                |
| user_id       | number  | Foreign key to Users         | FK             |
| question_id   | number  | Foreign key to Questions     | FK             |

Relationships:
- Belongs to User (ManyToOne)
- Belongs to Question (ManyToOne)
- Has many Comments (OneToMany)

### Comments
| Column    | Type    | Description                  | Constraints    |
|-----------|---------|------------------------------|----------------|
| id        | number  | Primary key                  | PK             |
| body      | text    | Comment content              |                |
| user_id   | number  | Foreign key to Users         | FK             |

Relationships:
- Belongs to User (ManyToOne)
- Belongs to either Question or Answer (ManyToOne) [Note: Current code only shows User relationship]

## Notes
- All tables use CASCADE on delete for relationships
- The schema follows a typical Q&A platform structure similar to Stack Overflow
- Primary keys are auto-generated
- Timestamps are stored as integers
- Questions can have one accepted answer (nullable)
