using Yellowbrick.Models.Domain.Lookups;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Yellowbrick.Models.Domain
{
    public class ShortTermDebt
    {
        public int Id { get; set; }
        public ClientBase Client { get; set; }
        public LookUp LoanType { get; set; }
        public decimal? Balance { get; set; }
        public decimal? MonthlyPayments { get; set; }
        public string InstitutionName { get; set; }
        public decimal? InterestRate { get; set; }
        public BaseUser CreatedBy { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }
    }
}
