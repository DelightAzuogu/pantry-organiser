using Microsoft.EntityFrameworkCore;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;

namespace PantryOrganiser.DataAccess.Repository;

public class RecipeIngredientRepository(AppDbContext dbContext) : BaseRepository<RecipeIngredient>(dbContext), IRecipeIngredientRepository
{
    public Task<List<RecipeIngredient>> GetRecipeIngredientsByRecipeIdAsync(Guid recipeId) =>
        Query(x => x.RecipeId == recipeId)
            .ToListAsync();

    public Task AddRecipeIngredientAsync(RecipeIngredient recipeIngredient) => AddAsync(recipeIngredient);

    public Task DeleteRecipeIngredientsByRecipeIdAsync(Guid recipeId)
    {
        var recipeIngredients = Query(x => x.RecipeId == recipeId);
        return DeleteRangeAsync(recipeIngredients);
    }

    public Task<RecipeIngredient> GetIngredientById(Guid ingredientId) => Query(x => x.Id == ingredientId).SingleAsync();

    public Task UpdateIngredientAsync(RecipeIngredient ingredient) => UpdateAsync(ingredient);
    public Task DeleteIngredientAsync(RecipeIngredient ingredient) => DeleteAsync(ingredient);
}
