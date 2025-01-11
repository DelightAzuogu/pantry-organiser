namespace PantryOrganiser.Shared.Dto.Request;

public class UpdatePantryRequest
{
    public Guid PantryId { get; set; }

    public string Name { get; set; }
}
