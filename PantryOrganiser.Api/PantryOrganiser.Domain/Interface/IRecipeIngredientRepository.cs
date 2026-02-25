using System.Collections;
using PantryOrganiser.Domain.Entity;

namespace PantryOrganiser.Domain.Interface;

public interface IRecipeIngredientRepository
{
    Task<List<RecipeIngredient>> GetRecipeIngredientsByRecipeIdAsync(Guid recipeId);
    Task AddRecipeIngredientAsync(RecipeIngredient recipeIngredient);
    Task DeleteRecipeIngredientsByRecipeIdAsync(Guid recipeId);
    Task<RecipeIngredient> GetIngredientById(Guid ingredientId);
    Task UpdateIngredientAsync(RecipeIngredient ingredient);
    Task DeleteIngredientAsync(RecipeIngredient ingredient);
}
