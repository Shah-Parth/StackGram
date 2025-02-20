<!-- /src/components/NavBar.vue -->
<template>
    <nav class="fixed top-0 left-0 w-full bg-white dark:bg-black shadow-md p-4 flex justify-between items-center">
      <h1 class="font-bold">StackGram</h1>
      <button 
        v-if="authStore.isLoggedIn"
        @click="handleLogout" 
        class="py-2 px-4 mt-4 bg-black text-white hover:bg-gray-800 dark:bg-white dark:text-black dark:hover:bg-gray-300 rounded font-semibold"
      >
        Logout
      </button>
    </nav>
  </template>
  
  <script setup lang="ts">
  import { useRouter } from "vue-router";
  import { useAuthStore } from '../stores/auth';
  
  const authStore = useAuthStore();
  const router = useRouter();
  
  const handleLogout = async () => {
    await authStore.logout();
    if (!authStore.isLoggedIn) {
    router.push({ name: 'Login' });
  }
  };
  </script>
  