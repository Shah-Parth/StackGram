// src/router/index.ts
import { createRouter, createWebHistory } from 'vue-router';
import Login from '../components/Login.vue';
import HomeView from '../views/HomeView.vue';
import QuestionView from '../views/QuestionView.vue';
import { useAuthStore } from '../stores/auth';

const routes = [
    {
        path: '/login',
        name: 'Login',
        component: Login,
    },
    {
        path: '/',
        name: 'Home',
        component: HomeView,
        meta: { requiresAuth: true },
    },
    {
        path: '/questions/:id',
        name: 'Question',
        component: QuestionView,
        meta: { requiresAuth: true },
    },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

// Optional: Global guard to protect routes that require authentication
router.beforeEach((to, from, next) => {
    const authStore = useAuthStore();

    if (to.meta.requiresAuth && !authStore.isLoggedIn) {
        // User not logged in: redirect to login
        next({ name: 'Login' });
    } else if (to.name === 'Login' && authStore.isLoggedIn) {
        // If logged in and trying to access login page, redirect to home
        next({ name: 'Home' });
    } else {
        next();
    }
});

export default router;
