using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using VP_Core;
using VP_Data.Contexts;

namespace VP_Data.Repositories
{
    public class Repository<Tentity> : BaseRepository<Tentity, VPDbContext>, IRepository<Tentity>
        where Tentity : class
    {
        public Repository(VPDbContext context) : base(context)
        {
        }

        public TOEntity ExecSqlFirst<TOEntity>(string sql) where TOEntity : class
        {
            return context.Set<TOEntity>().FromSqlRaw(sql).FirstOrDefault();
        }

        public List<Tentity> ExecSql(string sql)
        {
            return context.Set<Tentity>().FromSqlRaw(sql).ToList();
        }

        public List<TQuery> ExecSqlQuery<TQuery>(string sql, params object[] parameters) where TQuery : class
        {
            return context.Set<TQuery>().FromSqlRaw(sql, parameters).ToList();
        }
    }
}
