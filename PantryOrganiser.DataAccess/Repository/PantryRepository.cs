using Microsoft.EntityFrameworkCore;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;
using PantryOrganiser.Shared.Dto.Response;

namespace PantryOrganiser.DataAccess.Repository;

public class PantryRepository(AppDbContext dbContext) : BaseRepository<Pantry>(dbContext), IPantryRepository
{
    public Task CreatePantryAsync(Pantry pantry) => AddAsync(pantry);

    public async Task DeletePantryAsync(Guid pantryId)
    {
        var pantry = await Query(x => x.Id == pantryId).SingleAsync();

        await DeleteAsync(pantry);
    }

    public Task<bool> PantryWithIdExistAsync(Guid pantryId) => AnyAsync(x => x.Id == pantryId);

    public Task<Pantry> GetPantryByIdAsync(Guid pantryId) => Query(x => x.Id == pantryId).FirstOrDefaultAsync();

    public async Task UpdatePantryAsync(Guid pantryId, string name)
    {
        var pantry = await Query(x => x.Id == pantryId).SingleAsync();

        pantry.Name = name;

        await UpdateAsync(pantry);
    }

    public Task<List<PantryDto>> GetPantriesAsync(List<Guid> pantryIds) =>
        Query(x => pantryIds.Contains(x.Id))
            .Select(x => new PantryDto
            {
                Id = x.Id,
                Name = x.Name
            })
            .ToListAsync();
}
