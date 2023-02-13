using System;
using System.Collections.Generic;
using System.Text;
using VP_Core;

namespace VP_Data.Contexts
{
    public class VPUnitOfWork : BaseUnitOfWork<VPDbContext>
    {
        public VPUnitOfWork(VPDbContext context) : base(context)
        {
        }
    }
}
