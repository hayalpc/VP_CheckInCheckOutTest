using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace VP_Core
{
    public interface IBaseRepository<Tentity, Tcontext>
         where Tentity : class
       where Tcontext : DbContext
    {
        DbSet<Tentity> GetContext();
        DbSet<TEntity2> GetContext<TEntity2>() where TEntity2 : class;
        IQueryable<Tentity> GetQuery(Expression<Func<Tentity, bool>> predicate = null);
        IQueryable<TOEntity> GetQuery<TOEntity>(Expression<Func<TOEntity, bool>> predicate = null) where TOEntity : class;
        Tentity Get(Expression<Func<Tentity, bool>> predicate = null);
        TOEntity Get<TOEntity>(Expression<Func<TOEntity, bool>> predicate = null) where TOEntity : class;
        Tentity GetById(long Id);
        TOEntity GetById<TOEntity>(long Id) where TOEntity : class;
        Tentity GetById(long Id, bool AsNoTracking);
        TOEntity GetById<TOEntity>(long Id, bool AsNoTracking) where TOEntity : class;

        int SaveChanges();
        Task<int> SaveChangesAsync();

        void Insert(Tentity entity);
        void Insert<TOEntity>(TOEntity entity) where TOEntity : class;

        void InsertRange(IEnumerable<Tentity> entities);
        void InsertRange<TOEntity>(IEnumerable<TOEntity> entities) where TOEntity : class;
        void Update(Tentity entity);
        void Update<TOEntity>(TOEntity entity) where TOEntity : class;
        void Update<TOEntity>(TOEntity entity, params string[] fields) where TOEntity : class;
        void Update(Tentity entity, params string[] fields);
        void UpdateRange(IEnumerable<Tentity> entities);
        void Delete(Tentity entity);
        void DeleteRange(IEnumerable<Tentity> entities);
    }
}
