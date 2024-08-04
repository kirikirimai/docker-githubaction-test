<template>
  <div>
    <h1>Posts test 変更後だよ</h1>
    <button @click="refreshData">Refresh</button>
    <div v-if="isFetching">Loading...</div>
    <div v-else-if="error">Error: {{ error.message }}</div>
    <ul v-else>
      <li class="postlist" v-for="post in posts" :key="post.id">
        <p @click="detailFunc(post.id)">{{ post.title }}</p>
        <!-- <nuxt-link :to="`/posts/${post.id}`">{{ post.title }}</nuxt-link> -->
      </li>
    </ul>

    <div :class="['modal', { 'is-open': isOpen }]">
      <div class="modal-content">
        <div v-if="isFetchingDetail">詳細を読み込み中...</div>
        <div v-else-if="error">エラー: {{ error.message }}</div>
        <div v-else>
          <h2>{{ postDetail.title }}</h2>
          <p>{{ postDetail.body }}</p>
          <button @click="closeModal">閉じる</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";

const url = "https://jsonplaceholder.typicode.com/posts?_limit=10";
const posts = ref([]);
const error = ref(null);
const isFetching = ref(true);
const postDetail = ref({}); // 詳細ポストを保持するための変数
const isFetchingDetail = ref(false); // 詳細ポストのローディング状態
const isOpen = ref(false); // モーダルの表示状態

const fetchData = async () => {
  isFetching.value = true;
  try {
    const response = await fetch(url);
    posts.value = await response.json();
  } catch (err) {
    error.value = err;
  } finally {
    isFetching.value = false;
  }
};

// 詳細ポストを取得するための関数
const fetchPostDetail = async (id) => {
  isFetchingDetail.value = true;
  try {
    const response = await fetch(
      `https://jsonplaceholder.typicode.com/posts/${id}`
    );
    postDetail.value = await response.json();
  } catch (err) {
    error.value = err;
  } finally {
    isFetchingDetail.value = false;
    if (postDetail.value) {
      isOpen.value = true; // データ取得完了後にモーダルを開く
    }
  }
};

// 詳細ポストを表示するための関数
const detailFunc = (id) => {
  fetchPostDetail(id);
};

// モーダルを閉じるための関数
const closeModal = () => {
  isOpen.value = false;
  postDetail.value = {};
};

fetchData();

const refreshData = () => {
  fetchData();
};
</script>

<style scoped>

ul{
    list-style-type: none;
    padding: 0;
    margin: 0;
}


.postlist p{
  cursor: pointer;
  padding: 10px;
  margin: 0;
} 
.postlist:nth-child(odd) p{
    background-color: #f0f0f0;
}

.modal {
  /* モーダルの基本スタイル */
  position: fixed;
  top: 0;
  right: -300px; /* 初期状態で画面の外 */
  width: 300px; /* モーダルの幅 */
  height: 100%;
  background-color: white;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
  transition: right 0.3s ease; /* 右からスライドインするトランジション */
}

.modal.is-open {
  right: 0; /* モーダルが表示される位置 */
}

.modal-content {
  padding: 20px;
}
</style>
