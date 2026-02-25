namespace PantryOrganiser.Domain.Interface;

public interface IBaseEntity
{
    Guid Id { get; set; }
    
    DateTime CreatedAt { get; set; }
    
    DateTime UpdatedAt { get; set; }
    
    DateTime? DeletedAt { get; set; }
}
