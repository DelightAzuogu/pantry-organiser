using Microsoft.EntityFrameworkCore;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;

namespace PantryOrganiser.DataAccess.Repository;

public class UserRepository(AppDbContext dbContext) : BaseRepository<User>(dbContext), IUserRepository
{
    public Task<User> GetUserByEmailAsync(string email) => Query(x => x.Email == email).FirstOrDefaultAsync();
    
    public Task<bool> UserWithIdExistsAsync(Guid id) => AnyAsync(x => x.Id == id);

    public Task<bool> UserWithEmailExistsAsync(string email) => AnyAsync(x=> x.Email == email);
    
    public Task AddUserAsync(User user) => AddAsync(user);
    
    public Task<User> GetUserByIdAsync(Guid userId) => Query(x => x.Id == userId).FirstOrDefaultAsync();
}
