using PantryOrganiser.Domain.Interface;

namespace PantryOrganiser.Domain.Context;

public class UserContext : IUserContext
{
    public Guid UserId { get; set; }

    public string Email { get; set; }
}
