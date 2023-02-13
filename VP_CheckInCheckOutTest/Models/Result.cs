using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace VP_CheckInCheckOutTest.Models
{
    public class Result
    {
        public ResultCodes ResultCode { get; set; }
        public string ResultMessage { get; set; }
        public bool IsSuccess { get { return ResultCode == ResultCodes.SUCCESS; } }
        public object Data { get; set; }
    }
}
