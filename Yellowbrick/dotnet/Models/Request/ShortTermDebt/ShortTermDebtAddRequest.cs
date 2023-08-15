﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Requests
{
    public class ShortTermDebtAddRequest
    {
        [Required, Range(1, Int32.MaxValue)]
        public int ClientId { get; set; }
        [Required, Range(1, Int32.MaxValue)]
        public int LoanTypeId { get; set; }
        public decimal? Balance { get; set; }
        public decimal? MonthlyPayments { get; set; }
        [Required, StringLength(100)]
        public string InstitutionName { get; set; }
        public decimal? InterestRate { get; set; }
    }
}
