using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DNS_Test.Models
{
    public interface IContext : IEmployees, IDownloader, IDepartments
    // CreateEmployee должен быть только в методах, которые работают с БД
    // что делать с Ienumrable при необходимости в листе?
    // что с названиями переменных?
    // что с обобщениями T?
    // нужно определить правила, когда нужен целый объект, а когда вычленять из него значения
    // нужно определить список всего того, что можно сделать со списком работников
    //Employee CreateEmployee(SqlDataReader reader); // нельзя - интерфейс public
    {
        List<Employee> GetEmployees(int page, int selected, bool sort, bool column);
        List<string> GetSuggests(string name);
        List<Employee> ShowChiefs(int id);
        int GetCountOfPages(int selected);
    }
}
