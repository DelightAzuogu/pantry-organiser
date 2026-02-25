using System.ComponentModel.DataAnnotations;
using PantryOrganiser.Domain.Interface;

namespace PantryOrganiser.Domain.Entity;

public class BaseEntity : IBaseEntity
{
    [Key]
    public Guid Id { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime UpdatedAt { get; set; }
    public DateTime? DeletedAt { get; set; }
}
