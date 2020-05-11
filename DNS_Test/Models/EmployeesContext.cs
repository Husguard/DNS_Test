using Microsoft.Extensions.Caching.Memory;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace DNS_Test.Models
{
    public class EmployeesContext : IContext
    {
        private List<Employee> employees;
        private List<Department> departments;
        private readonly IContext connection; // это БД, с которой локалка синхронизируется
        public EmployeesContext()
        {
            connection = new ConnectionContext(); // по хорошему такие вещи создаются в middleware, чтобы класс не знал что именно ему нужно
            departments = connection.DownloadDepartments();
            employees = connection.DownloadEmployees();
        }
        public IEnumerable<Employee> Test()
        {
            return new List<Employee>();
        }
        public List<Employee> DownloadEmployees()
        {
            employees = connection.DownloadEmployees();
            return employees;
        }
        public List<Department> DownloadDepartments()
        {
            departments = connection.DownloadDepartments();
            return departments;
        }
        public List<Employee> GetEmployees(int page, int selected, bool sort, bool column)
        {
            if (page * selected > employees.Count) page = 0; // грубое исправление
            if (sort) return employees.OrderBy(x => column ? x.Name : x.Department.Name).ToList().GetRange(page * selected, selected % (employees.Count - page * selected));
            else return employees.OrderByDescending(x => column ? x.Name : x.Department.Name).ToList().GetRange(page * selected, selected % (employees.Count - page * selected));
        }
        
        public int GetCountOfPages(int selected)
        {
            return (int)Math.Ceiling((decimal)employees.Count / selected);
        }
        public List<string> GetSuggests(string name)
        {
            return connection.GetSuggests(name);
        }
        public void AddDepartment(string departmentName)
        {
            connection.AddDepartment(departmentName);
            // ID нового отдела неизвестен(решаемо загрузкой снова)
        }
        public List<Department> GetDepartments()
        {
            return departments;
        }
        public void AddEmployee(Employee adding)
        {
            connection.AddEmployee(adding);
            adding.Department = departments.Find(x => x.Id == adding.Department.Id); // имя отдела не передаётся вместе с данными от формы
            employees.Add(adding);
            connection.DownloadEmployees(); // ID нового неизвестен
            // можно искать в бд нового добавленного и добавлять его
        }
        public void DeleteEmployee(int id)
        {
            connection.DeleteEmployee(id);
            employees.Remove(employees.Find(x => x.Id == id));
        }
        public List<Employee> ShowChiefs(int id)
        {
            return connection.ShowChiefs(id);
        }
        public Employee FindEmployee(int id)
        {
            Employee adding = employees.Find(x => x.Id == id);
            if (adding == null)
            {
                connection.FindEmployee(id);
            }
            return adding;
        }
    }
}
