using PantryOrganiser.Domain.Entity;

namespace PantryOrganiser.Service.Interfaces;

public interface IShoppingBasketUserService
{
    Task<ShoppingBasketUsers> GetShoppingBasketUserByIdAsync(Guid id);
}
