using Microsoft.AspNetCore.Identity.Data;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Shared.Dto.Request;
using PantryOrganiser.Shared.Dto.Response;

namespace PantryOrganiser.Service.Interfaces;

public interface IUserService
{
    Task<LoginResponse> LoginAsync(LoginRequestDto request);

    Task<LoginResponse> RegisterAsync(RegisterRequest request);

    Task ValidateUserExistenceByIdAsync(Guid userId);

    Task ValidateUserExistenceByEmailAsync(string email);

    Task<User> GetUserByEmailAsync(string email);

    Task<User> GetUserByIdAsync(Guid userId);
}
