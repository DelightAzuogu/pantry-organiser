﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using PantryOrganiser.DataAccess;

#nullable disable

namespace PantryOrganiser.DataAccess.Migrations
{
    [DbContext(typeof(AppDbContext))]
    [Migration("20250119072038_AddingQuantityUnit")]
    partial class AddingQuantityUnit
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "9.0.0")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("PantryOrganiser.Domain.Entity.Pantry", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<DateTime?>("DeletedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("UpdatedAt")
                        .HasColumnType("datetime2");

                    b.HasKey("Id");

                    b.ToTable("Pantries");
                });

            modelBuilder.Entity("PantryOrganiser.Domain.Entity.PantryItem", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Brand")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<DateTime?>("DeletedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("Description")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime?>("ExpiryDate")
                        .HasColumnType("datetime2");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.Property<Guid>("PantryId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<double>("Quantity")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("float")
                        .HasDefaultValue(0.0);

                    b.Property<string>("QuantityUnit")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("UpdatedAt")
                        .HasColumnType("datetime2");

                    b.HasKey("Id");

                    b.HasIndex("PantryId");

                    b.ToTable("PantryItems");
                });

            modelBuilder.Entity("PantryOrganiser.Domain.Entity.PantryUser", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<DateTime?>("DeletedAt")
                        .HasColumnType("datetime2");

                    b.Property<Guid>("PantryId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<DateTime>("UpdatedAt")
                        .HasColumnType("datetime2");

                    b.Property<Guid>("UserId")
                        .HasColumnType("uniqueidentifier");

                    b.HasKey("Id");

                    b.HasIndex("PantryId");

                    b.HasIndex("UserId");

                    b.HasIndex("PantryId", "UserId");

                    b.ToTable("PantryUsers");
                });

            modelBuilder.Entity("PantryOrganiser.Domain.Entity.PantryUserRole", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<DateTime?>("DeletedAt")
                        .HasColumnType("datetime2");

                    b.Property<Guid>("PantryUserId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Role")
                        .IsRequired()
                        .HasMaxLength(20)
                        .HasColumnType("nvarchar(20)");

                    b.Property<DateTime>("UpdatedAt")
                        .HasColumnType("datetime2");

                    b.HasKey("Id");

                    b.HasIndex("PantryUserId");

                    b.HasIndex("Role");

                    b.HasIndex("PantryUserId", "Role");

                    b.ToTable("PantryUserRoles");
                });

            modelBuilder.Entity("PantryOrganiser.Domain.Entity.ShoppingBasket", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<DateTime?>("DeletedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("UpdatedAt")
                        .HasColumnType("datetime2");

                    b.Property<Guid>("UserId")
                        .HasColumnType("uniqueidentifier");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("ShoppingBaskets");
                });

            modelBuilder.Entity("PantryOrganiser.Domain.Entity.ShoppingBasketItem", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<DateTime?>("DeletedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("Name")
                        .HasColumnType("nvarchar(max)");

                    b.Property<Guid>("PantryItemId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<int>("Quantity")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasDefaultValue(0);

                    b.Property<Guid>("ShoppingBasketId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<DateTime>("UpdatedAt")
                        .HasColumnType("datetime2");

                    b.HasKey("Id");

                    b.HasIndex("PantryItemId");

                    b.HasIndex("ShoppingBasketId");

                    b.ToTable("ShoppingBasketItems");
                });

            modelBuilder.Entity("PantryOrganiser.Domain.Entity.User", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<DateTime?>("DeletedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.Property<string>("PasswordHash")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.Property<DateTime>("UpdatedAt")
                        .HasColumnType("datetime2");

                    b.HasKey("Id");

                    b.ToTable("Users");
                });

            modelBuilder.Entity("PantryOrganiser.Domain.Entity.PantryItem", b =>
                {
                    b.HasOne("PantryOrganiser.Domain.Entity.Pantry", "Pantry")
                        .WithMany("PantryItems")
                        .HasForeignKey("PantryId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.Navigation("Pantry");
                });

            modelBuilder.Entity("PantryOrganiser.Domain.Entity.PantryUser", b =>
                {
                    b.HasOne("PantryOrganiser.Domain.Entity.Pantry", "Pantry")
                        .WithMany("PantryUsers")
                        .HasForeignKey("PantryId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("PantryOrganiser.Domain.Entity.User", "User")
                        .WithMany("PantryUsers")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Pantry");

                    b.Navigation("User");
                });

            modelBuilder.Entity("PantryOrganiser.Domain.Entity.PantryUserRole", b =>
                {
                    b.HasOne("PantryOrganiser.Domain.Entity.PantryUser", "PantryUser")
                        .WithMany("PantryUserRoles")
                        .HasForeignKey("PantryUserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("PantryUser");
                });

            modelBuilder.Entity("PantryOrganiser.Domain.Entity.ShoppingBasket", b =>
                {
                    b.HasOne("PantryOrganiser.Domain.Entity.User", "User")
                        .WithMany("ShoppingBaskets")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.Navigation("User");
                });

            modelBuilder.Entity("PantryOrganiser.Domain.Entity.ShoppingBasketItem", b =>
                {
                    b.HasOne("PantryOrganiser.Domain.Entity.PantryItem", "PantryItem")
                        .WithMany("ShoppingBasketItems")
                        .HasForeignKey("PantryItemId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.HasOne("PantryOrganiser.Domain.Entity.ShoppingBasket", "ShoppingBasket")
                        .WithMany("ShoppingBasketItems")
                        .HasForeignKey("ShoppingBasketId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.Navigation("PantryItem");

                    b.Navigation("ShoppingBasket");
                });

            modelBuilder.Entity("PantryOrganiser.Domain.Entity.Pantry", b =>
                {
                    b.Navigation("PantryItems");

                    b.Navigation("PantryUsers");
                });

            modelBuilder.Entity("PantryOrganiser.Domain.Entity.PantryItem", b =>
                {
                    b.Navigation("ShoppingBasketItems");
                });

            modelBuilder.Entity("PantryOrganiser.Domain.Entity.PantryUser", b =>
                {
                    b.Navigation("PantryUserRoles");
                });

            modelBuilder.Entity("PantryOrganiser.Domain.Entity.ShoppingBasket", b =>
                {
                    b.Navigation("ShoppingBasketItems");
                });

            modelBuilder.Entity("PantryOrganiser.Domain.Entity.User", b =>
                {
                    b.Navigation("PantryUsers");

                    b.Navigation("ShoppingBaskets");
                });
#pragma warning restore 612, 618
        }
    }
}
