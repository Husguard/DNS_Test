using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DNS_Test.Models
{
    public interface IDbContext : ICRUD
        // CreateEmployee должен быть только в методах, которые работают с БД
        // что делать с Ienumrable при необходимости в листе?
    {
        // надо объединить похожести интерфейсов(получается что есть операции, которые нужно делать с записями, если их нет, то нужно обращаться к бд)
        void AddDepartment(string departmentName);
        List<Employee> DownloadEmployees();
        List<Department> DownloadDepartments();
        // ниже всякие методы, которые обращаются к бд вместо локального листа что неправильно
        List<string> GetSuggests(string name);
        List<Employee> ShowChiefs(int id);
    }
}
