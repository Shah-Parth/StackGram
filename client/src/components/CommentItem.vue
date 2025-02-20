<!-- /src/components/CommentItem.vue -->
<template>
  <div class="bg-gray-50 dark:bg-gray-800 border border-gray-300 dark:border-gray-600 p-4 rounded shadow">
    <!-- Comment Body -->
    <p class="text-black dark:text-white" v-html="comment.body"></p>

    <!-- Comment Author -->
    <p class="text-sm text-gray-600 dark:text-gray-400 mt-2">
      Comment by {{ comment.user.name }}
    </p>
  </div>
</template>
  
  <script setup lang="ts">
  import type { IComment } from "../stores/questions";
  const props = defineProps<{ comment: IComment }>();
  </script>
  