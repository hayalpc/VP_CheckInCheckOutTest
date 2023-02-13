using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Threading.Tasks;

namespace VP_Core
{
    public abstract class BaseUnitOfWork<TContext> : IBaseUnitOfWork where TContext : DbContext
    {
        private readonly TContext context;
        private IDbContextTransaction transaction;

        public BaseUnitOfWork(TContext context)
        {
            this.context = context;
        }

        public void BeginTransaction()
        {
            transaction = context.Database.BeginTransaction();
        }

        public void CommitTransaction()
        {
            transaction.Commit();
        }

        public void RollBackTransaction()
        {
            transaction.Rollback();
        }

        public int SaveChanges()
        {
            return context.SaveChanges();
        }

        public Task<int> SaveChangesAsync()
        {
            return context.SaveChangesAsync();
        }

        public void Dispose()
        {
            context.Dispose();
        }

        public int ExecuteSqlRaw(string sql, params object[] parameters)
        {
            return context.Database.ExecuteSqlRaw(sql, parameters);
        }

        public int ExecuteSqlRaw(string sql, IEnumerable<object> parameters)
        {
            return context.Database.ExecuteSqlRaw(sql, parameters);
        }
    }
}
