using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using PantryOrganiser.Domain.Entity;

namespace PantryOrganiser.DataAccess.Configuration;

public class PantryUserRoleConfiguration : IEntityTypeConfiguration<PantryUserRole>
{
    public void Configure(EntityTypeBuilder<PantryUserRole> builder)
    {
        builder.HasOne(x => x.PantryUser)
            .WithMany(x => x.PantryUserRoles)
            .HasForeignKey(x => x.PantryUserId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.Property(x => x.Role)
            .HasConversion<string>()
            .HasMaxLength(20);

        builder.HasIndex(x => new { x.PantryUserId, x.Role });

        builder.HasIndex(x => x.PantryUserId);
        builder.HasIndex(x => x.Role);
    }
}
