using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using PantryOrganiser.Domain.Entity;

namespace PantryOrganiser.DataAccess.Configuration;

public class RecipeIngredientConfiguration:IEntityTypeConfiguration<RecipeIngredient>
{
    public void Configure(EntityTypeBuilder<RecipeIngredient> builder)
    {
        builder.HasKey(x=> x.Id);
        
        builder.HasOne(x=> x.Recipe)
            .WithMany(x=> x.RecipeIngredients)
            .HasForeignKey(x=> x.RecipeId);
        
        builder.HasOne(x=> x.PantryItem)
            .WithMany(x=> x.RecipeIngredients)
            .HasForeignKey(x=> x.PantryItemId);

        builder.Property(x => x.Quantity).IsRequired();
        
        builder.HasIndex(x=> x. RecipeId);
        builder.HasIndex(x=> x. PantryItemId);
        builder.HasIndex(x=> x. Quantity);
    }
}
