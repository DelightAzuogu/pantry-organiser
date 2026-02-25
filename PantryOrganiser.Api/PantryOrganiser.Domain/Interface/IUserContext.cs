namespace PantryOrganiser.Domain.Interface;

public interface IUserContext
{
    public Guid UserId { get; set; }
    
    public string Email { get; set; }
}
