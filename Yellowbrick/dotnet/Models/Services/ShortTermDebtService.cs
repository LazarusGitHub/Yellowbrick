using Yellowbrick.Models.Domain;
using Yellowbrick.Models.Requests;
using Yellowbrick.Services.Interfaces;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Yellowbrick.Models.Domain.Lookups;
using Yellowbrick.Data.Providers;
using Yellowbrick.Data;
using Yellowbrick.Services.ClientServices;
using System;

namespace Yellowbrick.Services
{

    public class ShortTermDebtsService : IShortTermDebtService
    {
        IDataProvider _data = null;
        IMapBaseUser _mapUser = null;
        IClientService _mapClient = null;
        public ShortTermDebtsService(IDataProvider data, IMapBaseUser mapUser, IClientService mapClient)
        {
            _data = data;
            _mapUser = mapUser;
            _mapClient = mapClient;
        }
        public void BatchInsert(ShortTermDebtBatchAddRequest model, int userId)
        {

            DataTable dt = null;

            if (model.Debts != null)
            {
                dt = MapModelToTable(model.Debts);

            }
            string procName = "[dbo].[ShortTermDebts_Batch_Insert]";

            if (dt != null)
            {
                _data.ExecuteNonQuery(procName, delegate (SqlParameterCollection collection)
                {
                    collection.AddWithValue("@batchDebts", dt);
                    collection.AddWithValue("@clientId", model.Id);
                    collection.AddWithValue("@Id", userId);
                }, null);
            }

        }
        public int Add(ShortTermDebtAddRequest model, int userId)
        {
            int id = 0;
            string procName = "[dbo].[ShortTermDebts_Insert]";

            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection collection)
            {
                AddCommonParams(model, collection, userId);

                SqlParameter idOut = new SqlParameter("@Id", SqlDbType.Int);
                idOut.Direction = ParameterDirection.Output;
                collection.Add(idOut);

            }, returnParameters: delegate (SqlParameterCollection returnCollection)
            {
                object oId = returnCollection["@Id"].Value;
                int.TryParse(oId.ToString(), out id);
            }
            );
            return id;
        }
        

        public void Update(ShortTermDebtUpdateRequest request, int userId)
        {
            string procName = "[dbo].[ShortTermDebts_Update]";

            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection collection)
            {
                AddCommonParams(request, collection, userId);
                collection.AddWithValue("@Id", request.Id);

            }, returnParameters: null);

        }
        public void Delete(int id)
        {
            string procName = "[dbo].[ShortTermDebts_Delete_ById]";

            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection collection)
            {
                collection.AddWithValue("@Id", id);

            }, returnParameters: null);

        }
        public List<ShortTermDebt> Select_ByClientId(int clientId)
        {
            string procName = "[dbo].[ShortTermDebts_Select_ByClientId]";

            List<ShortTermDebt> list = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection collection)
            {
                collection.AddWithValue("@ClientId", clientId);

            }, delegate (IDataReader reader, short set)
            {
                int startingIndex = 0;

                ShortTermDebt clientDebt = SingleRecordMapper(reader, ref startingIndex);

                if (list == null)
                {
                    list = new List<ShortTermDebt>();
                }
                list.Add(clientDebt);
            });
            return list;
        }
        public ShortTermDebt SingleRecordMapper(IDataReader reader, ref int startingIndex)
        {
            ShortTermDebt shortTermDebts = new ShortTermDebt();
            shortTermDebts.LoanType = new LookUp();
            shortTermDebts.CreatedBy = new BaseUser();

            shortTermDebts.Id = reader.GetSafeInt32(startingIndex++);
            shortTermDebts.Client = _mapClient.MapClientBase(reader, ref startingIndex);
            shortTermDebts.LoanType.Id = reader.GetSafeInt32(startingIndex++);
            shortTermDebts.LoanType.Name = reader.GetSafeString(startingIndex++);
            shortTermDebts.Balance = reader.GetSafeDecimalNullable(startingIndex++);
            shortTermDebts.MonthlyPayments = reader.GetSafeDecimalNullable(startingIndex++);
            shortTermDebts.InstitutionName = reader.GetSafeString(startingIndex++);
            shortTermDebts.InterestRate = reader.GetSafeDecimalNullable(startingIndex++);
            shortTermDebts.CreatedBy = _mapUser.MapBaseUser(reader, ref startingIndex);
            shortTermDebts.DateCreated = reader.GetSafeDateTime(startingIndex++);
            shortTermDebts.DateModified = reader.GetSafeDateTime(startingIndex++);
            return shortTermDebts;
        }

        private static void AddCommonParams(ShortTermDebtAddRequest model, SqlParameterCollection collection, int userId)
        {
            collection.AddWithValue("@ClientId", model.ClientId);
            collection.AddWithValue("@LoanTypeId", model.LoanTypeId);
            collection.AddWithValue("@Balance", model.Balance.HasValue ? (object)model.Balance.Value : DBNull.Value);
            collection.AddWithValue("@MonthlyPayments", model.MonthlyPayments.HasValue ? (object)model.MonthlyPayments.Value : DBNull.Value);
            collection.AddWithValue("@InstitutionName", model.InstitutionName);
            collection.AddWithValue("@InterestRate", model.InterestRate.HasValue ? (object)model.InterestRate.Value : DBNull.Value);
            collection.AddWithValue("@UserId", userId);
        }
        private DataTable MapModelToTable(List<ShortTermDebtBaseBatch> model)
        {
            DataTable table = new DataTable();

            table.Columns.Add("LoanTypeId", typeof(int));
            table.Columns.Add("Balance", typeof(decimal));
            table.Columns.Add("MonthlyPayment", typeof(decimal));
            table.Columns.Add("InstitutionName", typeof(string));
            table.Columns.Add("InterestRate", typeof(decimal));

            if (model == null || model.Count == 0)
            {
                return table;
            }

            foreach (ShortTermDebtBaseBatch element in model)
            {
                DataRow dr = table.NewRow();
                int i = 0;

                dr[i++] = element.LoanTypeId;
                dr[i++] = element.Balance.HasValue ? element.Balance.Value : (object)DBNull.Value;
                dr[i++] = element.MonthlyPayments.HasValue ? element.MonthlyPayments.Value : (object)DBNull.Value;
                dr[i++] = element.InstitutionName;
                dr[i++] = element.InterestRate.HasValue ? element.InterestRate.Value : (object)DBNull.Value;

                table.Rows.Add(dr);
            }
            return table;
        }

    }
}
