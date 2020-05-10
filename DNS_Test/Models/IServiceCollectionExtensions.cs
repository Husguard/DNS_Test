using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DNS_Test.Models
{
    // это методы расширения
    public static class IServiceCollectionExtensions
    {
        public static IServiceCollection AddInitializingServices(this IServiceCollection services)
        {
            services.AddSingleton<EmployeesContext>(); // не опасно ли при множестве запросов?
            services.AddResponseCompression(options => options.EnableForHttps = true);

            services.AddControllersWithViews(options =>
            {
                options.CacheProfiles.Add("Caching",
                    new CacheProfile()
                    {
                        Duration = 300
                    });
                options.CacheProfiles.Add("NoCaching",
                    new CacheProfile()
                    {
                        Location = ResponseCacheLocation.None,
                        NoStore = true
                    });
            });
            return services;
        }
    }
}
