<!-- /src/components/Login.vue -->
<template>
  <div class="flex flex-col items-center justify-center min-h-screen bg-white dark:bg-black">
    <div class="w-full max-w-sm p-8 bg-white dark:bg-black border border-gray-300 dark:border-gray-600 rounded shadow">
      <h1 class="mb-6 text-2xl font-bold text-black dark:text-white">
        Sign in to your account
      </h1>
      <form @submit.prevent="handleSubmit" class="space-y-4">
        <div>
          <label for="email" class="block mb-2 text-sm font-medium text-black dark:text-white">
            Your email
          </label>
          <input
            type="email"
            id="email"
            v-model="email"
            placeholder="name@company.com"
            required
            class="w-full p-2 border border-gray-300 rounded text-black bg-gray-50 dark:bg-gray-700 dark:border-gray-600 dark:text-white"
          />
        </div>
        <div>
          <label for="password" class="block mb-2 text-sm font-medium text-black dark:text-white">
            Password
          </label>
          <input
            type="password"
            id="password"
            v-model="password"
            placeholder="••••••••"
            required
            class="w-full p-2 border border-gray-300 rounded text-black bg-gray-50 dark:bg-gray-700 dark:border-gray-600 dark:text-white"
          />
        </div>
        <button
          type="submit"
          class="w-full py-2 px-4 mt-4 bg-black text-white hover:bg-gray-800 dark:bg-white dark:text-black dark:hover:bg-gray-300 rounded font-semibold"
        >
          Sign in
        </button>
        <p class="mt-4 text-center text-sm text-gray-600 dark:text-gray-400">
          Don’t have an account yet?
          <a href="#" class="font-medium underline text-black dark:text-white">
            Sign up
          </a>
        </p>
        <div v-if="authStore.errorMessage" class="mt-4 text-red-500">
          {{ authStore.errorMessage }}
        </div>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from "vue";
import { useRouter } from "vue-router";
import { useAuthStore } from "../stores/auth";

const email = ref("");
const password = ref("");
const authStore = useAuthStore();
const router = useRouter();

const handleSubmit = async () => {
  authStore.clearError();
  await authStore.login(email.value, password.value);
  if (authStore.isLoggedIn) {
    router.push({ name: 'Home' });
  }
};
</script>
