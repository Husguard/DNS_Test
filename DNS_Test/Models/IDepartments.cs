using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DNS_Test.Models
{
    public interface IDepartments
    {
        List<Department> GetDepartments();
        int AddDepartment(string departmentName);
    }
}
