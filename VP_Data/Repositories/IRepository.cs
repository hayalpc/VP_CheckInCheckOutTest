using System;
using System.Collections.Generic;
using System.Text;
using VP_Core;
using VP_Data.Contexts;

namespace VP_Data.Repositories
{
    public interface IRepository<Tentity> : IBaseRepository<Tentity, VPDbContext>
        where Tentity : class
    {
        TOEntity ExecSqlFirst<TOEntity>(string sql) where TOEntity : class;
        List<Tentity> ExecSql(string sql);
        List<TQuery> ExecSqlQuery<TQuery>(string sql, params object[] parameters) where TQuery : class;
    }
}
