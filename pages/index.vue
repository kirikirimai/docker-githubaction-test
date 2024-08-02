<template>
    <div>
        <h1>Posts</h1>
        <button @click="refreshData">Refresh</button>
        <div v-if="isFetching">Loading...</div>
        <div v-else-if="error">Error: {{ error.message }}</div>
        <ul v-else>
            <li v-for="post in posts" :key="post.id">
                <nuxt-link :to="`/posts/${post.id}`">{{ post.title }}</nuxt-link>
            </li>
        </ul>


    </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRoute, useRouter } from 'vue-router';
import Modal from '~/components/Modal.vue';

const url = 'https://jsonplaceholder.typicode.com/posts?_limit=10'
const posts = ref([])
const error = ref(null)
const isFetching = ref(true)


const fetchData = async () => {
    isFetching.value = true
    try {
        const response = await fetch(url)
        posts.value = await response.json()
    } catch (err) {
        error.value = err
    } finally {
        isFetching.value = false
    }
}

fetchData()

const refreshData = () => {
    fetchData()
}
</script>