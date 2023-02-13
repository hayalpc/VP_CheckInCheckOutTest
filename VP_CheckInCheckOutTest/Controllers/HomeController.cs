using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using VP_CheckInCheckOutTest.Operations;

namespace VP_CheckInCheckOutTest.Controllers
{
    public class HomeController : Controller
    {
        private readonly IBookOperations bookOperations;

        public HomeController(IBookOperations bookOperations)
        {
            this.bookOperations = bookOperations;
        }

        public IActionResult Index()
        {
            var books = bookOperations.GetAll().Data;
            return View(books);
        }
    }
}
