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
}
