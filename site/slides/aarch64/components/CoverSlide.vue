<script setup>
import FondoECYS from '../../assets/Fondo_ECYS.png'

defineProps({
  title: {
    type: String,
    required: true
  },
  subtitle: {
    type: String,
    default: ''
  },
  note: {
    type: String,
    default: ''
  }
})

const bgStyle = {
  backgroundImage: `url(${FondoECYS})`,
  backgroundSize: 'cover',
  backgroundPosition: 'center',
  backgroundRepeat: 'no-repeat',
  position: 'absolute',
  inset: '0',
  width: '100%',
  height: '100%',
  display: 'flex',
  flexDirection: 'column',
  justifyContent: 'center',
  paddingLeft: '4rem',
  paddingRight: '4rem'
}
</script>

<template>
  <div class="cover-slide" :style="bgStyle">
    <h1 class="cover-title">{{ title }}</h1>
    <p v-if="subtitle" class="cover-subtitle">{{ subtitle }}</p>
    <div v-if="note" class="cover-note">{{ note }}</div>
  </div>
</template>

<style scoped>
.cover-slide {
  box-sizing: border-box;
  overflow: hidden;
}

.cover-slide h1,
.cover-slide p,
.cover-title,
.cover-subtitle,
.cover-note {
  color: #000000 !important;
}

.cover-title {
  font-size: 3rem;
  font-weight: 700;
  margin-bottom: 1rem;
}

.cover-subtitle {
  font-size: 1.25rem;
  margin-top: 0.5rem;
}

.cover-note {
  font-size: 1rem;
  margin-top: 1.5rem;
  padding: 0.75rem 1rem;
  border-left: 3px solid rgba(0, 0, 0, 0.3);
  max-width: 80%;
  line-height: 1.5;
}
</style>
