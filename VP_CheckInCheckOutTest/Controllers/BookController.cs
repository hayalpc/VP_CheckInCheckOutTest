using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using VP_CheckInCheckOutTest.Models;
using VP_CheckInCheckOutTest.Operations;
using VP_Data.Models;

namespace VP_CheckInCheckOutTest.Controllers
{
    public class BookController : Controller
    {
        private readonly IBookOperations bookOperations;

        public BookController(IBookOperations bookOperations)
        {
            this.bookOperations = bookOperations;
        }

        public IActionResult Index()
        {
            var books = (bookOperations.GetAll().Data as List<Book>).OrderBy(x=>x.Title).ToList();
            return View(books); 
        }

        public IActionResult Detail(long id)
        {
            var bookResult = bookOperations.Get(id);
            return View(bookResult.Data);
        }

        public IActionResult CheckOut(long id)
        {
            var bookResult = bookOperations.Get(id);
            if (bookResult.IsSuccess && (bookResult.Data as Book).Status == VP_Data.Enums.BookStatus.ACTIVE)
            {
                var checkoutRequest = new CheckOutRequest
                {
                    Book = bookResult.Data as Book,
                };
                return View(checkoutRequest);
            }
            else
            {
                return Redirect("/");
            }
        }

        public IActionResult CheckIn(long id)
        {
            var bookResult = bookOperations.Get(id);
            if (bookResult.IsSuccess && (bookResult.Data as Book).Status == VP_Data.Enums.BookStatus.CHECKOUT)
            {
                return View(bookResult.Data);
            }
            else
            {
                return Redirect("/");
            }
        }

        [HttpPost]
        [AutoValidateAntiforgeryToken]
        public IActionResult CheckIn(long id, [FromForm] string action)
        {
            var result = bookOperations.CheckIn(id);
            if (result.IsSuccess)
                return Ok();
            return BadRequest();
        }

        [HttpPost]
        [AutoValidateAntiforgeryToken]
        public IActionResult CheckOut(long id, CheckOutRequest request)
        {
            if (ModelState.IsValid)
            {
                var result = bookOperations.CheckOut(id, request);
                if (result.IsSuccess)
                {
                    return Ok();
                }
                else if (result.ResultMessage.Equals("RECORD_NOT_FOUND") || result.ResultMessage.Equals("BOOK_STATUS_NOT_SUITABLE"))
                {
                    return BadRequest();
                }
            }
            return BadRequest();
        }

        public IActionResult Add()
        {
            return View(new Book());
        }

        [HttpPost]
        [AutoValidateAntiforgeryToken]
        public IActionResult Add(Book book)
        {
            if (ModelState.IsValid)
            {
                var result = bookOperations.Add(book);
                if (result.IsSuccess)
                {
                    return Redirect("/");
                }
            }
            return View(book);
        }

        public IActionResult Edit(long id)
        {
            var bookResult = bookOperations.Get(id);
            if (bookResult.IsSuccess)
            {
                return View("Add",bookResult.Data);
            }
            else
            {
                return Redirect("/");
            }
        }

        [HttpPost]
        [AutoValidateAntiforgeryToken]
        public IActionResult Edit(long id,Book book)
        {
            if (ModelState.IsValid)
            {
                var result = bookOperations.Update(id,book);
                if (result.IsSuccess)
                {
                    return Redirect("/book");
                }
            }
            return View("Add",book);
        }
    }
}
