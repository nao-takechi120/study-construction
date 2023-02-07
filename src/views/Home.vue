<script setup lang="ts">
import { closeWindow } from '@liff/close-window';
import liff from '@line/liff/dist/lib';
import { onMounted, ref, watchEffect } from 'vue';
import { lineLogin } from '../LineLogin';
import Canvas from '../components/Canvas.vue'
import axios from 'axios'

const initialized = ref<boolean>(false)
const lineId = ref<string>('')
const sendText = 'カード作成'
const inputText = ref<string>()
let getInput = ''
lineLogin(initialized, lineId)

const closeLiff = () => {
  startAxios(getInput)
  // liff
  //   .sendMessages([
  //     {
  //       type: 'text',23
  //       text: text,
  //     },
  //   ])
  //   .then(() => {
  //     liff.closeWindow()
  //   })
  //   .catch((err) => {
  //     console.log('error', err)
  //   })
}
const getText = (text?: string) => {
  getInput = text!
}
// const startAxios = (postText: string) => {
const startAxios = (url: string) => {
  axios
    .post('/api/image', {
      // postText: postText
      dataURL: url
    })
    .then((response) => {
      console.log(response)
      liff.closeWindow()
    })
    .catch((error) => {
      console.log(error)
    })
}
</script>
<template>
  <p>たけちwecall</p>
  <img src="../assets/sakura.jpeg" id="img" width="100" height="150"/><br/>
  <p>テキストを入力してください</p>
  <input v-model="inputText"/><br/>
  <button @click="closeLiff">決定</button><br />
  <Canvas :text="inputText" @emit-text="getText"></Canvas>
</template>
<style scoped>
img {
  width: 100%;
}
</style>