using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class ClientHousing
    {
    
        public int Id { get; set; }
        public ClientBase Client { get; set; }
     
        public bool IsHomeOwner { get; set; }
    
        public bool IsRenter { get; set; }
    
        public bool HasRentersInsurance { get; set; }
    
        public decimal? RentPayment { get; set; }
        public List<Mortgage> Mortgages { get; set; }
        public BaseUser CreatedBy { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModifed { get; set; }
    }
}
