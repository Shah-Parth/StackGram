<!-- /src/components/QuestionList.vue -->
<template>
  <div class="flex flex-col items-center justify-center min-h-screen bg-white dark:bg-black">
    <div class="w-full max-w-3xl p-8 mt-8">
      <h2 class="mb-6 text-2xl font-bold text-black dark:text-white">
        Questions
      </h2>
      <ul class="space-y-4">
        <QuestionItem
          v-for="question in questionsStore.questions"
          :key="question.id"
          :question="question"
        />
      </ul>
      <div class="flex justify-between mt-6">
        <button
          @click="questionsStore.previousPage"
          :disabled="questionsStore.currentPage === 1"
          class="py-2 px-4 bg-black text-white hover:bg-gray-800 dark:bg-white dark:text-black dark:hover:bg-gray-300 rounded font-semibold disabled:opacity-50"
        >
          Previous
        </button>
        <button
          @click="questionsStore.nextPage"
          :disabled="questionsStore.currentPage === questionsStore.totalPages"
          class="py-2 px-4 bg-black text-white hover:bg-gray-800 dark:bg-white dark:text-black dark:hover:bg-gray-300 rounded font-semibold disabled:opacity-50"
        >
          Next
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onMounted } from "vue";
import { useQuestionsStore } from "../stores/questions";
import QuestionItem from "../components/QuestionItem.vue";

const questionsStore = useQuestionsStore();

onMounted(() => {
  questionsStore.fetchQuestions();
});
</script>
