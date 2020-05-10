using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace DNS_Test.Models
{
    public interface IEmployeesCRD : ICRUD
        // а есть ли приватные интерфейсы?
    {
        // что с названиями переменных?
        // что с обобщениями T?
        // нужно определить правила, когда нужен целый объект, а когда вычленять из него значения

        // нужно определить список всего того, что можно сделать со списком работников
        //Employee CreateEmployee(SqlDataReader reader); // нельзя - интерфейс public
        List<Employee> GetEmployees(int page, int selected, bool sort, bool column);
        List<string> GetSuggests(string name);
        int GetCountOfPages(int selected);
        List<Employee> ShowChiefs(int id);
    }
}
