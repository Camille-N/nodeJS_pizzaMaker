const express = require('express');

const app = express();

const bodyParser = require('body-parser');

const pizzasRoute = require('./routes/pizzas');




app.use(pizzasRoute);




app.listen(3000, () => {

    console.log('Application lancée')
});
