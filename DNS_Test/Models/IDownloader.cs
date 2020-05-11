using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DNS_Test.Models
{
    public interface IDownloader
    {
        List<Employee> DownloadEmployees();
        List<Department> DownloadDepartments();
    }
}
