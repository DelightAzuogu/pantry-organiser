using Microsoft.EntityFrameworkCore;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;
using PantryOrganiser.Shared.Enum;

namespace PantryOrganiser.DataAccess.Repository;

public class PantryUserRepository(AppDbContext dbContext) : BaseRepository<PantryUser>(dbContext), IPantryUserRepository
{
    public Task CreateAsync(PantryUser pantryUser) => AddAsync(pantryUser);

    public Task<List<Guid>> GetUserPantriesIdsAsync(Guid userId) =>
        Query(x => x.UserId == userId)
            .Select(x => x.PantryId)
            .ToListAsync();

    public Task<PantryUser> GetPantryUserByUserIdAndPantryIdAsync(Guid userId, Guid pantryId) =>
        Query(x => x.PantryId == pantryId && x.UserId == userId)
            .FirstOrDefaultAsync();

    public Task<bool> PantryUserWithPantryIdAndUserIdExistsAsync(Guid pantryId, Guid userId) => AnyAsync(x => x.PantryId == pantryId && x.UserId == userId);

    public Task<bool> PantryUserWithIdExistAsync(Guid pantryUserId) => AnyAsync(x => x.Id == pantryUserId);

    public Task<PantryUser> GetByIdAsync(Guid pantryUserId) => Query(x => x.Id == pantryUserId).FirstOrDefaultAsync();

    public Task DeletePantryUserWithIdAsync(PantryUser pantryUser) => DeleteAsync(pantryUser);

    public Task<List<PantryUser>> GetPantryUsersByPantryIdAsync(Guid pantryId) =>
        Query(x => x.PantryId == pantryId)
            .Select(x => new PantryUser
            {
                Id = x.Id,
                UserId = x.UserId,
                PantryId = x.PantryId,
                User = x.User,
                PantryUserRoles = x.PantryUserRoles
            })
            .ToListAsync();
}
