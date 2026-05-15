<script setup>
defineProps({
  steps: {
    type: Array,
    default: () => []
  }
})
</script>

<template>
  <ul class="step-list">
    <li v-for="(step, index) in steps" :key="index">
      <span class="step-number">{{ index + 1 }}</span>
      <span>{{ step }}</span>
    </li>
  </ul>
  <slot />
</template>
