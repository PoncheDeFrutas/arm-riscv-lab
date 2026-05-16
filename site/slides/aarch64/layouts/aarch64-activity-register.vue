<script setup>
import ActivityRegister from '../components/ActivityRegister.vue'

defineProps({
  activityName: {
    type: String,
    default: ''
  },
  startTime: {
    type: String,
    default: ''
  },
  participants: {
    type: String,
    default: ''
  },
  endTime: {
    type: String,
    default: ''
  },
  planned: {
    type: String,
    default: ''
  },
  duration: {
    type: String,
    default: ''
  }
})
</script>

<template>
  <div class="slidev-layout aarch64-activity-register">
    <ActivityRegister
      :activity-name="activityName"
      :start-time="startTime"
      :participants="participants"
      :end-time="endTime"
      :planned="planned"
      :duration="duration"
    />
    <div class="slide-content">
      <slot />
    </div>
  </div>
</template>

<style scoped>
.aarch64-activity-register {
  position: relative;
  width: 100%;
  height: 100%;
  padding: 0;
  margin: 0;
}

.slide-content {
  position: relative;
  z-index: 1;
  padding: 2rem;
}
</style>
