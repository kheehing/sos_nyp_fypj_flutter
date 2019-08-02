// this code does nothing in the app it's copied from another file which is uploaded to firebase function

const admin = require('firebase-admin');
const functions = require('firebase-functions');

admin.initializeApp(functions.config().firebase);

exports.sendNotification = functions.firestore
    .document('help.current/{Id}').onWrite(
        (change, context) => {
            var payLoad;
            console.log("Change.Before.Data: ", change.before, "\nChange.After.Data: ", change.after);
            admin.firestore().collection('help.current').doc(context.params.Id).get().then(doc => {
                payLoad = {
                    notification: {
                        title: doc.data().userdetails.name + " requested for help.",
                        // body: ,
                        badge: '1',
                        sound: 'default'
                    }
                }
                return '-- data --';
            }).catch(error => {
                console.log('Error getting document', error);
            });
            admin.firestore().collection('staffs').get().then(doc => {
                doc.forEach(retToken => {
                    // console.log(retToken.id, '=>', retToken.data().token);
                    admin.messaging().sendToDevice(retToken.data().token, payLoad);
                })
                return '--Sent--';
            }).catch(error => {
                console.log('Error getting document', error);
            });
        }
    );
