using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class ClientPersonal: Client
    {
        public HouseHold Household { get; set; } 
    }
}
