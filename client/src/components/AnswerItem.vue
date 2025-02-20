<!-- /src/components/AnswerItem.vue -->
<template>
  <div class="bg-gray-50 dark:bg-gray-800 p-4">
    <!-- Answer Body -->
    <div class="text-black dark:text-white" v-html="answer.body"></div>

    <!-- Answer Author -->
    <p class="text-sm text-gray-600 dark:text-gray-400 mt-2">
      Answered by {{ answer.user.name }}
    </p>

    <!-- Comments Section -->
    <h4 class="text-lg font-bold mt-4 text-black dark:text-white">Comments</h4>
    <div v-if="answer.comments && answer.comments.length > 0">
      <CommentItem
        v-for="comment in answer.comments"
        :key="comment.id"
        :comment="comment"
        class="mt-4"
      />
    </div>
    <p v-else class="text-gray-600 dark:text-gray-400 mt-2">No comments yet.</p>
  </div>
</template>
  
  <script setup lang="ts">
  import type { IAnswer } from "../stores/questions";
  import CommentItem from "../components/CommentItem.vue";
  const props = defineProps<{ answer: IAnswer }>();
  </script>
  