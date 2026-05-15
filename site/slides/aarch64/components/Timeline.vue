<script setup>
defineProps({
  events: {
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
  <div class="timeline">
    <div
      v-for="(event, index) in events"
      :key="index"
      class="timeline-event"
      :class="{ 'slidev-vclick-target': animate }"
      v-click="animate ? index + 1 : undefined"
    >
      <div class="timeline-marker">
        <div class="marker-dot">{{ event.step }}</div>
        <div v-if="index < events.length - 1" class="marker-line" />
      </div>
      <div class="timeline-content">
        <div class="event-label">{{ event.label }}</div>
        <div class="event-description">{{ event.desc }}</div>
        <div v-if="event.detail" class="event-detail">{{ event.detail }}</div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.timeline {
  display: flex;
  flex-direction: column;
  gap: 0;
  max-height: calc(100vh - 140px);
  overflow-y: auto;
  padding-right: 0.25rem;
}
.timeline::-webkit-scrollbar {
  width: 4px;
}
.timeline::-webkit-scrollbar-thumb {
  background: rgba(0,0,0,0.2);
  border-radius: 2px;
}
.timeline-event {
  display: flex;
  gap: 0.75rem;
}
.timeline-marker {
  display: flex;
  flex-direction: column;
  align-items: center;
  flex-shrink: 0;
}
.marker-dot {
  width: 1.75rem;
  height: 1.75rem;
  border-radius: 9999px;
  background-color: var(--aa-timeline-dot-bg, #2563eb);
  color: #ffffff;
  font-size: 0.75rem;
  font-weight: 700;
  display: flex;
  align-items: center;
  justify-content: center;
}
.marker-line {
  width: 2px;
  height: 1.25rem;
  background-color: var(--aa-timeline-line, #93c5fd);
}
.timeline-content {
  padding-bottom: 0.75rem;
  min-width: 0;
}
.event-label {
  font-weight: 600;
  font-size: 0.875rem;
  color: var(--aa-text-primary, #0f172a);
}
.event-description {
  font-size: 0.8rem;
  color: var(--aa-text-secondary, #334155);
  margin-top: 0.1rem;
}
.event-detail {
  font-size: 0.7rem;
  color: var(--aa-text-muted, #64748b);
  margin-top: 0.1rem;
  font-style: italic;
}
</style>
