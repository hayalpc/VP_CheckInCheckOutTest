using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;
using VP_Data.Enums;

namespace VP_Data.Models
{
    public class Book
    {
        public long Id { get; set; }
        [Required]
        public DateTime CreateTime { get; set; }
        public DateTime ModifyTime { get; set; }

        [Required]
        public string Title { get; set; }
        [Required]
        public string ISBN { get; set; }
        [Required]
        public int PublishYear { get; set; }
        [Required]
        [Column(TypeName = "decimal(8,2)")]
        [DataType(DataType.Currency)]
        [DisplayFormat(DataFormatString = "{0:C0}", ApplyFormatInEditMode = true)]
        public decimal CoverPrice { get; set; }
        [Required]
        public BookStatus Status { get; set; }
        public long? CheckedOutUserId { get; set; }

        public CheckedOutUser CheckedOutUser { get; set; }
        public List<BookHistory> BookHistory { get; set; }
    }
}
