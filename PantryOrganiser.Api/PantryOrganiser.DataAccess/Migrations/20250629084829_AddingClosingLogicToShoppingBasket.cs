﻿using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PantryOrganiser.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class AddingClosingLogicToShoppingBasket : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "IsClosed",
                table: "ShoppingBaskets",
                type: "bit",
                nullable: false,
                defaultValue: false);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IsClosed",
                table: "ShoppingBaskets");
        }
    }
}
