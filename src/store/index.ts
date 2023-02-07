import { AxiosInstance } from 'axios'
import { createStore } from 'vuex'

interface State {
  isLogined: boolean
  client: AxiosInstance | undefined
}

export default createStore<State>({
  state: {
    isLogined: false,
    client: undefined,
  },
  getters: {
    isLogined: (state) => state.isLogined,
    client: (state) => state.client,
  },
  mutations: {
    mutateIsLogined(state, payload) {
      state.isLogined = payload
    },
    mutateClient(state, payload) {
      state.client = payload
    },
  },
  actions: {
    commitIsLogined(store, payload) {
      return store.commit('mutateIsLogined', payload)
    },
    commitClient(store, payload) {
      return store.commit('mutateClient', payload)
    },
  },
})
