using Microsoft.EntityFrameworkCore;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;

namespace PantryOrganiser.DataAccess.Repository;

public class RecipeUserRepository(AppDbContext dbContext) : BaseRepository<RecipeUser>(dbContext), IRecipeUserRepository
{
    public Task AddRecipeUserAsync(RecipeUser recipeUser) => AddAsync(recipeUser);

    public Task<RecipeUser> GetRecipeUserByRecipeIdAndUserIdAsync(Guid recipeId, Guid userId) =>
        Query(x => x.RecipeId == recipeId && x.UserId == userId)
            .FirstOrDefaultAsync();

    public Task<bool> UserInRecipeAsync(Guid recipeId, Guid userId) => 
        AnyAsync(x => x.RecipeId == recipeId && x.UserId == userId);

    public Task DeleteUserFromRecipeAsync(RecipeUser recipeUser) => 
        DeleteAsync(recipeUser);
}
