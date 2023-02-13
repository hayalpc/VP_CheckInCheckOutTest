using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpOverrides;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;
using VP_Data.Contexts;
using Microsoft.EntityFrameworkCore;
using VP_CheckInCheckOutTest.Operations;
using VP_Data.Repositories;
using VP_Data.Models;
using VP_Core;
using System.Globalization;
using Microsoft.AspNetCore.Localization;

namespace VP_CheckInCheckOutTest
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            var conString = Configuration.GetConnectionString("Default");
            services.AddDbContext<VPDbContext>(options => options.UseSqlServer(conString));
            services.AddScoped<IBaseUnitOfWork, VPUnitOfWork>();

            services.AddScoped<IBookOperations, BookOperations>();
            services.AddScoped<IRepository<Book>, Repository<Book>>();
            services.AddScoped<IRepository<BookHistory>, Repository<BookHistory>>();
            services.AddScoped<IRepository<CheckedOutUser>, Repository<CheckedOutUser>>();

            services.Configure<RequestLocalizationOptions>(options =>
            {
                var supportedUICultures = new[]
                {
                    new CultureInfo("tr"),
                };

                var supportedCultures = new[]
                {
                    new CultureInfo("tr")
                };
                options.DefaultRequestCulture = new RequestCulture(culture: "tr", uiCulture: "tr");
                options.SupportedCultures = supportedCultures;
                options.SupportedUICultures = supportedUICultures;
            });

            services
            .AddControllersWithViews()
            .SetCompatibilityVersion(CompatibilityVersion.Version_3_0);

#if DEBUG
            services.AddRazorPages().AddRazorRuntimeCompilation();
#else
            services.AddRazorPages();
#endif
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Error");
            }

            app.UseStaticFiles();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Home}/{action=Index}/{id?}");
            });
        }
    }
}
