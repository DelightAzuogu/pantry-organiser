using Microsoft.EntityFrameworkCore;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;
using PantryOrganiser.Shared.Dto.Request;

namespace PantryOrganiser.DataAccess.Repository;

public class RecipeRepository(AppDbContext dbContext) : BaseRepository<Recipe>(dbContext), IRecipeRepository
{
    public Task AddRecipeAsync(Recipe recipe) => AddAsync(recipe);

    public Task<List<Recipe>> GetRecipesByUserIdAsync(Guid userId) =>
        Query(x => x.RecipeUsers.Any(y => y.UserId == userId))
            .ToListAsync();

    public Task<Recipe> GetRecipeByIdAsync(Guid recipeId) =>
        Query(x => x.Id == recipeId)
            .Select(x => new Recipe
            {
                Id = x.Id,
                Name = x.Name,
                Description = x.Description,
                PrepTime = x.PrepTime,
                CookTime = x.CookTime,
                Instructions = x.Instructions,
                ServingSize = x.ServingSize,
                RecipeIngredients = x.RecipeIngredients.Where(ri => ri.DeletedAt == null)
                    .Select(ri => new RecipeIngredient
                    {
                        Id = ri.Id,
                        Name = ri.Name,
                        Quantity = ri.Quantity,
                        QuantityUnit = ri.QuantityUnit
                    }).ToList()
            })
            .FirstOrDefaultAsync();

    public Task<bool> RecipeWithIdExistsAsync(Guid recipeId) => AnyAsync(x => x.Id == recipeId);

    public async Task UpdateRecipeAsync(Guid recipeId, AddRecipeRequest request)
    {
        var recipe = await Query(x => x.Id == recipeId).FirstOrDefaultAsync();
        recipe.Name = request.Name;
        recipe.Description = request.Description;
        recipe.PrepTime = TimeSpan.Parse(request.PrepTimeString);
        recipe.CookTime = TimeSpan.Parse(request.CookTimeString);
        recipe.Instructions = request.Instructions;
        recipe.ServingSize = request.ServingSize;

        await UpdateAsync(recipe);
    }

    public async Task DeleteRecipeAsync(Guid recipeId)
    {
        var recipe = await Query(x => x.Id == recipeId).FirstOrDefaultAsync();

        await DeleteAsync(recipe);
    }
}
