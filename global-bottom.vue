<template>
  <footer v-if="$nav.currentPage > 1" class="lab-slide-footer">
    <span>ARM RISC-V Lab</span>
    <span>{{ $nav.currentPage }} / {{ $nav.total }}</span>
  </footer>
</template>

<style scoped>
.lab-slide-footer {
  position: fixed;
  left: 3rem;
  right: 3rem;
  bottom: 1.2rem;
  z-index: 10;
  display: flex;
  justify-content: space-between;
  color: rgba(156, 163, 175, 0.75);
  font-family: "JetBrains Mono", ui-monospace, monospace;
  font-size: 0.72rem;
  pointer-events: none;
}
</style>
