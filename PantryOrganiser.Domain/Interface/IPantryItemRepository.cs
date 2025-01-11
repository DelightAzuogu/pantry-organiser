namespace PantryOrganiser.Domain.Interface;

public interface IPantryItemRepository
{
    public Task DeletePantryItemsByPantryIdAsync(Guid pantryId);
}
