using PantryOrganiser.Shared.Dto.Request;
using PantryOrganiser.Shared.Dto.Response;

namespace PantryOrganiser.Service.Interfaces;

public interface IShoppingBasketItemService
{
    Task AddItemToBasketAsync(AddShoppingBasketItem request);
    Task<List<GetShoppingBasketItems>> GetItemsByBasketIdAsync(Guid shoppingBasketId);
    Task CheckoutShoppingBasketItemsAsync(CheckoutShoppingBasketItemsRequest request);
    Task DeleteShoppingBasketItemAsync(Guid shoppingBasketItemId);
    Task UpdateShoppingBasketItemAsync(UpdateShoppingBasketItemRequest request);
}
