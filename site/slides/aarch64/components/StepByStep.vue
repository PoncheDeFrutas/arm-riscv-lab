<script setup>
defineProps({
  steps: {
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
  <div class="step-by-step">
    <div
      v-for="(step, index) in steps"
      :key="index"
      class="step-row"
      :class="{ 'slidev-vclick-target': animate }"
      v-click="animate ? index + 1 : undefined"
    >
      <div class="step-index">{{ index + 1 }}</div>
      <div class="step-content">
        <div class="step-label">{{ step.label }}</div>
        <div class="step-registers">
          <span
            v-for="(value, reg) in step.registers"
            :key="reg"
            class="step-register"
          >
            <span class="reg-name">{{ reg }}</span> = <span class="reg-value">{{ value }}</span>
          </span>
        </div>
        <div v-if="step.note" class="step-note">{{ step.note }}</div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.step-by-step {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  max-height: calc(100vh - 140px);
  overflow-y: auto;
  padding-right: 0.25rem;
}
.step-by-step::-webkit-scrollbar {
  width: 4px;
}
.step-by-step::-webkit-scrollbar-thumb {
  background: rgba(0,0,0,0.2);
  border-radius: 2px;
}
.step-row {
  display: flex;
  align-items: flex-start;
  gap: 0.75rem;
  padding: 0.5rem 0.75rem;
  border-radius: 0.375rem;
  border: 1px solid var(--aa-border-color, #e2e8f0);
  background-color: var(--aa-step-row-bg, #f8fafc);
}
.step-index {
  width: 1.5rem;
  height: 1.5rem;
  border-radius: 9999px;
  background-color: var(--aa-step-number-bg, #2563eb);
  color: #ffffff;
  font-size: 0.75rem;
  font-weight: 700;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}
.step-content {
  flex: 1;
  min-width: 0;
}
.step-label {
  font-weight: 600;
  font-size: 0.8rem;
  color: var(--aa-text-primary, #0f172a);
  margin-bottom: 0.15rem;
}
.step-registers {
  display: flex;
  flex-wrap: wrap;
  gap: 0.375rem;
  margin-bottom: 0.25rem;
}
.step-register {
  font-family: ui-monospace, SFMono-Regular, monospace;
  font-size: 0.7rem;
  background-color: var(--aa-bg-code, #1e293b);
  color: var(--aa-accent-green, #4ade80);
  padding: 0.1rem 0.375rem;
  border-radius: 0.25rem;
  display: inline-block;
}
.step-register .reg-name {
  color: var(--aa-accent-blue, #60a5fa);
}
.step-register .reg-value {
  color: var(--aa-accent-green, #4ade80);
}
.step-note {
  font-size: 0.7rem;
  color: var(--aa-text-muted, #64748b);
  font-style: italic;
}
</style>
