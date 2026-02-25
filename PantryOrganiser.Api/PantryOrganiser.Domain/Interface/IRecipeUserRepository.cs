using PantryOrganiser.Domain.Entity;

namespace PantryOrganiser.Domain.Interface;

public interface IRecipeUserRepository
{
    Task AddRecipeUserAsync(RecipeUser recipeUser);
    Task<RecipeUser> GetRecipeUserByRecipeIdAndUserIdAsync(Guid recipeId, Guid userId);
    Task<bool> UserInRecipeAsync(Guid recipeId, Guid userId);
    Task DeleteUserFromRecipeAsync(RecipeUser recipeUser);
}
