using PantryOrganiser.Domain.Entity;

namespace PantryOrganiser.Domain.Interface;

public interface IUserRepository
{
    public Task<User> GetUserByEmailAsync(string email);
    
    public Task<bool> UserWithEmailExistsAsync(string email);
    
    public Task AddUserAsync(User user);
}
