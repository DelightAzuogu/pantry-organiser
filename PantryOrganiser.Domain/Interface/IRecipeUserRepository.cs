using PantryOrganiser.Domain.Entity;

namespace PantryOrganiser.Domain.Interface;

public interface IRecipeUserRepository
{
    Task AddRecipeUserAsync(RecipeUser recipeUser);
    Task<RecipeUser> GetRecipeUserByRecipeIdAndUserIdAsync(Guid recipeId, Guid userId);
}
