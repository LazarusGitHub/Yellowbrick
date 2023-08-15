using Sabio.Models.Domain;
using Sabio.Models.Requests;
using System.Collections.Generic;

namespace Sabio.Services.Interfaces
{
    public interface IShortTermDebtService
    {
        int Add(ShortTermDebtAddRequest model, int userId);
        void BatchInsert(ShortTermDebtBatchAddRequest request, int userId);
        void Delete(int id);
        List<ShortTermDebt> Select_ByClientId(int id);
        void Update(ShortTermDebtUpdateRequest request, int userId);
    }
}