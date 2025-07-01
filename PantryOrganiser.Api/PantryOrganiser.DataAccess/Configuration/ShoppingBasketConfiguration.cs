using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using PantryOrganiser.Domain.Entity;

namespace PantryOrganiser.DataAccess.Configuration;

public class ShoppingBasketConfiguration : IEntityTypeConfiguration<ShoppingBasket>
{
    public void Configure(EntityTypeBuilder<ShoppingBasket> builder)
    {
        builder.HasKey(x => x.Id);

        builder.Property(x => x.Name)
            .IsRequired();

        builder.HasIndex(x => x.UniqueString)
            .IsUnique();
    }
}
