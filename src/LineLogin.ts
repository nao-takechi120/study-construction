import { ref, Ref } from 'vue';
import liff from '@line/liff';
// import { getInputLiff, getCancelLiff, getRefLiff, getChangeLiff, getCheckinLiff } from '@/LiffConfig'

export const lineLogin = async (initialized: Ref<boolean>, lineId: Ref<string>, mode: string = 'input') => {
  // let liffConfig = getInputLiff()
  // if (mode === 'cancel') {
  //   liffConfig = getCancelLiff()
  // } else if (mode === 'reference') {
  //   liffConfig = getRefLiff()
  // } else if (mode === 'change') {
  //   liffConfig = getChangeLiff()
  // } else if (mode === 'checkin') {
  //   liffConfig = getCheckinLiff()
  // }
  liff.init({
    liffId: '1657829521-l8xgM4bB', 
    withLoginOnExternalBrowser: true,
  })
  .then(() => {
    if (liff.isLoggedIn()) {
      const json = liff.getDecodedIDToken()
      liff.getProfile().then(data => {
        //console.log(data.userId)
        lineId.value = data.userId
        initialized.value = true
      })
    } else {
      liff.login()
    }
  })
  .catch(() => {
    console.error('liff init error')
    alert('liff init error')
  })
}