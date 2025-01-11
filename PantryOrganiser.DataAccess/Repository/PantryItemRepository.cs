using Microsoft.EntityFrameworkCore;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;

namespace PantryOrganiser.DataAccess.Repository;

public class PantryItemRepository(AppDbContext dbContext) : BaseRepository<PantryItem>(dbContext), IPantryItemRepository
{
    public async Task DeletePantryItemsByPantryIdAsync(Guid pantryId)
    {
        var items = await Query(x=>x.PantryId == pantryId).ToListAsync();

        await DeleteRangeAsync(items);
    }
}
