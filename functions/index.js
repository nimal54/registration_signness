const functions = require('firebase-functions');
const admin = require("firebase-admin")
const nodemailer = require('nodemailer');

admin.initializeApp()


//google account credentials used to send email
var transporter = nodemailer.createTransport({
    host: 'smtp.gmail.com',
    port: 587,
    secure: true,
    auth: {
        user: 'nvpublic54@gmail.com',
        pass: 'password----'
    }
});

// exports.sendMailOverHTTP = functions.https.onRequest((req, res) => {
//     const mailOptions = {
//         from: `nvpublic54@gmail.com`,
//         to: req.body.email,
//         subject: 'contact form message',
//         html: `<h1>Order Confirmation</h1>
//                             <p>
//                                <b>Email: </b>${req.body.email}<br>
//                             </p>`
//     };


//     return transporter.sendMail(mailOptions, (error, data) => {
//         if (error) {
//             return res.send(error.toString());
//         }
//         var data = JSON.stringify(data)
//         return res.send(`Sent! ${data}`);
//     });

// });



exports.sendEmail = functions.firestore
    .document('id/{id}')
    .onCreate((snap, context) => {

        const mailOptions = {
            from: `nvpublic54@gmail.com`,
            to: snap.data().email,
            subject: 'contact form message',
            html: `<h1>Registration Confirmed</h1>
                                <p>
                                   <b>Email: </b>${snap.data().email}<br>
                                   <h3> password will be your date of birth</h3>
                                </p>`
        };


        return transporter.sendMail(mailOptions, (error, data) => {
            if (error) {
                console.log(error)
                return
            }
            console.log("Sent!")
        });
    });