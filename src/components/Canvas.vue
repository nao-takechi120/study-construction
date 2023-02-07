<script setup lang="ts">
import { Client } from '@line/bot-sdk';
import { onMounted, ref, watch } from 'vue'
import axios from 'axios'

interface Props {
  text?: string
}

interface Emit {
  (e: 'emitText', postText?: string): void
}
const props = defineProps<Props>()
const emit = defineEmits<Emit>()

watch(props, () => {
  if (props.text) {
    drawImage()
  }
})
const drawImage = () => {
  const canvas = <HTMLCanvasElement>document.getElementById('canvas');
  const ctx = canvas.getContext('2d');
  //画像定義
  const img = new Image();
  img.src = 'src/assets/sakura.jpeg';

  img.onload = function () {
    //画像サイズ取得
    const imgWidth = img.width;
    const imgHeight = img.height;
    //canvasサイズ取得
    const canWidth = canvas.width;
    //画像をcanvasサイズに合わせて描画するために縦横比を取得
    const compression = canWidth / imgWidth;
    const compHeight = compression * imgHeight;
    //画像描画
    ctx!.drawImage(img, 0, 0, canWidth, compHeight);
    //文字設定
    ctx!.font = "60px 'Kosugi Maru'";
    ctx!.textAlign = "left";        // 左右中央
    ctx!.textBaseline = "middle";   // 上下中央
    //文字描画
    ctx!.fillText(props.text!, 10, 50, 500);

    const url = canvas.toDataURL()
    
    const postText = props.text
    emit('emitText', url)
    // emit('emitText', postText)
  }
}

</script>

<template>
  <canvas id="canvas"></canvas>
</template>

<style scoped>
canvas {
  width: 100%;
}
</style>
