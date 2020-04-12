CREATE OR REPLACE VIEW vue_pizza_avec_ingredients AS
SELECT
	pizzas.id,
	pizzas.nom,
GROUP_CONCAT(ingredients.nom) as liste_ingredients
FROM ingredients
	JOIN recettes 
		ON ingredients.id = recettes.id_ingredient
	JOIN pizzas 
		ON pizzas.id = recettes.id_pizza
GROUP BY pizzas.nom

    