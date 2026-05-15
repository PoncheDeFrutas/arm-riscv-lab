<script setup>
import FondoECYS from '../../assets/Fondo_ECYS.png'

const bgStyle = {
  backgroundImage: `url(${FondoECYS})`
}
</script>

<template>
  <div class="slidev-layout aarch64-cover-notes" :style="bgStyle">
    <div class="cover-content">
      <slot />
    </div>
  </div>
</template>
