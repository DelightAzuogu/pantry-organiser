using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;
using PantryOrganiser.Domain.Interface;

namespace PantryOrganiser.DataAccess.Repository;

public class BaseRepository<TEntity>(AppDbContext dbContext) : IBaseRepository<TEntity>
    where TEntity : class, IBaseEntity
{
    protected readonly AppDbContext _context = dbContext;

    public async Task<TEntity> AddAsync(TEntity entity)
    {
        if (entity == null) throw new ArgumentNullException(nameof(entity), "Entity cannot be null when adding to the repository.");

        try
        {
            var now = DateTime.UtcNow;

            entity.CreatedAt = now;
            entity.UpdatedAt = now;

            await _context.AddAsync(entity);
            await _context.SaveChangesAsync();

            return entity;
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException($"Failed to add entity of type {typeof(TEntity).Name}. Error: {ex.Message}", ex);
        }
    }

    public async Task<IEnumerable<TEntity>> AddRangeAsync(IEnumerable<TEntity> entities)
    {
        if (entities == null) throw new ArgumentNullException(nameof(entities), "Entities collection cannot be null when adding range.");

        if (!entities.Any()) throw new ArgumentException("Entities collection cannot be empty when adding range.", nameof(entities));

        try
        {
            var now = DateTime.UtcNow;
            foreach (var entity in entities)
            {
                entity.CreatedAt = now;
                entity.UpdatedAt = now;
            }

            await _context.AddRangeAsync(entities);
            await _context.SaveChangesAsync();

            return entities;
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException($"Failed to add range of entities of type {typeof(TEntity).Name}. Error: {ex.Message}", ex);
        }
    }

    public IQueryable<TEntity> GetAll()
    {
        try
        {
            return _context.Set<TEntity>().Where(e => e.DeletedAt == null);
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException($"Failed to retrieve entities of type {typeof(TEntity).Name}. Error: {ex.Message}", ex);
        }
    }

    public async Task<TEntity> UpdateAsync(TEntity entity)
    {
        if (entity == null) throw new ArgumentNullException(nameof(entity), "Entity cannot be null when updating.");

        try
        {
            entity.UpdatedAt = DateTime.UtcNow;
            _context.Update(entity);
            await _context.SaveChangesAsync();

            return entity;
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException($"Failed to update entity of type {typeof(TEntity).Name}. Error: {ex.Message}", ex);
        }
    }

    public async Task UpdateRangeAsync(IEnumerable<TEntity> entities)
    {
        if (entities == null) throw new ArgumentNullException(nameof(entities), "Entities collection cannot be null when updating range.");

        if (!entities.Any()) throw new ArgumentException("Entities collection cannot be empty when updating range.", nameof(entities));

        try
        {
            var now = DateTime.UtcNow;
            foreach (var entity in entities)
            {
                entity.UpdatedAt = now;
            }

            _context.UpdateRange(entities);
            await _context.SaveChangesAsync();
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException($"Failed to update range of entities of type {typeof(TEntity).Name}. Error: {ex.Message}", ex);
        }
    }

    public async Task<TEntity> DeleteAsync(TEntity entity)
    {
        if (entity == null) throw new ArgumentNullException(nameof(entity), "Entity cannot be null when deleting.");

        try
        {
            entity.DeletedAt = DateTime.UtcNow;
            await _context.SaveChangesAsync();

            return entity;
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException($"Failed to delete entity of type {typeof(TEntity).Name}. Error: {ex.Message}", ex);
        }
    }

    public async Task DeleteRangeAsync(IEnumerable<TEntity> entities)
    {
        if (entities == null) throw new ArgumentNullException(nameof(entities), "Entities collection cannot be null when deleting range.");

        if (!entities.Any()) throw new ArgumentException("Entities collection cannot be empty when deleting range.", nameof(entities));

        try
        {
            var now = DateTime.UtcNow;

            foreach (var entity in entities)
            {
                entity.DeletedAt = now;
            }

            await _context.SaveChangesAsync();
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException($"Failed to delete range of entities of type {typeof(TEntity).Name}. Error: {ex.Message}", ex);
        }
    }

    public IQueryable<TEntity> Query(Expression<Func<TEntity, bool>> expression) => _context.Set<TEntity>().Where(e => e.DeletedAt == null).Where(expression);

    public Task<bool> AnyAsync(Expression<Func<TEntity, bool>> expression) => _context.Set<TEntity>().Where(e => e.DeletedAt == null).AnyAsync(expression);
}
