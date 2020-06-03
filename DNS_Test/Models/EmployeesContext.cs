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
        private readonly IDownloader downloader;
        private readonly IContext connection; // это БД, с которой локалка синхронизируется, методы бд работают как подстраховка, если в локалке нет
        // синхронизация нужна только по методам добавления и удаления, их можно в отдельный интерфейс засунуть и поменять его в connection, при этом оставив icontext
        // интерфейсы накладываются друг на друга, то есть либо синхронизация и все остальное, либо работники/департамент сами выбирают что отсылать/оставлять в локалке
        public EmployeesContext()
        {
            connection = new ConnectionContext(); // по хорошему такие вещи создаются в middleware, чтобы класс не знал что именно ему нужно
            downloader = (ConnectionContext)connection; // если понадобится менять загрузчик - вставить свой, IContext все равно считвется БД с которой будет синхронизация(но в ней нет методов переноса из загрузчикав БД)
            departments = downloader.DownloadDepartments();
            employees = downloader.DownloadEmployees();
            UpdateReferences();
        }
        // нужно пересмотреть отношения интерфейсов, наложение происходит
        public IEnumerable<Employee> Test()
        {
            return new List<Employee>();
        }
        public List<Employee> GetEmployees(int page, int selected, bool sort, bool column) // selected тоже придется исправлять
        {
            try
            {
                if (page * selected > employees.Count) page = GetCountOfPages(selected); // грубое исправление
                if (sort) return employees.OrderBy(x => column ? x.Name : x.Department.Name).ToList().GetRange(page * selected, selected % (employees.Count - page * selected));
                else return employees.OrderByDescending(x => column ? x.Name : x.Department.Name).ToList().GetRange(page * selected, selected % (employees.Count - page * selected));
            }
            finally
            {
                
            }
        }
        
        public int GetCountOfPages(int selected)
        {
            return (int)Math.Ceiling((decimal)employees.Count / selected);
        }
        public List<string> GetSuggests(string name)
        {
            List<string> suggests = new List<string>();
            List<Employee> linq = employees.Where(x => x.Name.StartsWith(name, true, null)).ToList(); // нужно игнорирование регистра, мб тело функции??
            foreach(Employee employee in linq)
            {
                suggests.Add(employee.Name);
            }
            return suggests;
        }
        public int AddDepartment(string departmentName)
        {
            int newId = connection.AddDepartment(departmentName);
            departments.Add(new Department() { Id = newId, Name = departmentName });
            return newId;
        }
        public List<Department> GetDepartments()
        {
            return departments;
        }
        public int AddEmployee(Employee adding)
        {
            int newId = connection.AddEmployee(adding);
            adding.Id = newId;
            adding.Department = departments.Find(x => x.Id == adding.Department.Id); // имя отдела не передаётся вместе с данными от формы
            adding.Chief = employees.Find(x => x.Id == adding.Chief.Id);
            employees.Add(adding);
            return newId;
        }
        private void UpdateReferences()
        {
            foreach(Employee employee in employees)
            {
                if(employee.Chief != null)
                {
                    Employee select = employees.Find(x => x.Id == employee.Chief.Id);
                    employee.Chief = select;
                    while (select.Chief != null)
                    {
                        select = employees.Find(x => x.Id == select.Chief.Id);
                    }
                }
            }
        }
        public void DeleteEmployee(int id)
        {
            connection.DeleteEmployee(id);
            employees.Remove(employees.Find(x => x.Id == id));
        }
        public List<Employee> ShowChiefs(int id)
        {
            Employee select = employees.Find(x => x.Id == id);
            List<Employee> chiefs = new List<Employee>();
            while (select.Chief != null)
            {
                //       select = employees.Find(x => x.Id == select.Chief.Id); // это поиск среди остального списка, а не по иерархии ссылок
                select = select.Chief;
                chiefs.Add(select);
            }
            return chiefs; 
           // return connection.ShowChiefs(id);
        }
        public Employee FindEmployee(int id)
        {
            Employee select = employees.Find(x => x.Id == id);
            /*
            if (select == null)
            {
                connection.FindEmployee(id);
            }
            */
            return select;
        }
    }
}
