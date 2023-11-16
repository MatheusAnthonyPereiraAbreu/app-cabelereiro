// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
export const environment = {
  production:false,
  firebase:{
    apiKey: "AIzaSyD05tYDptB3pHZd9J36tqryDxzTYkS-tMs",
    authDomain: "app-cabelereiro.firebaseapp.com",
    projectId: "app-cabelereiro",
    storageBucket: "app-cabelereiro.appspot.com",
    messagingSenderId: "614911566185",
    appId: "1:614911566185:web:a6a66fe23ef1cbb6b99df8",
    measurementId: "G-856K34E670"
  }
};

// Initialize Firebase
const app = initializeApp(environment.firebase);
const analytics = getAnalytics(app);