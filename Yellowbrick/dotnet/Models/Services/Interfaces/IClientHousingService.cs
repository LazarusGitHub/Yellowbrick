using Yellowbrick.Models.Requests;
using System.Collections.Generic;

namespace Yellowbrick.Services.Interfaces
{
    public interface IClientHousingService
    {
        int Add(ClientHousingAddRequest model, int userId);
        void Update(ClientHousingUpdateRequest model, int userId);
        void Delete(int id);
    }
}
