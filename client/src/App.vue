<template>
  <div>
    <!-- Show NavBar only if the user is logged in -->
    <NavBar v-if="authStore.isLoggedIn" />
    <!-- Render the current route -->
    <router-view />
  </div>
</template>

<script setup lang="ts">
import { useAuthStore } from './stores/auth';
import NavBar from './components/NavBar.vue';

const authStore = useAuthStore();
</script>