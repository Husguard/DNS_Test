using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DNS_Test.Models
{
    public interface IEmployees
    {
        int AddEmployee(Employee adding);
        void DeleteEmployee(int id);
        Employee FindEmployee(int id);
    }
}
