using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Shared.Enum;

namespace PantryOrganiser.Domain.Interface;

public interface IPantryUserRoleRepository
{
    Task CreateAsync(PantryUserRole pantryUserRole);

    Task<bool> PantryUserWithRoleExistAsync(Guid pantryUserId, Role role);

    Task AddUserRolesAsync(List<PantryUserRole> pantryUserRoles);

    Task DeleteUserRolesByPantryUserIdAsync(Guid pantryUserId);
}
