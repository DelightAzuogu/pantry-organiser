using PantryOrganiser.Shared.Dto.Response;

namespace PantryOrganiser.Service.Interfaces;

public interface IShoppingBasketService
{
    Task CreateShoppingBasketAsync(string name);
    Task<GetShoppingBasketResponse> GetShoppingBasketAsync(Guid id);
    Task<List<GetShoppingBasketResponse>> GetAllOpenShoppingBasketsAsync();
    Task<List<GetShoppingBasketResponse>> GetAllClosedShoppingBasketsAsync();
    Task DeleteShoppingBasketAsync(Guid id);
    Task UpdateShoppingBasketAsync(Guid id, string name);
    Task AddUserToShoppingBasketAsync(Guid basketId, Guid userId);
    Task<GetShoppingBasketByUniqueStringResponse> GetShoppingBasketUsingUniqueStringAsync(string uniqueString, Guid userId);
    Task CloseShoppingBasketAsync(Guid id);
    Task JoinShoppingBasketUsingUniqueStringAsync(string uniqueString);
    Task RemoveUserFromShoppingBasketAsync(Guid basketId, Guid userId);
    Task <List<GetShoppingBasketUsersResponse>> GetShoppingBasketUsersAsync(Guid basketId);
    Task LeaveShoppingBasketAsync(Guid basketId);
}