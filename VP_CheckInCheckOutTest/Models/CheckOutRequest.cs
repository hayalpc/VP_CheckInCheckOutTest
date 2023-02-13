using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using VP_Data.Models;

namespace VP_CheckInCheckOutTest.Models
{
    public class CheckOutRequest
    {
        [Required]
        [StringLength(32)]
        public string Name { get; set; }
        [Required]
        [DataType(DataType.PhoneNumber)]
        [Display(Name = "Mobile Phone Number")]
        [RegularExpression(@"^([0-9]{3})[ ]([0-9]{3})[ ][0-9]{4}$", ErrorMessage = "Entered mobile phone format is not valid.")]
        public string MobilePhoneNumber { get; set; }
        [Required]
        [RegularExpression(@"^[0-9]{11}$", ErrorMessage = "Entered National Id is not valid.")]
        public string NationalId { get; set; }
        //[Required]
        //public DateTime CheckedOutTime { get; set; }

        public Book Book { get; set; }
    }
}
