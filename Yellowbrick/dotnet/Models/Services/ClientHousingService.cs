using Sabio.Data.Providers;
using Sabio.Models.Requests;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Sabio.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.Reflection;
using Sabio.Services;
using Sabio.Models.Domain;
using Microsoft.AspNetCore.Mvc.Infrastructure;
using Sabio.Data;
using Microsoft.AspNetCore.Authentication;
using Sabio.Models.Domain.Lookups;
using Sabio.Services.ClientServices;

namespace Sabio.Services
{
    public class ClientHousingService : IClientHousingService
    {

        IDataProvider _data = null;
        IMapBaseUser _mapUser = null;
        IClientService _mapClient = null;
     
        public ClientHousingService(IDataProvider data, IMapBaseUser mapUser, IClientService mapClient)
        {
            _data = data;
            _mapUser = mapUser;
            _mapClient = mapClient;
         

        }

        public int Add(ClientHousingAddRequest model, int userId)
        {
            int id = 0;

            string procName = "[dbo].[ClientHousing_Insert]";

            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection collection)
            {
                AddCommonParams(model, userId, collection);

                SqlParameter idOut = new SqlParameter("@Id", SqlDbType.Int);
                idOut.Direction = ParameterDirection.Output;
                collection.Add(idOut);

            }, returnParameters: delegate (SqlParameterCollection returnCollection)
            {
                object oId = returnCollection["@Id"].Value;
                int.TryParse(oId.ToString(), out id);
            });

            return id;
        }

       

        public void Update(ClientHousingUpdateRequest request, int userId)
        {
            string procName = "[dbo].[ClientHousing_Update]";

            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection collection)
            {
                collection.AddWithValue("@ClientId", request.ClientId);
                collection.AddWithValue("@IsHomeOwner", request.IsHomeOwner);
                collection.AddWithValue("@IsRenter", request.IsRenter);
                collection.AddWithValue("@HasRentersInsurance", request.HasRentersInsurance);
                collection.AddWithValue("@RentPayment", request.RentPayment);
                collection.AddWithValue("@UserId", userId);
                collection.AddWithValue("@Id", request.Id);
            }, returnParameters: null);

        }

        public void Delete(int id)
        {
            string procName = "[dbo].[ClientHousing_Delete_ById]";

            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection collection)
            {
                collection.AddWithValue("@Id", id);
            }, returnParameters: null);
        }
        private static void AddCommonParams(ClientHousingAddRequest model, int userId, SqlParameterCollection collection)
        {
            collection.AddWithValue("@ClientId", model.ClientId);
            collection.AddWithValue("@IsHomeOwner", model.IsHomeOwner);
            collection.AddWithValue("@IsRenter", model.IsRenter);
            collection.AddWithValue("@HasRentersInsurance", model.HasRentersInsurance);
            collection.AddWithValue("@RentPayment", model.RentPayment.HasValue ? (object)model.RentPayment.Value : DBNull.Value);
            collection.AddWithValue("@UserId", userId);
        }

        public ClientHousing SingleRecordMapper(IDataReader reader, ref int startingIndex)
        {
            ClientHousing clientHousing = new ClientHousing();
            clientHousing.CreatedBy = new BaseUser();

            clientHousing.Id = reader.GetSafeInt32(startingIndex);
            clientHousing.Client = _mapClient.MapClientBase(reader, ref startingIndex);
            clientHousing.IsHomeOwner = reader.GetSafeBool(startingIndex);
            clientHousing.IsRenter = reader.GetSafeBool(startingIndex);
            clientHousing.HasRentersInsurance = reader.GetSafeBool(startingIndex);
            clientHousing.RentPayment = reader.GetSafeDecimal(startingIndex);
            clientHousing.CreatedBy = _mapUser.MapBaseUser(reader, ref startingIndex);
            clientHousing.DateCreated = reader.GetSafeDateTime(startingIndex++);
            clientHousing.DateModifed = reader.GetSafeDateTime(startingIndex++);


            return clientHousing;
           
        }


    }
}
