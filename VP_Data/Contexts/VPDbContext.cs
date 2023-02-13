using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;
using VP_Data.Models;

namespace VP_Data.Contexts
{
    public class VPDbContext : DbContext
    {
        public VPDbContext(DbContextOptions<VPDbContext> options) : base(options)
        {
            this.ChangeTracker.QueryTrackingBehavior = QueryTrackingBehavior.NoTracking;
            this.ChangeTracker.LazyLoadingEnabled = false;
            this.ChangeTracker.AutoDetectChangesEnabled = false;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            base.OnConfiguring(optionsBuilder);
            optionsBuilder.EnableDetailedErrors();
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {

        }

        public DbSet<Book> Book { get; set; }
        public DbSet<CheckedOutUser> CheckedOutUser { get; set; }
        public DbSet<BookHistory> BookHistory { get; set; }
    }
}
