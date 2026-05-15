<script setup>
import pensando from '../../assets/armandopi_pensando.png'
import confundido from '../../assets/armandopi_confundido.png'
import contento from '../../assets/armandopi_contento.png'
import idea from '../../assets/armandopi_idea.png'
import leyendo from '../../assets/armandopi_leyendo.png'
import solucionado from '../../assets/armandopi_solucinado.png'
import sorprendido from '../../assets/armandopi_sorprendido.png'
import aflijido from '../../assets/armandopi_aflijido.png'
import durmiendo from '../../assets/armandopi_durmiendo.png'
import triste from '../../assets/armandopi_triste.png'
import tomandocafe from '../../assets/armandopi_tomandocafe.png'

const props = defineProps({
  emotion: {
    type: String,
    default: 'contento'
  }
})

const images = {
  pensando,
  confundido,
  contento,
  idea,
  leyendo,
  solucionado,
  sorprendido,
  aflijido,
  durmiendo,
  triste,
  tomandocafe
}
</script>

<template>
  <img
    :src="images[emotion] || images.contento"
    class="mascot-corner"
    :alt="`Armando Pi ${emotion}`"
  />
</template>
