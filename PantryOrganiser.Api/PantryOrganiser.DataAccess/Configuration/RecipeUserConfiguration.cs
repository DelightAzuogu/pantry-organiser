using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using PantryOrganiser.Domain.Entity;

namespace PantryOrganiser.DataAccess.Configuration;

public class RecipeUserConfiguration : IEntityTypeConfiguration<RecipeUser>
{
    public void Configure(EntityTypeBuilder<RecipeUser> builder)
    {
        builder.HasKey(x => new { x.RecipeId, x.UserId });

        builder.HasOne(x => x.Recipe)
            .WithMany(x => x.RecipeUsers)
            .HasForeignKey(x => x.RecipeId);

        builder.HasOne(x => x.User)
            .WithMany(x => x.RecipeUsers)
            .HasForeignKey(x => x.UserId);

        builder.Property(x => x.IsOwner)
            .HasDefaultValue(false);

        builder.HasIndex(x => x.RecipeId);
        builder.HasIndex(x => x.UserId);
    }
}
