<script setup>
defineProps({
  annotations: {
    type: Array,
    default: () => []
  }
})
</script>

<template>
  <div class="code-annotation">
    <div class="code-side">
      <slot />
    </div>
    <div class="annotations-side">
      <div
        v-for="(annotation, index) in annotations"
        :key="index"
        class="annotation-item"
      >
        <span class="annotation-num">{{ annotation.num }}</span>
        <span class="annotation-text">{{ annotation.text }}</span>
      </div>
    </div>
  </div>
</template>

<style scoped>
.code-annotation {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
  max-height: calc(100vh - 140px);
  align-items: start;
}
.code-side {
  overflow-x: auto;
  overflow-y: auto;
  min-width: 0;
}
.code-side :deep(pre) {
  margin: 0;
  font-size: 0.8rem;
}
.code-side :deep(code) {
  font-size: 0.8rem;
  line-height: 1.4;
}
.annotations-side {
  display: flex;
  flex-direction: column;
  gap: 0.375rem;
  max-height: calc(100vh - 140px);
  overflow-y: auto;
  padding-right: 0.25rem;
}
.annotations-side::-webkit-scrollbar {
  width: 4px;
}
.annotations-side::-webkit-scrollbar-thumb {
  background: rgba(0,0,0,0.2);
  border-radius: 2px;
}
.annotation-item {
  display: flex;
  align-items: flex-start;
  gap: 0.5rem;
  padding: 0.4rem 0.6rem;
  border-radius: 0.25rem;
  background-color: var(--aa-annotation-bg, #f8fafc);
  border: 1px solid var(--aa-border-color, #e2e8f0);
}
.annotation-num {
  font-family: ui-monospace, SFMono-Regular, monospace;
  font-size: 0.8rem;
  font-weight: 700;
  color: var(--aa-annotation-num-text, #2563eb);
  background-color: var(--aa-annotation-num-bg, #dbeafe);
  padding: 0.1rem 0.4rem;
  border-radius: 0.25rem;
  flex-shrink: 0;
}
.annotation-text {
  font-size: 0.8rem;
  color: var(--aa-text-secondary, #334155);
  line-height: 1.4;
}
</style>
