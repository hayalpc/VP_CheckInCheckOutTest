using System;
using System.Collections.Generic;
using System.Text;
using VP_Data.Enums;

namespace VP_Data.Models
{
    public class BookHistory
    {
        public long Id { get; set; }
        public DateTime CreateTime { get; set; }
        public DateTime ModifyTime { get; set; }

        public long BookId { get; set; }
        public long CheckedOutUserId { get; set; }

        public BookStatus Status { get; set; }

        public Book Book { get; set; }
        public CheckedOutUser CheckedOutUser { get; set; }
    }
}
