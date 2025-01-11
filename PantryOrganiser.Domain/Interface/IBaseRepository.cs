using System.Linq.Expressions;

namespace PantryOrganiser.Domain.Interface;

public interface IBaseRepository<TEntity> where TEntity : class, IBaseEntity
{
    IQueryable<TEntity> GetAll();
    Task<TEntity> AddAsync(TEntity entity);
    Task<TEntity> UpdateAsync(TEntity entity);
    Task<TEntity> DeleteAsync(TEntity entity);
    IQueryable<TEntity> Query(Expression<Func<TEntity, bool>> expression);
    Task<bool> AnyAsync(Expression<Func<TEntity, bool>> expression);
}
