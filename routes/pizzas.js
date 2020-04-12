const express = require('express');

const db = require('../custom_modules/db');

const router = express.Router();



/////////////////////////////////////
// Liste des pizzas avec leur prix //
/////////////////////////////////////

router.get('/pizza', (req, res) =>{
    db.query('SELECT * FROM vue_pizzas', (err, rows)=> {
        if(err){
            res.status(404).json({succes: false, error: err });
        } else if(rows.length == 0){
            res.status(404).json({ success: false, error: 'non trouvé' });
        } else if(rows.length == 1){
            res.json({success: true, results: rows[0]});
        } else {
            res.json({success: true, results: rows });
        }
    });
});


////////////////////////////////////////////////////
// Détail d'une pizza avec sa liste d'ingrédients //
////////////////////////////////////////////////////

router.get('/pizza/:id', (req, res)=>{
    db.query('SELECT * FROM vue_pizza_avec_ingredients WHERE id=?', 
    [req.params.id],
    (err, rows) => {
        if(err){
            res.status(404).json({succes: false, error: err });
        } else if(rows.length == 0){
            res.status(404).json({ success: false, error: 'non trouvé' });
        } else if(rows.length == 1){
            res.json({success: true, results: rows[0]});
        } else {
            res.json({success: true, results: rows });
        }
    });
});

////////////////////////////////////////////
// Ajouter une pizza avec ses ingredients //
////////////////////////////////////////////


router.post('/pizza', (req, res)=>{
    const newPizza={nom: req.body.nom, base: req.body.base}
    let pizzaId=null;

    db.query('INSERT INTO pizzas SET ?', newPizza)
    .then( (data)=>{
        pizzaId = data.insertId;

        let ingredientData = [];
        for(let id_ingredient of req.body.id_ingredient.split(',')){
            ingredientData.push([pizzaId, id_ingredient]);
        }
        
        return db.query('INSERT INTO recettes (id_pizza, id_ingredient) VALUES ?',
        [ingredientData])
    })
    .then( (data)=>{
        res.json({success: true, message: 'Ajout de la pizza et des ingredients'});
    })
    .catch((err)=>{
        res.status(500).json({succes: false, error: err});
    });
});

module.exports = router;