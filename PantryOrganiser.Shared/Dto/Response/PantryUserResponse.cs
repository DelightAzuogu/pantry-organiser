using PantryOrganiser.Shared.Enum;

namespace PantryOrganiser.Shared.Dto.Response;

public class PantryUserResponse
{
    public string Email { get; set; }

    public Guid PantryUserId { get; set; }

    public Guid UserId { get; set; }
    
    public List<Role> Roles { get; set; }
}
