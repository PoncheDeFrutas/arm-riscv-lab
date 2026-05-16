<script setup>
import { ref } from 'vue'
import FondoECYS from '../../assets/Fondo_ECYS.png'

const props = defineProps({
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

const activityNameVal = ref(props.activityName)
const startTimeVal = ref(props.startTime)
const participantsVal = ref(props.participants)
const endTimeVal = ref(props.endTime)
const plannedVal = ref(props.planned)
const durationVal = ref(props.duration)

const col1 = ref('')
const col2 = ref('')
const col3 = ref('')

const bgStyle = {
  backgroundImage: `url(${FondoECYS})`,
  backgroundSize: 'cover',
  backgroundPosition: 'center',
  backgroundRepeat: 'no-repeat',
  position: 'absolute',
  inset: '0',
  width: '100%',
  height: '100%'
}
</script>

<template>
  <div class="activity-register" :style="bgStyle">
    <div class="content-wrapper">
      <h2 class="section-title">REGISTRO DE ACTIVIDAD</h2>

      <div class="top-section">
        <table class="form-table left-table">
          <tbody>
          <tr>
            <td class="label-cell">Nombre de la actividad:</td>
            <td class="value-cell">
              <textarea v-model="activityNameVal" class="cell-input" placeholder=""></textarea>
            </td>
          </tr>
          <tr>
            <td class="label-cell">Cantidad de participantes:</td>
            <td class="value-cell">
              <textarea v-model="participantsVal" class="cell-input" placeholder=""></textarea>
            </td>
          </tr>
          <tr>
            <td class="label-cell">Doy fe que esta actividad est planificada en DTT:</td>
            <td class="value-cell">
              <textarea v-model="plannedVal" class="cell-input" placeholder="Si / No"></textarea>
            </td>
          </tr>
          </tbody>
        </table>

        <table class="form-table right-table">
          <tbody>
          <tr>
            <td class="label-cell">Hora de inicio:</td>
            <td class="value-cell">
              <textarea v-model="startTimeVal" class="cell-input" placeholder=""></textarea>
            </td>
          </tr>
          <tr>
            <td class="label-cell">Hora de fin:</td>
            <td class="value-cell">
              <textarea v-model="endTimeVal" class="cell-input" placeholder=""></textarea>
            </td>
          </tr>
          <tr>
            <td class="label-cell">Duracin (min):</td>
            <td class="value-cell">
              <textarea v-model="durationVal" class="cell-input" placeholder=""></textarea>
            </td>
          </tr>
          </tbody>
        </table>
      </div>

      <div class="participants-section">
        <p class="participants-instruction">
          Participantes: llenar las siguientes cajas de texto (tomar informacin del chat del meet)
        </p>
        <div class="participants-grid">
          <div class="participant-column">
            <textarea v-model="col1" class="editable-area" placeholder="Escribir nombres aqu..."></textarea>
          </div>
          <div class="participant-column">
            <textarea v-model="col2" class="editable-area" placeholder="Escribir nombres aqu..."></textarea>
          </div>
          <div class="participant-column">
            <textarea v-model="col3" class="editable-area" placeholder="Escribir nombres aqu..."></textarea>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.activity-register {
  position: relative;
  box-sizing: border-box;
  overflow: hidden;
  display: flex;
  align-items: flex-start;
  justify-content: center;
  padding: 1.5rem 2rem;
}

.content-wrapper {
  position: relative;
  z-index: 1;
  width: 100%;
  max-width: 95%;
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.section-title {
  font-size: 1.4rem;
  font-weight: 700;
  color: #000000;
  margin: 0 0 0.5rem 0;
  text-align: center;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.top-section {
  display: flex;
  gap: 1rem;
  align-items: flex-start;
}

.form-table {
  border-collapse: collapse;
  width: 100%;
  font-size: 0.85rem;
}

.left-table {
  flex: 1.4;
}

.right-table {
  flex: 1;
}

.form-table .label-cell {
  border: 1px solid #333;
  padding: 0.5rem 0.6rem;
  font-weight: 600;
  color: #111;
  white-space: nowrap;
  width: 45%;
  vertical-align: middle;
  background-color: #f5f5f5;
}

.form-table .value-cell {
  border: 1px solid #333;
  padding: 0;
  color: #111;
  vertical-align: middle;
  background-color: #ffffff;
}

.form-table .cell-input {
  width: 100%;
  height: 100%;
  border: none;
  outline: none;
  resize: none;
  padding: 0.5rem 0.6rem;
  font-size: 0.85rem;
  font-family: inherit;
  color: #111;
  background-color: #ffffff;
  line-height: 1.4;
  display: block;
}

.cell-input::placeholder {
  color: #aaa;
  font-style: italic;
}

.participants-section {
  margin-top: 0.5rem;
}

.participants-instruction {
  font-size: 0.85rem;
  font-weight: 600;
  color: #222;
  margin: 0 0 0.5rem 0;
}

.participants-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 0;
  border: 1px solid #333;
}

.participant-column {
  border-right: 1px solid #333;
  background: #fff;
  min-height: 10rem;
  display: flex;
  flex-direction: column;
}

.participant-column:last-child {
  border-right: none;
}

.editable-area {
  width: 100%;
  height: 100%;
  min-height: 10rem;
  flex: 1;
  border: none;
  outline: none;
  resize: none;
  padding: 0.6rem 0.5rem;
  font-size: 0.85rem;
  font-family: inherit;
  color: #000;
  background: #fff;
  line-height: 1.5;
}

.editable-area::placeholder {
  color: #aaa;
  font-style: italic;
}
</style>
