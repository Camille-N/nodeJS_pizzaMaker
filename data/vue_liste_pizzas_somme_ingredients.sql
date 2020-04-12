CREATE OR REPLACE VIEW vue_pizzas AS
SELECT
	pizzas.id,
	pizzas.nom,
	SUM(ingredients.prix) as prix
FROM ingredients
JOIN recettes
	ON ingredients.id = recettes.id_ingredient
JOIN pizzas
	ON pizzas.id = recettes.id_pizza
GROUP BY pizzas.id