using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Shared.Dto.Response;

namespace PantryOrganiser.Domain.Interface;

public interface IJwtHelper
{
    public JwtResponse GenerateToken(User user);
}
