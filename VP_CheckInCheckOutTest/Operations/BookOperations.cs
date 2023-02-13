using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using VP_CheckInCheckOutTest.Models;
using VP_Core;
using VP_Data.Contexts;
using VP_Data.Enums;
using VP_Data.Models;
using VP_Data.Repositories;

namespace VP_CheckInCheckOutTest.Operations
{
    public class BookOperations : IBookOperations
    {
        private readonly IBaseUnitOfWork unitOfwork;
        private readonly IRepository<Book> bookRepository;
        private readonly IRepository<CheckedOutUser> checkedOutUserRepository;
        private readonly IRepository<BookHistory> bookHistoryRepository;

        public BookOperations(IBaseUnitOfWork unitOfwork, IRepository<Book> bookRepository, IRepository<CheckedOutUser> checkedOutUserRepository, IRepository<BookHistory> bookHistoryRepository)
        {
            this.unitOfwork = unitOfwork;
            this.bookRepository = bookRepository;
            this.checkedOutUserRepository = checkedOutUserRepository;
            this.bookHistoryRepository = bookHistoryRepository;
        }

        public Result Get(long id)
        {
            return new Result
            {
                ResultCode = ResultCodes.SUCCESS,
                Data = bookRepository.GetQuery(x => x.Id == id).Include(x => x.CheckedOutUser).Include(x => x.BookHistory).ThenInclude(x => x.CheckedOutUser).FirstOrDefault()
            };
        }

        public Result GetAll()
        {
            var activeStatuses = new List<BookStatus> {
                BookStatus.ACTIVE,
                BookStatus.CHECKOUT,
                BookStatus.CHECKIN,
            };
            return new Result
            {
                ResultCode = ResultCodes.SUCCESS,
                Data = bookRepository.GetQuery(x => activeStatuses.Contains(x.Status)).OrderByDescending(x => x.Status == BookStatus.ACTIVE).ThenBy(x => x.Title).ToList()
            };
        }

        public Result CheckOut(long id, CheckOutRequest request)
        {
            unitOfwork.BeginTransaction();
            try
            {
                var bookResult = Get(id);
                if (bookResult.IsSuccess)
                {
                    var book = bookResult.Data as Book;
                    if (book.Status == BookStatus.ACTIVE)
                    {
                        request.Book = book;
                        var checkedOutUser = new CheckedOutUser
                        {
                            CreateTime = DateTime.Now,
                            Name = request.Name,
                            MobilePhoneNumber = request.MobilePhoneNumber,
                            NationalId = long.Parse(request.NationalId),
                            CheckedOutTime = DateTime.Now,
                            ReturnTime = DateTime.Now.AddDays(15),
                        };
                        checkedOutUserRepository.Insert(checkedOutUser);
                        unitOfwork.SaveChanges();

                        var bookHistory = new BookHistory
                        {
                            BookId = book.Id,
                            CheckedOutUserId = checkedOutUser.Id,
                            CreateTime = DateTime.Now,
                            Status = BookStatus.CHECKOUT,
                        };
                        bookHistoryRepository.Insert(bookHistory);
                        unitOfwork.SaveChanges();

                        book.CheckedOutUserId = checkedOutUser.Id;
                        book.Status = BookStatus.CHECKOUT;
                        book.ModifyTime = DateTime.Now;
                        bookRepository.Update(book);

                        unitOfwork.SaveChanges();
                        unitOfwork.CommitTransaction();

                        return new Result { ResultCode = ResultCodes.SUCCESS };
                    }
                    else
                    {
                        return new Result { ResultCode = ResultCodes.FAIL, ResultMessage = "BOOK_STATUS_NOT_SUITABLE" };
                    }
                }
                else
                {
                    return bookResult;
                }
            }
            catch (Exception exp)
            {
                unitOfwork.RollBackTransaction();
                return new Result { ResultCode = ResultCodes.FAIL, ResultMessage = "Exp: " + exp.Message };
            }
        }

        public Result CheckIn(long id)
        {
            unitOfwork.BeginTransaction();
            try
            {
                var bookResult = Get(id);
                if (bookResult.IsSuccess)
                {
                    var book = bookResult.Data as Book;
                    if (book.Status == BookStatus.CHECKOUT)
                    {
                        var bookHistory = new BookHistory
                        {
                            BookId = book.Id,
                            CheckedOutUserId = book.CheckedOutUserId ?? 0,
                            CreateTime = DateTime.Now,
                            Status = BookStatus.CHECKIN,
                        };
                        bookHistoryRepository.Insert(bookHistory);

                        book.CheckedOutUserId = null;
                        book.Status = BookStatus.ACTIVE;
                        book.ModifyTime = DateTime.Now;

                        bookRepository.Update(book);

                        unitOfwork.SaveChanges();
                        unitOfwork.CommitTransaction();
                        return new Result { ResultCode = ResultCodes.SUCCESS };
                    }
                    else
                    {
                        return new Result { ResultCode = ResultCodes.FAIL, ResultMessage = "BOOK_STATUS_NOT_SUITABLE" };
                    }
                }
                else
                {
                    return bookResult;
                }
            }
            catch (Exception exp)
            {
                unitOfwork.RollBackTransaction();
                return new Result { ResultCode = ResultCodes.FAIL, ResultMessage = "Exp: " + exp.Message };
            }
        }

        public Result Add(Book book)
        {
            try
            {
                book.CreateTime = DateTime.Now;
                book.Status = VP_Data.Enums.BookStatus.ACTIVE;

                bookRepository.Insert(book);
                unitOfwork.SaveChanges();
                return new Result { ResultCode = ResultCodes.SUCCESS };
            }
            catch (Exception exp)
            {
                return new Result { ResultCode = ResultCodes.FAIL, ResultMessage = "Exp: " + exp.Message };
            }
        }

        public Result Detail(long id)
        {
            try
            {
                var data = bookRepository.GetById(id);
                if (data == null)
                    return new Result { ResultCode = ResultCodes.FAIL, ResultMessage = "RECORD_NOT_FOUND" };
                return new Result { ResultCode = ResultCodes.SUCCESS, Data = data };
            }
            catch (Exception exp)
            {
                return new Result { ResultCode = ResultCodes.FAIL, ResultMessage = "Exp: " + exp.Message };
            }
        }

        public Result Update(long id, Book book)
        {
            try
            {
                var data = bookRepository.GetById(id);
                if (data == null)
                    return new Result { ResultCode = ResultCodes.FAIL, ResultMessage = "RECORD_NOT_FOUND" };

                data.ModifyTime = DateTime.Now;
                data.Title = book.Title;
                data.ISBN = book.ISBN;
                data.PublishYear = book.PublishYear;
                data.CoverPrice = book.CoverPrice;

                bookRepository.Update(data);
                unitOfwork.SaveChanges();
                return new Result { ResultCode = ResultCodes.SUCCESS };
            }
            catch (Exception exp)
            {
                return new Result { ResultCode = ResultCodes.FAIL, ResultMessage = "Exp: " + exp.Message };
            }
        }

    }
}
