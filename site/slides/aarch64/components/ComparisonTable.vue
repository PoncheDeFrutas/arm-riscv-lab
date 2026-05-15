<script setup>
defineProps({
  headers: {
    type: Array,
    required: true
  },
  rows: {
    type: Array,
    required: true
  }
})
</script>

<template>
  <div class="comparison-table">
    <table>
      <thead>
        <tr>
          <th v-for="(header, i) in headers" :key="i">{{ header }}</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(row, i) in rows" :key="i">
          <td v-for="(cell, j) in row" :key="j" :class="{ 'first-cell': j === 0 }">
            {{ cell }}
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
