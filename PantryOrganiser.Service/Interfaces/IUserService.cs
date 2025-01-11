using Microsoft.AspNetCore.Identity.Data;
using PantryOrganiser.Shared.Dto.Response;
using LoginRequest = PantryOrganiser.Shared.Dto.Request.LoginRequest;

namespace PantryOrganiser.Service.Interfaces;

public interface IUserService
{
    public Task<LoginResponse> LoginAsync(LoginRequest request);

    public Task<LoginResponse> RegisterAsync(RegisterRequest request);
}
