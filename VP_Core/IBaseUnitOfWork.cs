using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Text;
using System.Threading.Tasks;

namespace VP_Core
{
    public interface IBaseUnitOfWork : IDisposable
    {
        void BeginTransaction();

        void CommitTransaction();

        void RollBackTransaction();

        int ExecuteSqlRaw(string sql, params object[] parameters);
        int ExecuteSqlRaw(string sql, IEnumerable<object> parameters);

        int SaveChanges();

        Task<int> SaveChangesAsync();
    }
}
