<!-- /src/components/QuestionDetails.vue -->
<template>
  <div class="max-w-screen-lg mx-auto p-6 mt-16 bg-white dark:bg-black border border-gray-300 dark:border-gray-600 rounded shadow">
    <!-- Title -->
    <h2 class="text-3xl font-bold text-black dark:text-white hover:underline">
      {{ question?.title }}
    </h2>

    <!-- Question Body -->
    <div class="mt-4 text-black dark:text-white" v-html="question?.body"></div>

    <!-- Asked By -->
    <p class="text-sm text-gray-600 dark:text-gray-400 mt-4">
      Asked by {{ question?.user.name }}
    </p>

    <!-- Comments Section -->
    <h3 class="text-md font-bold mt-6 text-black dark:text-white">Comments</h3>
    <ul class="space-y-4 mt-2">
      <li
        v-for="comment in question?.comments ?? []"
        :key="comment.id"
        class="bg-gray-50 dark:bg-gray-800"
      >
        <CommentItem :comment="comment" />
      </li>
      <li v-if="!question?.comments || question.comments.length === 0">
        <p class="text-gray-600 dark:text-gray-400">No comments yet.</p>
      </li>
    </ul>

    <!-- Answers Section -->
    <h3 class="text-2xl font-bold mt-8 text-black dark:text-white">Answers</h3>
    <ul class="space-y-4 mt-2">
      <li
        v-for="answer in question?.answers ?? []"
        :key="answer.id"
        class="bg-gray-50 dark:bg-gray-800 p-4 rounded border border-gray-300 dark:border-gray-600 shadow"
      >
        <AnswerItem :answer="answer" />
      </li>
      <li v-if="!question?.answers || question.answers.length === 0">
        <p class="text-gray-600 dark:text-gray-400">No answers yet.</p>
      </li>
    </ul>

    <!-- Add Answer Button -->
    <button
      type="button"
      class="w-full py-2 px-4 mt-6 bg-black text-white hover:bg-gray-800 dark:bg-white dark:text-black dark:hover:bg-gray-300 rounded font-semibold"
    >
      Add an Answer
    </button>
  </div>
</template>

<script setup lang="ts">
import { useQuestionsStore } from "../stores/questions";
import { onMounted, computed } from "vue";
import { useRoute } from "vue-router";
import AnswerItem from "../components/AnswerItem.vue";
import CommentItem from "./CommentItem.vue";

const route = useRoute();
const questionsStore = useQuestionsStore();

onMounted(() => {
  const questionId = Number(route.params.id);
  questionsStore.fetchQuestionDetails(questionId);
});

const question = computed(() => questionsStore.selectedQuestion);
</script>
