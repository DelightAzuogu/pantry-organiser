namespace PantryOrganiser.Shared.Dto.Request;

public class CreatePantryItemRequest
{
    public string Name { get; set; }

    public string Description { get; set; }

    public int Quantity { get; set; }

    public string Brand { get; set; }

    public DateTime? ExpiryDate { get; set; }

    public override string ToString() =>
        $"{nameof(Name)}: {Name}, " +
        $"{nameof(Description)}: {Description}, " +
        $"{nameof(Quantity)}: {Quantity}, " +
        $"{nameof(Brand)}: {Brand}, " +
        $"{nameof(ExpiryDate)}: {ExpiryDate}, ";
}
