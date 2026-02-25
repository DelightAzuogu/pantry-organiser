using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PantryOrganiser.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class AddedNameToIngredient : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_RecipeIngredients_PantryItems_PantryItemId",
                table: "RecipeIngredients");

            migrationBuilder.DropIndex(
                name: "IX_RecipeIngredients_PantryItemId",
                table: "RecipeIngredients");

            migrationBuilder.DropIndex(
                name: "IX_RecipeIngredients_Quantity",
                table: "RecipeIngredients");

            migrationBuilder.DropColumn(
                name: "PantryItemId",
                table: "RecipeIngredients");

            migrationBuilder.AddColumn<string>(
                name: "Name",
                table: "RecipeIngredients",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "QuantityUnit",
                table: "RecipeIngredients",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Name",
                table: "RecipeIngredients");

            migrationBuilder.DropColumn(
                name: "QuantityUnit",
                table: "RecipeIngredients");

            migrationBuilder.AddColumn<Guid>(
                name: "PantryItemId",
                table: "RecipeIngredients",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateIndex(
                name: "IX_RecipeIngredients_PantryItemId",
                table: "RecipeIngredients",
                column: "PantryItemId");

            migrationBuilder.CreateIndex(
                name: "IX_RecipeIngredients_Quantity",
                table: "RecipeIngredients",
                column: "Quantity");

            migrationBuilder.AddForeignKey(
                name: "FK_RecipeIngredients_PantryItems_PantryItemId",
                table: "RecipeIngredients",
                column: "PantryItemId",
                principalTable: "PantryItems",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
