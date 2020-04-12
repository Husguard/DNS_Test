using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using DNS_Test.Models;
using System.Text;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace DNS_Test.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly ConnectionContext context;
        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
            context = new ConnectionContext();
        }

        public IActionResult Index()
        {
            _logger.LogInformation("Downloading /Home/Index");
            return View();
        }
        public JsonResult GetPage(int pages)
        {
            _logger.LogInformation("Getting number of pages in database");
            int value = context.GetPage(pages);
            _logger.LogInformation("Return number of pages: {0}", value);
            return Json(value);
        }
        public JsonResult GetSuggests(string name)
        {
            dynamic value = context.GetSuggests(name);
            return Json(value);
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
        [HttpGet]
        public IActionResult ShowEmployees(int page, int selected, bool sort, bool column)
        {
            _logger.LogInformation("Getting №{0} page of employees, size {1}", page, selected);
            List<Employee> result = context.GetEmployees(page - 1, selected, sort, column).ToList();
            _logger.LogInformation("Return page of employees size {0}", result.Count);
            return PartialView(result);
        }
        [HttpPost]
        public IActionResult ShowChiefs(int Id)
        {
            _logger.LogInformation("Getting subordinates of №{0} employee", Id);
            List<Employee> result = context.ShowChiefs(Id);
            _logger.LogInformation("Return {0} subordinates", result.Count);
            return PartialView(result);
        }
        [HttpGet]
        public IActionResult AddEmployee()
        {
            ViewBag.Departments = new SelectList(context.GetDepartments(), "Id", "Name");
            return PartialView();
        }
        [HttpPost]
        public IActionResult AddEmployee(Employee adding) 
        {
            _logger.LogInformation("Adding a employee: {0}, {1}, {2}, {3}", adding.Name, adding.Department.Id, adding.Post, adding.Date.ToShortDateString());
            context.AddEmployee(adding);
            _logger.LogInformation("Employee is Added. Redirect to Index");
            return RedirectToAction("Index");
        }
        [HttpGet]
        public IActionResult DeleteEmployee(int Id)
        {
            return PartialView(context.FindEmployee(Id));
        }
        [HttpPost]
        public IActionResult DeleteEmployee(Employee model)
        {
            _logger.LogInformation("Deleting a employee: ID {0}", model.Id);
            context.DeleteEmployee(model.Id);
            _logger.LogInformation("Employee with ID {0} is deleted. Redirect to Index", model.Id);
            return RedirectToAction("Index");
        }
    }
}
