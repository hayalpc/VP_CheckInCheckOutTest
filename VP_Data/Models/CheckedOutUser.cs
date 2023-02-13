using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace VP_Data.Models
{
    public class CheckedOutUser
    {
        public long Id { get; set; }
        [Required]
        public DateTime CreateTime { get; set; }
        public DateTime ModifyTime { get; set; }

        [Required]
        [StringLength(32)]
        public string Name { get; set; }
        [Required]
        public string MobilePhoneNumber { get; set; }
        [Required]
        public long NationalId { get; set; }
        [Required]
        public DateTime CheckedOutTime { get; set; }
        [Required]
        public DateTime ReturnTime { get; set; }

    }
}
