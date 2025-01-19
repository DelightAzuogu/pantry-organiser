using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;

namespace PantryOrganiser.DataAccess.Repository;

public class RecipeRepository(AppDbContext dbContext) : BaseRepository<Recipe>(dbContext), IRecipeRepository
{

}
