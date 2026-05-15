<script setup>
defineProps({
  number: {
    type: [String, Number],
    required: true
  },
  name: {
    type: String,
    required: true
  },
  args: {
    type: Array,
    default: () => []
  },
  description: {
    type: String,
    default: ''
  }
})
</script>

<template>
  <div class="card">
    <div class="flex items-center gap-2 mb-2">
      <span class="syscall">syscall {{ number }}</span>
      <span class="font-semibold">{{ name }}</span>
    </div>
    <div v-if="args.length" class="text-sm mb-2">
      <div v-for="(arg, i) in args" :key="i" class="mb-1">
        <span class="reg">x{{ i }}</span> = {{ arg }}
      </div>
    </div>
    <p v-if="description" class="text-sm text-gray-600">{{ description }}</p>
  </div>
</template>
