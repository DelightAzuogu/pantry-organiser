using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using PantryOrganiser.Domain.Entity;

namespace PantryOrganiser.DataAccess.Configuration;

public class ShoppingBasketItemConfiguration : IEntityTypeConfiguration<ShoppingBasketItem>
{
    public void Configure(EntityTypeBuilder<ShoppingBasketItem> builder)
    {
        builder.HasKey(x => x.Id);

        builder.Property(x => x.Quantity)
            .HasDefaultValue(0);

        builder.HasOne(x => x.ShoppingBasket)
            .WithMany(x => x.ShoppingBasketItems)
            .HasForeignKey(x => x.ShoppingBasketId)
            .OnDelete(DeleteBehavior.Restrict);
        
        builder.Property(x=> x.QuantityUnit)
            .HasConversion<string>();

        builder.HasIndex(x => x.ShoppingBasketId);
    }
}
