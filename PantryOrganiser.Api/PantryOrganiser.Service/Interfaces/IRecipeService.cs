using PantryOrganiser.Shared.Dto.Request;
using PantryOrganiser.Shared.Dto.Response;

namespace PantryOrganiser.Service.Interfaces;

public interface IRecipeService
{
    Task AddRecipeAsync(AddRecipeRequest request, Guid userId);
    Task<RecipeDetailsResponse> GetRecipeDetailsByIdAsync(Guid recipeId, Guid userId);
    Task<List<RecipeResponse>> GetRecipesByUserIdAsync(Guid userId);
    Task UpdateRecipeAsync(Guid recipeId, AddRecipeRequest request, Guid userId);
    Task DeleteRecipeAsync(Guid recipeId, Guid userId);
}
