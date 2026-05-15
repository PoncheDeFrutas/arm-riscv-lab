<script setup>
defineProps({
  regions: {
    type: Array,
    default: () => []
  },
  animate: {
    type: Boolean,
    default: false
  }
})
</script>

<template>
  <div class="memory-map">
    <div
      v-for="(region, index) in regions"
      :key="index"
      class="memory-region"
      :class="[`region-${region.color || 'gray'}`, { 'slidev-vclick-target': animate }]"
      v-click="animate ? index + 1 : undefined"
    >
      <div class="region-label">{{ region.label }}</div>
      <div class="region-range">
        <span v-if="region.start">{{ region.start }}</span>
        <span v-if="region.end">→ {{ region.end }}</span>
      </div>
    </div>
  </div>
</template>

<style scoped>
.memory-map {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
  max-width: 28rem;
  margin: 0 auto;
}
.memory-region {
  padding: 0.75rem 1rem;
  border-radius: 0.25rem;
  border-left: 4px solid var(--border);
  background-color: var(--bg);
  color: var(--text);
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.region-red {
  --bg: var(--aa-mm-red-bg);
  --border: var(--aa-mm-red-border);
  --text: var(--aa-mm-red-text);
}
.region-blue {
  --bg: var(--aa-mm-blue-bg);
  --border: var(--aa-mm-blue-border);
  --text: var(--aa-mm-blue-text);
}
.region-green {
  --bg: var(--aa-mm-green-bg);
  --border: var(--aa-mm-green-border);
  --text: var(--aa-mm-green-text);
}
.region-yellow {
  --bg: var(--aa-mm-yellow-bg);
  --border: var(--aa-mm-yellow-border);
  --text: var(--aa-mm-yellow-text);
}
.region-gray {
  --bg: var(--aa-mm-gray-bg);
  --border: var(--aa-mm-gray-border);
  --text: var(--aa-mm-gray-text);
}
.region-purple {
  --bg: var(--aa-mm-purple-bg);
  --border: var(--aa-mm-purple-border);
  --text: var(--aa-mm-purple-text);
}
.region-label {
  font-weight: 600;
  font-size: 0.875rem;
}
.region-range {
  font-family: ui-monospace, SFMono-Regular, monospace;
  font-size: 0.75rem;
}
</style>
