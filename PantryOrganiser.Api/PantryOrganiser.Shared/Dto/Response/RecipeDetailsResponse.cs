namespace PantryOrganiser.Shared.Dto.Response;

public class RecipeDetailsResponse
{
    public Guid Id { get; set; }
    public string Name { get; set; }
    
    public string Description { get; set; }
    
    public string Instructions { get; set; }
    
    public int ServingSize { get; set; }
    
    public TimeSpan PrepTime { get; set; }
    
    public TimeSpan CookTime { get; set; }
    
    public bool IsOwner { get; set; }
}