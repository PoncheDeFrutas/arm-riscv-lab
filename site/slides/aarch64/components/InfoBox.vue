<script setup>
defineProps({
  type: {
    type: String,
    default: 'info',
    validator: (v) => ['info', 'warning', 'success', 'note'].includes(v)
  },
  title: {
    type: String,
    default: ''
  }
})
</script>

<template>
  <div :class="['info-box', type]">
    <div v-if="title" class="font-semibold mb-1">{{ title }}</div>
    <slot />
  </div>
</template>
