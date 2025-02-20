// src/stores/auth.ts
import { defineStore } from 'pinia';
import axios from 'axios';

export const useAuthStore = defineStore('auth', {
    state: () => ({
        isLoggedIn: false,
        user: null,
        errorMessage: '',
    }),
    actions: {
        async login(email: string, password: string) {
            try {
                const response = await axios.post('http://localhost/login', { email, password }, { withCredentials: true });
                this.isLoggedIn = true;
                this.user = response.data.data; // Assuming backend returns user data
                this.errorMessage = '';
            } catch (error: any) {
                this.isLoggedIn = false;
                this.user = null;
                this.errorMessage = error.response?.data?.message || 'Login failed';
            }
        },
        async signup(email: string, password: string) {
            try {
                const response = await axios.post('http://localhost/signup', { email, password });
                this.errorMessage = ''; // Signup successful, clear any previous errors
            } catch (error: any) {
                this.errorMessage = error.response?.data?.message || 'Signup failed';
            }
        },
        async logout() {
            try {
                const response = await axios.post('http://localhost/logout', {}, { withCredentials: true });
                console.log(response.data); // Assuming backend returns a message
                this.isLoggedIn = false;
                this.user = null;
                this.errorMessage = '';
            } catch (error: any) {
                this.errorMessage = error.response?.data?.message || 'Logout failed';
            }
        },
        clearError() {
            this.errorMessage = '';
        },
    },
});