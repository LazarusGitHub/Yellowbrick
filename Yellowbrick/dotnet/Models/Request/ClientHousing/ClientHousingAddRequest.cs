using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Yellowbrick.Models.Requests
{
    public class ClientHousingAddRequest
    {
        [Required, Range(1, Int32.MaxValue)]
        public int ClientId { get; set; }
        [Required]
        public bool IsHomeOwner { get; set; }
        [Required]
        public bool IsRenter { get; set; }
        [Required]
        public bool HasRentersInsurance { get; set; }
     
        public decimal? RentPayment { get; set; }

    }
}
