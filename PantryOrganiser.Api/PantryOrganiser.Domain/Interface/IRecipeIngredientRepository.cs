using PantryOrganiser.Domain.Entity;

namespace PantryOrganiser.Domain.Interface;

public interface IRecipeIngredientRepository
{
    Task<List<RecipeIngredient>> GetRecipeIngredientsByRecipeIdAsync(Guid recipeId);
}
