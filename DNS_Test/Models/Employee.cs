using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace DNS_Test.Models
{
    public class Employee
    {
        [Required] [Display(Name = "Номер")] public int Id { get; set; }
        [Required] [Display(Name = "Ф.И.О.")] public string Name { get; set; }
        [Required] [Display(Name = "Отдел")] public Department Department { get; set; } 
        [Required] [Display(Name = "Должность")] public string Post { get; set; }
        [Required] [Display(Name = "Дата устройства")] [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")] public DateTime Date { get; set; }
        [Display(Name = "Руководитель")] public Employee Chief { get; set; }
    }
}
