using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;

namespace PantryOrganiser.DataAccess.Repository;

public class RecipeUserRepository(AppDbContext dbContext) : BaseRepository<RecipeUser>(dbContext), IRecipeUserRepository
{

}
