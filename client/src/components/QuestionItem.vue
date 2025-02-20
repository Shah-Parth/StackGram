<!-- /src/components/QuestionItem.vue -->
<template>
  <li class="bg-white dark:bg-black border border-gray-300 dark:border-gray-600 p-4 mb-4 rounded shadow">
    <router-link
      :to="`/questions/${question.id}`"
      class="text-xl font-semibold text-black dark:text-white hover:underline"
    >
      {{ question.title }}
    </router-link>
    <p class="text-sm text-gray-600 dark:text-gray-400 mt-2">
      Asked by {{ question.user.name }}
    </p>
  </li>
</template>

<script setup lang="ts">
import type { IQuestion } from "../stores/questions";
const props = defineProps<{ question: IQuestion }>();
</script>

