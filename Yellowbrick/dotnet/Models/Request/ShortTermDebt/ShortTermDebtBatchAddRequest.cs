﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Yellowbrick.Models.Requests
{
    public class ShortTermDebtBatchAddRequest
    {
        [Required]
        public List<ShortTermDebtBaseBatch> Debts { get; set; }
        [Required, Range(1, int.MaxValue)]
        public int Id { get; set; }
    }
}
