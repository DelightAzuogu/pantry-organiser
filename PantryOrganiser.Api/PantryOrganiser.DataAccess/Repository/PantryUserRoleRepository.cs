using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;
using PantryOrganiser.Shared.Enum;

namespace PantryOrganiser.DataAccess.Repository;

public class PantryUserRoleRepository(AppDbContext dbContext) : BaseRepository<PantryUserRole>(dbContext), IPantryUserRoleRepository
{
    public Task CreateAsync(PantryUserRole pantryUserRole) => AddAsync(pantryUserRole);

    public Task<bool> PantryUserWithRoleExistAsync(Guid pantryUserId, Role role) =>
        AnyAsync(x =>
            x.PantryUserId == pantryUserId && (x.Role == role || x.Role == Role.Owner));

    public Task AddUserRolesAsync(List<PantryUserRole> pantryUserRoles) => AddRangeAsync(pantryUserRoles);

    public async Task DeleteUserRolesByPantryUserIdAsync(Guid pantryUserId)
    {
        var pantryUserRoles = Query(x => x.PantryUserId == pantryUserId);
        
        await DeleteRangeAsync(pantryUserRoles);
    }
}
