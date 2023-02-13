using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using VP_CheckInCheckOutTest.Models;
using VP_Data.Models;

namespace VP_CheckInCheckOutTest.Operations
{
    public interface IBookOperations
    {
        Result GetAll();
        Result Add(Book book);
        Result CheckIn(long id);
        Result CheckOut(long id,CheckOutRequest request);
        Result Update(long id,Book book);
        Result Detail(long id);
        Result Get(long id);
    }
}
