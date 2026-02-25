using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using PantryOrganiser.Domain.Entity;

namespace PantryOrganiser.DataAccess.Configuration;

public class PantryUserConfiguration : IEntityTypeConfiguration<PantryUser>
{
    public void Configure(EntityTypeBuilder<PantryUser> builder)
    {
        builder.HasOne(x => x.Pantry)
            .WithMany(x => x.PantryUsers)
            .HasForeignKey(x => x.PantryId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasOne(x => x.User)
            .WithMany(x => x.PantryUsers)
            .HasForeignKey(x => x.UserId)
            .OnDelete(DeleteBehavior.Cascade);
        
        builder.HasIndex(x => new { x.PantryId, x.UserId });
        
        builder.HasIndex(x=> x.UserId);
        
        builder.HasIndex(x=> x.PantryId);
    }
}
