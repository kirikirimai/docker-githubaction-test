<template>
    <div>
      <h1>Post</h1>
      <div v-if="isFetching">Loading...</div>
      <div v-else-if="error">Error: {{ error.message }}</div>
      <div v-else>
        <h2>{{ posts.title }}</h2>
        <p>{{ posts.body }}</p>
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref, watch } from 'vue'
  import { useRoute } from 'vue-router'
  
  const route = useRoute()
  const id = route.params.id
  console.log(id)
  
  const posts = ref({})
  const error = ref(null)
  const isFetching = ref(true)
  
  const fetchData = async () => {
    isFetching.value = true
    try {
      const response = await fetch(`https://jsonplaceholder.typicode.com/posts/${id}`)
      posts.value = await response.json()
    } catch (err) {
      error.value = err
    } finally {
      isFetching.value = false
    }
  }
  
  // 初回ロード時にデータを取得
  fetchData()
  
  </script>
  