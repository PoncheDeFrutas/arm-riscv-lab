<script setup>
defineProps({
  name: {
    type: String,
    required: true
  },
  bits: {
    type: String,
    default: '64'
  },
  description: {
    type: String,
    default: ''
  }
})
</script>

<template>
  <span class="reg" :title="description">{{ name }}</span>
</template>
