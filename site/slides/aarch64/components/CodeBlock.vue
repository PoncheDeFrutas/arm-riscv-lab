<script setup>
defineProps({
  title: {
    type: String,
    default: ''
  },
  lang: {
    type: String,
    default: 'asm'
  }
})
</script>

<template>
  <div class="code-block">
    <div v-if="title" class="code-caption">{{ title }}</div>
    <slot />
  </div>
</template>
