// run:
// npm install
// node importToFirestore.js
const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccount.json'); // Remplacez par le chemin vers votre fichier .json

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

const data = require('./courses_pourfbaseavecstorage.json'); // Remplacez par le chemin vers votre fichier JSON

const importData = async () => {
  try {
    for (const [key, value] of Object.entries(data)) {
      const docRef = db.collection('courses').doc(key);
      await docRef.set(value);
    }
    console.log('Data imported successfully');
  } catch (error) {
    console.error('Error importing data', error);
  }
}

importData();
