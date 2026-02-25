using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using PantryOrganiser.Domain.Entity;

namespace PantryOrganiser.DataAccess.Configuration;

public class ShoppingBasketUsersConfiguration : IEntityTypeConfiguration<ShoppingBasketUsers>
{
    public void Configure(EntityTypeBuilder<ShoppingBasketUsers> builder)
    {
        builder.HasKey(x => x.Id);

        builder.HasOne(x => x.User)
            .WithMany(x => x.ShoppingBasketUsers)
            .HasForeignKey(x => x.UserId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasOne(x => x.ShoppingBasket)
            .WithMany(x => x.ShoppingBasketUsers)
            .HasForeignKey(x => x.ShoppingBasketId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.Property(x => x.IsOwner)
            .HasDefaultValue(false);

        builder.HasIndex(x => new { x.UserId, x.ShoppingBasketId })
            .IsUnique();
    }
}
