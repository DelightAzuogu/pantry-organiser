using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using PantryOrganiser.Domain.Entity;

namespace PantryOrganiser.DataAccess.Configuration;

public class PantryItemConfiguration : IEntityTypeConfiguration<PantryItem>
{
    public void Configure(EntityTypeBuilder<PantryItem> builder)
    {
        builder.HasKey(x => x.Id);

        builder.Property(x => x.Quantity)
            .HasDefaultValue(0);

        builder.Property(x => x.Name)
            .IsRequired()
            .HasMaxLength(100);

        builder.HasOne(x => x.Pantry)
            .WithMany(x => x.PantryItems)
            .HasForeignKey(x => x.PantryId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasIndex(x => x.PantryId);
    }
}
