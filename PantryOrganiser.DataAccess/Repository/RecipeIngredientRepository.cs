using Microsoft.EntityFrameworkCore;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;

namespace PantryOrganiser.DataAccess.Repository;

public class RecipeIngredientRepository(AppDbContext dbContext) : BaseRepository<RecipeIngredient>(dbContext), IRecipeIngredientRepository
{
    public Task<List<RecipeIngredient>> GetRecipeIngredientsByRecipeIdAsync(Guid recipeId) => 
        Query(x => x.RecipeId == recipeId)
            .Select(x=> new RecipeIngredient
            {
                Id = x.Id,
                RecipeId = x.RecipeId,
                Quantity = x.Quantity,
                PantryItem = x.PantryItem
            })
            .ToListAsync();
}
