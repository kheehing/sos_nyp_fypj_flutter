const admin = require('firebase-admin');
const functions = require('firebase-functions');

admin.initializeApp(functions.config().firebase);

let db = admin.firestore();

exports.sendNotification = functions.firestore
    .document('help.current/{Id}').onWrite(
        (change, context) => {
            const payLoad = {
                notification: {
                    title: 'Message from cloud',
                    body: 'This is your body',
                    badge: '1',
                    sound: 'default'
                }
            }
            console.log('--- STARTING ---');
            console.log("Change.Before.Data: " + change.before.data.toString() + "\nChange.After.Data: " + change.after.data.toString());
            db.collection('staffs').get().then(doc => {
                doc.forEach(retToken => {
                    // console.log(retToken.id, '=>', retToken.data().token);
                    admin.messaging().sendToDevice(retToken.data().token, payLoad);
                })
                return '--end staff--';
            }).catch(error => {
                console.log('Error getting document', error);
            });
        }
    );
