using Microsoft.AspNetCore.Mvc;
//using UnitTestApp.Controllers;
using UnitTestApp.Models;
using Moq;
using Xunit;
using System.Collections.Generic;
using System.Linq;
using System;
using DNS_Test.Models;
using DNS_Test.Controllers;
// нужно сделать: модель настроек, интерфейсы подходящие(для этого нужно создать один единый интерфейс и два класса(БД и локалька) взаимодействия)
namespace UnitTestApp.Tests
{
    public class HomeControllerTests
    {
        [Fact]
        public void IndexReturnsAViewResultWithAListOfUsers()
        {
            // Arrange
            var mock = new Mock<IDbContext>();
            mock.Setup(repo => repo.DownloadEmployees()).Returns(GetTestUsers());
            var controller = new EmployeesContext(mock.Object);

            // Act
            var result = controller.GetDepartments();

            // Assert
            var viewResult = Assert.IsType<ViewResult>(result);
            var model = Assert.IsAssignableFrom<IEnumerable<Employee>>(
                viewResult.Model);
            Assert.Equal(GetTestUsers().Count, model.Count());
        }
        private List<Employee> GetTestUsers()
        {
            var users = new List<Employee>
            {
                new Employee { Id=1, Name="Tom"},
                new Employee { Id=2, Name="Alice"},
                new Employee { Id=3, Name="Sam"},
                new Employee { Id=4, Name="Kate"}
            };
            return users;
        }
        /*
        [Fact]
        public void AddUserReturnsViewResultWithUserModel()
        {
            // Arrange
            var mock = new Mock<IRepository>();
            var controller = new HomeController(mock.Object);
            controller.ModelState.AddModelError("Name", "Required");
            User newUser = new User();

            // Act
            var result = controller.AddUser(newUser);

            // Assert
            var viewResult = Assert.IsType<ViewResult>(result);
            Assert.Equal(newUser, viewResult?.Model);
        }

        [Fact]
        public void AddUserReturnsARedirectAndAddsUser()
        {
            // Arrange
            var mock = new Mock<IRepository>();
            var controller = new HomeController(mock.Object);
            var newUser = new User()
            {
                Name = "Ben"
            };

            // Act
            var result = controller.AddUser(newUser);

            // Assert
            var redirectToActionResult = Assert.IsType<RedirectToActionResult>(result);
            Assert.Null(redirectToActionResult.ControllerName);
            Assert.Equal("Index", redirectToActionResult.ActionName);
            mock.Verify(r => r.Create(newUser));
        }

        [Fact]
        public void GetUserReturnsBadRequestResultWhenIdIsNull()
        {
            // Arrange
            var mock = new Mock<IRepository>();
            var controller = new HomeController(mock.Object);

            // Act
            var result = controller.GetUser(null);

            // Arrange
            Assert.IsType<BadRequestResult>(result);
        }

        [Fact]
        public void GetUserReturnsNotFoundResultWhenUserNotFound()
        {
            // Arrange
            int testUserId = 1;
            var mock = new Mock<IRepository>();
            mock.Setup(repo => repo.Get(testUserId))
                .Returns(null as User);
            var controller = new HomeController(mock.Object);

            // Act
            var result = controller.GetUser(testUserId);

            // Assert
            Assert.IsType<NotFoundResult>(result);
        }

        [Fact]
        public void GetUserReturnsViewResultWithUser()
        {
            // Arrange
            int testUserId = 1;
            var mock = new Mock<IRepository>();
            mock.Setup(repo => repo.Get(testUserId))
                .Returns(GetTestUsers().FirstOrDefault(p => p.Id == testUserId));
            var controller = new HomeController(mock.Object);

            // Act
            var result = controller.GetUser(testUserId);

            // Assert
            var viewResult = Assert.IsType<ViewResult>(result);
            var model = Assert.IsType<User>(viewResult.ViewData.Model);
            Assert.Equal("Tom", model.Name);
            Assert.Equal(35, model.Age);
            Assert.Equal(testUserId, model.Id);
        }
        */
    }
}