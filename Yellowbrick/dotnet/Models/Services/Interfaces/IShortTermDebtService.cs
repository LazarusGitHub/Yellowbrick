using Yellowbrick.Models.Domain;
using Yellowbrick.Models.Requests;
using System.Collections.Generic;

namespace Yellowbrick.Services.Interfaces
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
