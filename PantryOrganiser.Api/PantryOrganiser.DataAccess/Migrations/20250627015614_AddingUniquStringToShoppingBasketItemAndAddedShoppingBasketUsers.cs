using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PantryOrganiser.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class AddingUniquStringToShoppingBasketItemAndAddedShoppingBasketUsers : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "UniqueString",
                table: "ShoppingBaskets",
                type: "nvarchar(450)",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsChecked",
                table: "ShoppingBasketItems",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<string>(
                name: "QuantityUnit",
                table: "ShoppingBasketItems",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateTable(
                name: "ShoppingBasketUsers",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    UserId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    ShoppingBasketId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    IsOwner = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    DeletedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ShoppingBasketUsers", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ShoppingBasketUsers_ShoppingBaskets_ShoppingBasketId",
                        column: x => x.ShoppingBasketId,
                        principalTable: "ShoppingBaskets",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_ShoppingBasketUsers_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ShoppingBaskets_UniqueString",
                table: "ShoppingBaskets",
                column: "UniqueString",
                unique: true,
                filter: "[UniqueString] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_ShoppingBasketUsers_ShoppingBasketId",
                table: "ShoppingBasketUsers",
                column: "ShoppingBasketId");

            migrationBuilder.CreateIndex(
                name: "IX_ShoppingBasketUsers_UserId_ShoppingBasketId",
                table: "ShoppingBasketUsers",
                columns: new[] { "UserId", "ShoppingBasketId" },
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ShoppingBasketUsers");

            migrationBuilder.DropIndex(
                name: "IX_ShoppingBaskets_UniqueString",
                table: "ShoppingBaskets");

            migrationBuilder.DropColumn(
                name: "UniqueString",
                table: "ShoppingBaskets");

            migrationBuilder.DropColumn(
                name: "IsChecked",
                table: "ShoppingBasketItems");

            migrationBuilder.DropColumn(
                name: "QuantityUnit",
                table: "ShoppingBasketItems");
        }
    }
}
