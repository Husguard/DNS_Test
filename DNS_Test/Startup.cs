using System;
using System.Collections.Generic;
using System.Linq;
using System.Configuration;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using DNS_Test.Models;
using System.Data.SqlClient;
using Microsoft.AspNetCore.Http;
using Microsoft.Net.Http.Headers;
using Microsoft.AspNetCore.Mvc;

namespace DNS_Test
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }
        public void ConfigureServices(IServiceCollection services)
        {
            // ���������� ��������� �����������, �� ���? ����� ��� � ������ �����? services.AddSingleton<ConnectionContext>();
            // services.AddMemoryCache();
            // ����� ������������ ���, ���� ����� ������� ��������� ������?
            // ����� ��������� ��� ������ �� ������� �������, ���� ������� ���, �� ����� ������ list<> ��� �������
            services.AddInitializingServices();
        }
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env, ILogger<Startup> logger)
        {
      //      env.EnvironmentName = "Production";
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                app.UseHsts();
            }
            app.UseResponseCompression();
            app.UseHttpsRedirection();
            app.UseStatusCodePagesWithReExecute("/Home/Error", "?code={404}");// ����� ���� ����� �����������, ���� � ������������ �������
            app.UseStaticFiles(new StaticFileOptions
            {
                OnPrepareResponse = (context) =>
                {
                    var headers = context.Context.Response.GetTypedHeaders();

                    headers.CacheControl = new CacheControlHeaderValue
                    {
                        Public = true,
                        MaxAge = TimeSpan.FromMinutes(1)
                    };
                }
            });

            app.UseRouting();
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Home}/{action=Index}/{id?}");
            });
        }
    }
}
