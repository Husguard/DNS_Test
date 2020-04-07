using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace DNS_Test.Models
{
    public class ConnectionContext
    {
        SqlDataReader reader;
        List<Employee> employees;
        string connectionName;
        public ConnectionContext()
        {
            connectionName = "Server = (localdb)\\mssqllocaldb; Database = EmployeesDB; Trusted_Connection = True;";
            employees = new List<Employee>();
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
            if (reader["ChiefId"] != DBNull.Value)
            {
                adding.Chief = new Employee
                {
                    Id = Convert.ToInt32(reader["ChiefId"]),
                    Name = Convert.ToString(reader["Chief"])
                };
            }
            return adding;
        }
        public IEnumerable<Employee> GetEmployees(int page, int selected, bool sort, bool column)
        {
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
                            employees.Add(CreateEmployee(reader));
                        }
                    }
                }
            }
            return employees;
        }
        public void AddEmployee(Employee adding)
        {
            using (SqlConnection connection = new SqlConnection(connectionName))
            {
                connection.Open();
                string sqlExpression = "EXEC ProcedureAddEmployee @Name, @Post, @Department, @Chief, @Date";
                using (SqlCommand command = new SqlCommand(sqlExpression, connection))
                {
                    command.Parameters.Add(new SqlParameter("@Name", adding.Name));
                    command.Parameters.Add(new SqlParameter("@Post", adding.Post));
                    command.Parameters.Add(new SqlParameter("@Department", adding.Department.Id));
                    command.Parameters.Add(new SqlParameter("@Chief",  adding.Chief.Id == 0 ? (object)DBNull.Value : adding.Chief.Id)); // от формы приходит с chief с нулём
                    command.Parameters.Add(new SqlParameter("@Date", adding.Date.ToString("yyyy-MM-dd")));
                    command.ExecuteNonQuery();
                }
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
            }
        }
        public IEnumerable<Employee> ShowChiefs(int id)
        {
            List<Employee> chiefs = new List<Employee>();
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
                            chiefs.Add(CreateEmployee(reader));
                        }
                    }
                }
            }
            return chiefs;
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
            }
            return adding;
        }
    }
}
