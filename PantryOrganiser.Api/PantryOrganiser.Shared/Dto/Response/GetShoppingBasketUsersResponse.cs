namespace PantryOrganiser.Shared.Dto.Response;

public class GetShoppingBasketUsersResponse
{
    public Guid UserId { get; set; }
    public String UserEmail { get; set; }
    public Guid BasketUserId { get; set; }
}
