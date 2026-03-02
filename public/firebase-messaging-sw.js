// Используем Compat версии (поддерживают importScripts)
importScripts('/firebase-app-compat.js');
importScripts('/firebase-messaging-compat.js');

// Initialize the Firebase app in the service worker
firebase.initializeApp({
  apiKey: "AIzaSyDcOD59aBfY4qRhdZYUt2RlqcbRE_nME4Q",
  authDomain: "myvay-73784.firebaseapp.com",
  projectId: "myvay-73784",
  storageBucket: "myvay-73784.firebasestorage.app",
  messagingSenderId: "250020923277",
  appId: "1:250020923277:web:795b68f6946cf4edc29fc4"
});

const messaging = firebase.messaging();

// Handle background messages
messaging.onBackgroundMessage((payload) => {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
  
  const notificationTitle = payload.notification?.title || 'Новое уведомление';
  const notificationOptions = {
    body: payload.notification?.body || '',
    icon: '/favicon.ico',
    badge: '/favicon.ico',
    data: payload.data
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
