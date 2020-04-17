using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace DNS_Test.Models
{
    public class Department
    {
        [Required] public int Id { get; set; }
        [Required] public string Name { get; set; }
    }
}
