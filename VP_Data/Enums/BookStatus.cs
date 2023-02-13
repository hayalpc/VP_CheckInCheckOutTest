using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace VP_Data.Enums
{
    public enum BookStatus
    {
        [Display(Name="Inactive")]
        INACTIVE,
        [Display(Name="Active")]
        ACTIVE,
        [Display(Name= "Check Out")]
        CHECKOUT,
        [Display(Name= "Check In")]
        CHECKIN,
    }
}
