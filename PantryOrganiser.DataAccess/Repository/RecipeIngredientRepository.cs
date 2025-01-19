using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;

namespace PantryOrganiser.DataAccess.Repository;

public class RecipeIngredientRepository(AppDbContext dbContext) : BaseRepository<RecipeIngredient>(dbContext), IRecipeIngredientRepository
{
}
