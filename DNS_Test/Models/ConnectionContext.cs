using Microsoft.Extensions.Caching.Memory;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace DNS_Test.Models
{
    public class ConnectionContext
    {
        private SqlDataReader reader;
        private List<Employee> employees;
        private List<Department> departments;
        private readonly string connectionName;
        public ConnectionContext()
        {
            connectionName = "Server = (localdb)\\mssqllocaldb; Database = EmployeesDB; Trusted_Connection = True;";
            // можно сделать так: создать класс, импортирующий все записи при запуске, затем через только запросы менять состояние локального листа
            // по окончании операций сохранять изменения
            // то есть все методы здесь будут работать только с локальным листом, а при изменении его вызывать новый класс для подключения бд
        }
        private Employee CreateEmployee(SqlDataReader reader)
        {
            Employee adding = new Employee
            {
                Id = Convert.ToInt32(reader["Id"]),
                Name = Convert.ToString(reader["Name"]),
                Post = Convert.ToString(reader["Post"]),
                Date = Convert.ToDateTime(reader["Date"])
            };
            if (reader["DepartmentId"] != DBNull.Value)
            {
                adding.Department = new Department
                {
                    Id = Convert.ToInt32(reader["DepartmentId"]),
                    Name = Convert.ToString(reader["Department"])
                };
            }
            if (reader["Chief"] != DBNull.Value)
            {
                adding.Chief = new Employee
                {
                    Id = Convert.ToInt32(reader["ChiefId"]),
                    Name = Convert.ToString(reader["Chief"])
                };
            }
            return adding;
        }
        public List<Employee> GetEmployees(int page, int selected, bool sort, bool column)
        {
            if (true) // при изменении страницы и столбца нужны новые данные
            {
                employees = new List<Employee>();
                string columnName = column ? "F.Name" : "Department";
                string sortName = sort ? "ASC" : "DESC";
                using (SqlConnection connection = new SqlConnection(connectionName))
                {
                    connection.Open();
                    string sqlExpression = "EXEC ProcedureShowPageOfEmployees @page, @selected, @sort, @column";
                    using (SqlCommand command = new SqlCommand(sqlExpression, connection))
                    {
                        command.Parameters.Add(new SqlParameter("@page", page));
                        command.Parameters.Add(new SqlParameter("@selected", selected));
                        command.Parameters.Add(new SqlParameter("@column", columnName));
                        command.Parameters.Add(new SqlParameter("@sort", sortName));
                        using (reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                Employee employee = CreateEmployee(reader);
                                employees.Add(employee);
                            }
                        }
                    }
                    connection.Close();
                }
            }
            else // сортировка только в рамках ВЫБРАННЫХ данных(ЗАГРУЖЕНЫ ЛИ ОСТАЛЬНЫЕ ДАННЫЕ ВЛИЯЕТ НА ОБЩИЙ РЕЗУЛЬТАТ) - тоесть смысла не имеет
            {
                if (sort) return employees.GetRange(page * selected, selected).OrderBy(x => column ? x.Name : x.Department.Name).ToList();
                else return employees.GetRange(page * selected, selected).OrderByDescending(x => column ? x.Name : x.Department.Name).ToList();
            }
            return employees;
        }
        public List<string> GetSuggests(string name)
        {
            List<string> employees = new List<string>();
            using (SqlConnection connection = new SqlConnection(connectionName))
            {
                connection.Open();
                string sqlExpression = "EXEC ProcedureGetSuggests @name";
                using (SqlCommand command = new SqlCommand(sqlExpression, connection))
                {
                    command.Parameters.Add(new SqlParameter("@name", name));
                    using (reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            employees.Add(reader["Name"].ToString());
                        }
                    }
                }
                connection.Close();
            }
            return employees;
        }
        public int GetPage(int pages)
        {
            int value;
            using (SqlConnection connection = new SqlConnection(connectionName))
            {
                connection.Open();
                string sqlExpression = "SELECT COUNT(*) AS Count FROM Employees";
                using (SqlCommand command = new SqlCommand(sqlExpression, connection))
                {
                    using (reader = command.ExecuteReader())
                    {
                        reader.Read();
                        value = (int)Math.Ceiling(Convert.ToDecimal(reader["Count"]) / pages);
                    }
                }
                connection.Close();
                return value;
            }
        }
        public void AddDepartment(string departmentName)
        {
            using (SqlConnection connection = new SqlConnection(connectionName))
            {
                connection.Open();
                string sqlExpression = "EXEC ProcedureAddDepartment @name";
                using (SqlCommand command = new SqlCommand(sqlExpression, connection))
                {
                    command.Parameters.Add(new SqlParameter("@name", departmentName));
                    command.ExecuteNonQuery();
                }
                connection.Close();
            }
        }
        public List<Department> GetDepartments()
        {
            if (departments == null)
            {
                departments = new List<Department>();
                using (SqlConnection connection = new SqlConnection(connectionName))
                {
                    connection.Open();
                    string sqlExpression = "EXEC ProcedureGetDepartments";
                    using (SqlCommand command = new SqlCommand(sqlExpression, connection))
                    {
                        using (reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                departments.Add(new Department() { Id = Convert.ToInt32(reader["Id"]), Name = Convert.ToString(reader["Name"]) });
                            }
                        }
                    }
                    connection.Close();
                }
            }
            return departments;
        }
        public void AddEmployee(Employee adding)
        {
            using (SqlConnection connection = new SqlConnection(connectionName))
            {
                connection.Open();
                string sqlExpression;
                if (adding.Chief.Name != null)
                {
                    sqlExpression = "EXEC ProcedureGetSuggests @name";
                    using (SqlCommand command = new SqlCommand(sqlExpression, connection))
                    {
                        command.Parameters.Add(new SqlParameter("@name", adding.Chief.Name));
                        using (reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                adding.Chief.Id = Convert.ToInt32(reader["Id"]);
                                adding.Chief.Name = Convert.ToString(reader["Name"]);
                            }
                        }
                    }
                }
                sqlExpression = "EXEC ProcedureAddEmployee @Name, @Post, @Department, @Chief, @Date";
                using (SqlCommand command = new SqlCommand(sqlExpression, connection))
                {
                    command.Parameters.Add(new SqlParameter("@Name", adding.Name));
                    command.Parameters.Add(new SqlParameter("@Post", adding.Post));
                    command.Parameters.Add(new SqlParameter("@Department", adding.Department.Id));
                    command.Parameters.Add(new SqlParameter("@Chief", adding.Chief == null ? (object)DBNull.Value : adding.Chief.Id));
                    command.Parameters.Add(new SqlParameter("@Date", adding.Date.ToString("yyyy-MM-dd")));
                    command.ExecuteNonQuery();
                }
                connection.Close();
            }
        }
        public void DeleteEmployee(int id)
        {
            employees.Remove(employees.Find(x => x.Id == id));
            using (SqlConnection connection = new SqlConnection(connectionName))
            {
                connection.Open();
                string sqlExpression = "EXEC ProcedureDeleteEmployee @Id";
                using (SqlCommand command = new SqlCommand(sqlExpression, connection))
                {
                    command.Parameters.Add(new SqlParameter("@Id", id));
                    command.ExecuteNonQuery();
                }
                connection.Close();
            }
            
        }
        public List<Employee> ShowChiefs(int id)
        {
            List<Employee> subordinates = new List<Employee>();
            using (SqlConnection connection = new SqlConnection(connectionName))
            {
                connection.Open();
                string sqlExpression = "EXEC ProcedureShowChiefs @Id";
                using (SqlCommand command = new SqlCommand(sqlExpression, connection))
                {
                    command.Parameters.Add(new SqlParameter("@Id", id));
                    using (reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            subordinates.Add(CreateEmployee(reader));
                        }
                    }
                }
                connection.Close();
            }
            return subordinates;
        }
        public Employee FindEmployee(int id)
        {
            Employee adding = employees.Find(x => x.Id == id);
            if (adding == null)
            {
                using (SqlConnection connection = new SqlConnection(connectionName))
                {
                    connection.Open();
                    string sqlExpression = "EXEC ProcedureFindEmployee @Id";
                    using (SqlCommand command = new SqlCommand(sqlExpression, connection))
                    {
                        command.Parameters.Add(new SqlParameter("@Id", id));
                        using (reader = command.ExecuteReader())
                        {
                            reader.Read();
                            adding = CreateEmployee(reader);
                        }
                    }
                    connection.Close();
                }
            }
            return adding;
        }
    }
}
