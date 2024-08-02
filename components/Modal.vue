<template>
    <div class="modal-overlay" @click.self="close">
      <div class="modal-content">
        <h2>{{ post.title }}</h2>
        <p>Details about {{ post.title }}</p>
        <button @click="close">Close</button>
      </div>
    </div>
  </template>
  
  <script setup>
  const props = defineProps({
    post: Object
  });
  
  const emit = defineEmits(['close']);
  
  const close = () => {
    emit('close');
  };
  </script>
  
  <style scoped>
  .modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 100%;
  }
  .modal-content {
    background: white;
    padding: 20px;
    border-radius: 5px;
  }
  </style>
  