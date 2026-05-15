<script setup>
defineProps({
  mnemonic: {
    type: String,
    required: true
  },
  name: {
    type: String,
    required: true
  },
  syntax: {
    type: String,
    required: true
  },
  description: {
    type: String,
    default: ''
  },
  flagsAffected: {
    type: Array,
    default: () => []
  },
  example: {
    type: Object,
    default: () => ({ code: '', explanation: '' })
  },
  notes: {
    type: Array,
    default: () => []
  }
})
</script>

<template>
  <div class="instruction-card">
    <div class="instruction-header">
      <span class="instruction-mnemonic">{{ mnemonic }}</span>
      <span class="instruction-name">{{ name }}</span>
    </div>

    <div class="instruction-syntax">
      <code>{{ syntax }}</code>
    </div>

    <p v-if="description" class="instruction-description">
      {{ description }}
    </p>

    <div v-if="flagsAffected.length" class="instruction-flags">
      <span class="flags-label">Flags afectados:</span>
      <span v-for="flag in flagsAffected" :key="flag" class="flag-badge">{{ flag }}</span>
    </div>

    <div v-if="example.code" class="instruction-example">
      <div class="example-label">Ejemplo:</div>
      <pre><code class="language-asm">{{ example.code }}</code></pre>
      <div v-if="example.explanation" class="example-explanation">
        {{ example.explanation }}
      </div>
    </div>

    <ul v-if="notes.length" class="instruction-notes">
      <li v-for="(note, i) in notes" :key="i">{{ note }}</li>
    </ul>
  </div>
</template>
