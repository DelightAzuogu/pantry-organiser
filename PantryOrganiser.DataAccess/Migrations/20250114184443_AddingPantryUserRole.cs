using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PantryOrganiser.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class AddingPantryUserRole : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Pantries_Users_UserId",
                table: "Pantries");

            migrationBuilder.DropIndex(
                name: "IX_Pantries_UserId",
                table: "Pantries");

            migrationBuilder.DropColumn(
                name: "UserId",
                table: "Pantries");

            migrationBuilder.CreateTable(
                name: "PantryUsers",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    PantryId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    UserId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    DeletedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PantryUsers", x => x.Id);
                    table.ForeignKey(
                        name: "FK_PantryUsers_Pantries_PantryId",
                        column: x => x.PantryId,
                        principalTable: "Pantries",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_PantryUsers_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "PantryUserRoles",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    PantryUserId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Role = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    DeletedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PantryUserRoles", x => x.Id);
                    table.ForeignKey(
                        name: "FK_PantryUserRoles_PantryUsers_PantryUserId",
                        column: x => x.PantryUserId,
                        principalTable: "PantryUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_PantryUserRoles_PantryUserId",
                table: "PantryUserRoles",
                column: "PantryUserId");

            migrationBuilder.CreateIndex(
                name: "IX_PantryUserRoles_PantryUserId_Role",
                table: "PantryUserRoles",
                columns: new[] { "PantryUserId", "Role" });

            migrationBuilder.CreateIndex(
                name: "IX_PantryUserRoles_Role",
                table: "PantryUserRoles",
                column: "Role");

            migrationBuilder.CreateIndex(
                name: "IX_PantryUsers_PantryId",
                table: "PantryUsers",
                column: "PantryId");

            migrationBuilder.CreateIndex(
                name: "IX_PantryUsers_PantryId_UserId",
                table: "PantryUsers",
                columns: new[] { "PantryId", "UserId" });

            migrationBuilder.CreateIndex(
                name: "IX_PantryUsers_UserId",
                table: "PantryUsers",
                column: "UserId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "PantryUserRoles");

            migrationBuilder.DropTable(
                name: "PantryUsers");

            migrationBuilder.AddColumn<Guid>(
                name: "UserId",
                table: "Pantries",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateIndex(
                name: "IX_Pantries_UserId",
                table: "Pantries",
                column: "UserId");

            migrationBuilder.AddForeignKey(
                name: "FK_Pantries_Users_UserId",
                table: "Pantries",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
