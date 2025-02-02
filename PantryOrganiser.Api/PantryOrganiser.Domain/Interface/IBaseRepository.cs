using System.Linq.Expressions;

namespace PantryOrganiser.Domain.Interface;

public interface IBaseRepository<TEntity> where TEntity : class, IBaseEntity
{
    IQueryable<TEntity> GetAll();
    Task<TEntity> AddAsync(TEntity entity);
    Task<TEntity> UpdateAsync(TEntity entity);
    public Task UpdateRangeAsync(IEnumerable<TEntity> entities);
    Task<TEntity> DeleteAsync(TEntity entity);
    public Task DeleteRangeAsync(IEnumerable<TEntity> entities);
    IQueryable<TEntity> Query(Expression<Func<TEntity, bool>> expression);
    Task<bool> AnyAsync(Expression<Func<TEntity, bool>> expression);
}
