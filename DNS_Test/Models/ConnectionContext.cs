using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace DNS_Test.Models
{
    public class ConnectionContext : IContext
    {
        private SqlDataReader reader;
        private readonly string connectionName;
        public ConnectionContext()
        {
            connectionName = "Server = (localdb)\\mssqllocaldb; Database = EmployeesDB; Trusted_Connection = True;";
        }
        public List<Employee> DownloadEmployees()
        {
            List<Employee> employees = new List<Employee>();
            using (SqlConnection connection = new SqlConnection(connectionName))
            {
                connection.Open();
                string sqlExpression = "EXEC ProcedureGetAllEmployees";
                using (SqlCommand command = new SqlCommand(sqlExpression, connection))
                {
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
            return employees;
        }
        public List<Department> GetDepartments() // плохо - downloaddepartments и getdepartments это один и тот же метод
        {
            return DownloadDepartments();
        }
        public List<Department> DownloadDepartments()
        {
            List<Department> departments = new List<Department>();
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
            return departments;
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
        public int GetCountOfPages(int selected)
        {
            int value = 0;
            using (SqlConnection connection = new SqlConnection(connectionName))
            {
                connection.Open();
                string sqlExpression = "SELECT Count(*) FROM Employees";
                using (SqlCommand command = new SqlCommand(sqlExpression, connection))
                {
                    using (reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            value = Convert.ToInt32(reader[0]);
                        }
                    }
                }
                connection.Close();
            }
            return (int)Math.Ceiling((decimal)value / selected);
        }
        public List<Employee> GetEmployees(int page, int selected, bool sort, bool column)
        {
            List<Employee> employees = new List<Employee>();
            using (SqlConnection connection = new SqlConnection(connectionName))
            {
                connection.Open();
                string sqlExpression = "EXEC ProcedureShowPageOfEmployees @page, @selected, @sort, @column";
                using (SqlCommand command = new SqlCommand(sqlExpression, connection))
                {
                    command.Parameters.Add(new SqlParameter("@page", page));
                    command.Parameters.Add(new SqlParameter("@selected", selected));
                    command.Parameters.Add(new SqlParameter("@sort", sort ? "ASC" : "DESC"));
                    command.Parameters.Add(new SqlParameter("@column", column ? "F.Name" : "Departments"));
                    using (reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            employees.Add(CreateEmployee(reader));
                        }
                    }
                }
                connection.Close();
            }
            return employees;
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
                    command.Parameters.Add(new SqlParameter("@Chief", adding.Chief.Id == 0 ? (object)DBNull.Value : adding.Chief.Id));
                    // начальник приходит инициализированным из-за взаимодействия с name свойством.
                    command.Parameters.Add(new SqlParameter("@Date", adding.Date.ToString("yyyy-MM-dd")));
                    command.ExecuteNonQuery();
                }
                connection.Close();
            }
        }
        public void DeleteEmployee(int id)
        {
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
            Employee adding = new Employee();
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
            return adding;
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
    }
}
