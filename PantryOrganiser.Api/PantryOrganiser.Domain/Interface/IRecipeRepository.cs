using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Shared.Dto.Request;

namespace PantryOrganiser.Domain.Interface;

public interface IRecipeRepository
{
    Task AddRecipeAsync(Recipe recipe);
    Task<List<Recipe>> GetRecipesByUserIdAsync(Guid userId);
    Task<Recipe> GetRecipeByIdAsync(Guid recipeId);
    Task<bool> RecipeWithIdExistsAsync(Guid recipeId);
    Task UpdateRecipeAsync(Guid recipeId, AddRecipeRequest request);
    Task DeleteRecipeAsync(Guid recipeId);
}
