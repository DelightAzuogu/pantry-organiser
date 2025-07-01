using PantryOrganiser.Shared.Dto.Response;

namespace PantryOrganiser.Service.Interfaces;

public interface IShoppingBasketService
{
    Task CreateShoppingBasketAsync(string name);
    Task<GetShoppingBasketResponse> GetShoppingBasketAsync(Guid id);
    Task<List<GetShoppingBasketResponse>> GetAllOpenShoppingBasketsAsync();
    Task DeleteShoppingBasketAsync(Guid id);
    Task UpdateShoppingBasketAsync(Guid id, string name);
    Task AddUserToShoppingBasketAsync(Guid basketId, Guid userId);
    Task<GetShoppingBasketResponse> GetShoppingBasketUsingUniqueStringAsync(string uniqueString);
    Task<List<GetShoppingBasketResponse>> GetAllClosedShoppingBasketsAsync();
    Task CloseShoppingBasketAsync(Guid id);
}