namespace PantryOrganiser.Domain.Entity;

public class Recipe : BaseEntity
{
    public string Name { get; set; }
    
    public string Description { get; set; }
    
    public string Instructions { get; set; }
    
    public int ServingSize { get; set; }
    
    public TimeSpan PrepTime { get; set; }
    
    public TimeSpan CookTime { get; set; }
    
    public virtual List<RecipeIngredient> RecipeIngredients { get; set; }
    
    public virtual List<RecipeUser> RecipeUsers { get; set; }
}
