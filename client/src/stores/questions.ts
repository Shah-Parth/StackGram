import { defineStore } from 'pinia';
import axios from 'axios';

// Define the interfaces for the expected data shape.
interface IUser {
    id: number;
    name: string;
    email?: string;
}

export interface IComment {
    id: number;
    body: string;
    creationDate: number;
    score: number;
    user: IUser;
}

export interface IAnswer {
    id: number;
    body: string;
    creationDate: number;
    score: number;
    accepted: boolean;
    user: IUser;
    comments: IComment[];
}

export interface IQuestion {
    id: number;
    title: string;
    body: string;
    creationDate: number;
    score: number;
    user: IUser;
    answers: IAnswer[];
    comments: IComment[];
}

interface IQuestionsResponse {
    total: number;
    page: number;
    questions: IQuestion[];
}

export const useQuestionsStore = defineStore('questions', {
    state: (): {
        questions: IQuestion[];
        selectedQuestion: IQuestion | null;
        currentPage: number;
        total: number;
        limit: number;
    } => ({
        questions: [],
        selectedQuestion: null,
        currentPage: 1,
        total: 0,
        limit: 10,
    }),
    getters: {
        totalPages(state): number {
            return Math.ceil(state.total / state.limit);
        },
    },
    actions: {
        async fetchQuestions(page = 1, limit = 10) {
            // The API returns an object with a "data" property containing total, page, and questions.
            const response = await axios.get<{ data: IQuestionsResponse }>(
                `http://localhost/questions?page=${page}&limit=${limit}`
            );
            const data = response.data.data;
            this.questions = data.questions;
            this.currentPage = data.page;
            this.total = data.total;
            this.limit = limit;
        },
        async fetchQuestionDetails(id: number) {
            const response = await axios.get<{ data: IQuestion }>(
                `http://localhost/questions/${id}`
            );
            this.selectedQuestion = response.data.data;
        },
        async nextPage() {
            if (this.currentPage < this.totalPages) {
                await this.fetchQuestions(this.currentPage + 1, this.limit);
            }
        },
        async previousPage() {
            if (this.currentPage > 1) {
                await this.fetchQuestions(this.currentPage - 1, this.limit);
            }
        },
    },
});
