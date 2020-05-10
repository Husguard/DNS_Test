using System;
using System.Collections.Generic;
using System.Text;
namespace UnitTestApp.Models
{
    public interface IRepository
    {
        IEnumerable<User> GetAll();
        User Get(int id);
        void Create(User user);
    }
}