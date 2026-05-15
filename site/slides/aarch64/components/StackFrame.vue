<script setup>
const props = defineProps({
  rows: {
    type: Array,
    required: true
  },
  showDirection: {
    type: Boolean,
    default: true
  },
  compact: {
    type: Boolean,
    default: false
  },
  width: {
    type: String,
    default: 'auto'
  }
})

const colorMap = {
  blue: { bg: 'bg-blue-100 dark:bg-blue-900/30', text: 'text-blue-950 dark:text-blue-200', border: 'border-blue-300 dark:border-blue-700' },
  purple: { bg: 'bg-purple-100 dark:bg-purple-900/30', text: 'text-purple-950 dark:text-purple-200', border: 'border-purple-300 dark:border-purple-700' },
  green: { bg: 'bg-green-100 dark:bg-green-900/30', text: 'text-green-950 dark:text-green-200', border: 'border-green-300 dark:border-green-700' },
  yellow: { bg: 'bg-yellow-100 dark:bg-yellow-900/30', text: 'text-yellow-950 dark:text-yellow-200', border: 'border-yellow-300 dark:border-yellow-700' },
  gray: { bg: 'bg-slate-100 dark:bg-slate-800', text: 'text-slate-900 dark:text-slate-200', border: 'border-slate-300 dark:border-slate-600' }
}

const widthClass = props.width !== 'auto' ? '' : (props.compact ? 'w-[260px]' : 'w-[300px]')
</script>

<template>
  <div class="mt-4 flex justify-center not-prose">
    <div :class="['relative font-mono', widthClass, compact ? 'text-[10px]' : 'text-xs']" :style="width !== 'auto' ? { width } : {}">
      <div v-if="showDirection" class="text-center mb-1 opacity-70">
        ↑
      </div>

      <div class="border-2 border-slate-500 dark:border-slate-400 rounded-lg overflow-hidden">
        <template v-for="(row, index) in rows" :key="index">
          <!-- Fila dividida (stp: dos registros en una fila) -->
          <div
            v-if="row.split"
            :class="[
              'flex border-b border-slate-300 dark:border-slate-600 last:border-b-0'
            ]"
          >
            <!-- Mitad izquierda -->
            <div
              :class="[
                colorMap[row.color || 'gray'].bg,
                colorMap[row.color || 'gray'].text,
                'px-3 py-2 relative flex-1 border-r border-slate-300 dark:border-slate-600',
                compact ? 'py-1.5' : 'py-2'
              ]"
            >
              <span v-if="row.leftSublabel" class="opacity-70">{{ row.leftSublabel }}</span>
              <span v-if="row.leftSublabel">&nbsp;</span>
              {{ row.leftLabel }}
              <div
                v-if="row.leftPointer"
                class="absolute -right-24 top-1/2 -translate-y-1/2 font-bold whitespace-nowrap"
                :class="compact ? 'text-[10px]' : 'text-xs'"
                :style="{ color: row.leftPointerColor || '#2563eb' }"
              >
                {{ row.leftPointer }}
              </div>
            </div>
            <!-- Mitad derecha -->
            <div
              :class="[
                colorMap[row.rightColor || row.color || 'gray'].bg,
                colorMap[row.rightColor || row.color || 'gray'].text,
                'px-3 py-2 relative flex-1',
                compact ? 'py-1.5' : 'py-2'
              ]"
            >
              <span v-if="row.rightSublabel" class="opacity-70">{{ row.rightSublabel }}</span>
              <span v-if="row.rightSublabel">&nbsp;</span>
              {{ row.rightLabel }}
              <div
                v-if="row.rightPointer"
                class="absolute -right-24 top-1/2 -translate-y-1/2 font-bold whitespace-nowrap"
                :class="compact ? 'text-[10px]' : 'text-xs'"
                :style="{ color: row.rightPointerColor || '#2563eb' }"
              >
                {{ row.rightPointer }}
              </div>
            </div>
          </div>

          <!-- Fila normal (un solo contenido) -->
          <div
            v-else
            :class="[
              colorMap[row.color || 'gray'].bg,
              colorMap[row.color || 'gray'].text,
              'px-3 relative border-b border-slate-300 dark:border-slate-600 last:border-b-0',
              compact ? 'py-1.5' : 'py-2'
            ]"
          >
            <span v-if="row.sublabel" class="opacity-70">{{ row.sublabel }}</span>
            <span v-if="row.sublabel">&nbsp;</span>
            {{ row.label }}
            <div
              v-if="row.pointer"
              class="absolute -right-24 top-1/2 -translate-y-1/2 font-bold whitespace-nowrap"
              :class="compact ? 'text-[10px]' : 'text-xs'"
              :style="{ color: row.pointerColor || '#2563eb' }"
            >
              {{ row.pointer }}
            </div>
          </div>
        </template>
      </div>

      <div v-if="showDirection" class="text-center mt-1 opacity-70">
        ↓
      </div>
    </div>
  </div>
</template>
