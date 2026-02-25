using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PantryOrganiser.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class RemoveShoppingItemAndPantryItemRelationship : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ShoppingBasketItems_PantryItems_PantryItemId",
                table: "ShoppingBasketItems");

            migrationBuilder.DropIndex(
                name: "IX_ShoppingBasketItems_PantryItemId",
                table: "ShoppingBasketItems");

            migrationBuilder.DropColumn(
                name: "PantryItemId",
                table: "ShoppingBasketItems");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "PantryItemId",
                table: "ShoppingBasketItems",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateIndex(
                name: "IX_ShoppingBasketItems_PantryItemId",
                table: "ShoppingBasketItems",
                column: "PantryItemId");

            migrationBuilder.AddForeignKey(
                name: "FK_ShoppingBasketItems_PantryItems_PantryItemId",
                table: "ShoppingBasketItems",
                column: "PantryItemId",
                principalTable: "PantryItems",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
