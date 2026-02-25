namespace PantryOrganiser.Shared.Dto.Request;

public class AddRecipeRequest
{
    public string Name { get; set; }
    
    public string? Description { get; set; }
    
    public string? Instructions { get; set; }
    
    public int ServingSize { get; set; }
    
    public string PrepTimeString { get; set; }
    
    public string CookTimeString { get; set; }
    
    public List<AddRecipeIngredientRequest> Ingredients { get; set; }
}
