﻿using Microsoft.EntityFrameworkCore;
using PantryOrganiser.DataAccess.Configuration;
using PantryOrganiser.Domain.Entity;

namespace PantryOrganiser.DataAccess;

public class AppDbContext(DbContextOptions<AppDbContext> options) : DbContext(options)
{
    public DbSet<User> Users { get; set; }

    public DbSet<Pantry> Pantries { get; set; }

    public DbSet<ShoppingBasket> ShoppingBaskets { get; set; }

    public DbSet<PantryItem> PantryItems { get; set; }

    public DbSet<ShoppingBasketItem> ShoppingBasketItems { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.ApplyConfigurationsFromAssembly(typeof(UserConfiguration).Assembly);
    }
}
