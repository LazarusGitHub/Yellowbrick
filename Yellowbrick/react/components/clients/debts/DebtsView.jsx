import React, { useState, useEffect } from "react";
import PropTypes from "prop-types";
import shortTermDebtService from "services/shortTermDebtService";
import debug from "sabio-debug";
import { Table } from "react-bootstrap";
import commonFormater from "utils/commonFormater";
import { FaEdit } from "react-icons/fa";

const _logger = debug.extend("DebtsView");
const DebtsView = ({ id }) => {
  //original passed the {id}
  //   useEffect(make axios call with id and setState)
  const [debts, setDebts] = useState([]);

  useEffect(() => {
    shortTermDebtService.GetById(id).then(onDebtsSuccess).catch(onError);
  }, [id]);

  const onDebtsSuccess = (response) => {
    _logger(response, "Success Response");
    setDebts(response.items);
  };
  const mapDebts = (debts, index) => {
    return (
      <tr key={`debts_map${index}`}>
        <td>{index + 1}</td>
        <td>{debts.loanType.name}</td>
        <td>
          {debts.balance !== null
            ? commonFormater.formatUsd(debts.balance)
            : "N/A"}
        </td>
        <td>
          {debts.monthlyPayments !== null
            ? commonFormater.formatUsd(debts.monthlyPayments)
            : "N/A"}
        </td>
        <td>
          {debts.interestRate !== null
            ? commonFormater.formatUsd(debts.interestRate)
            : "N/A"}
        </td>
        <td>{debts.institutionName}</td>
      </tr>
    );
  };
  const onError = (error) => {
    _logger(error, "Error Response");
  };
  const total = debts.reduce(
    (acc, debt) => {
      acc.totalBalance += debt.balance || 0;
      acc.totalMonthlyPayments += debt.monthlyPayments || 0;
      return acc;
    },
    { totalBalance: 0, totalMonthlyPayments: 0 }
  );

  return (
    <>
      <div className="row">
        <div className="d-flex justify-content-between">
        <div className="col-auto">
          <h3 className="mb-1 ms-3 fw-bold pt-3 pb-2">Debts</h3>
        </div>
        <div className="col d-flex align-items-center align-middle p-0">
            <FaEdit
              className="h3 m-0 ms-3"
              cursor={"pointer"}
            />
        </div>
        </div>
        

        <div className="col d-flex align-items-center"></div>
        {debts.length > 0 ? (
          <>
            <div className="table-responsive">
              <Table bordered hover className="text-wrap text-center">
                <thead className="table-primary">
                  <tr className="align-middle">
                    <th scope="col" style={{ width: "20px" }}>
                      #
                    </th>
                    <th scope="col" className="col-2">
                      Loan Type
                    </th>
                    <th scope="col">Current Balance</th>
                    <th scope="col">Monthly Payment</th>
                    <th scope="col">Interest Rate</th>
                    <th scope="col">Institution Name</th>
                  </tr>
                </thead>
                <tbody className="table-light">
                  {debts.map(mapDebts)}
                  <tr className="border border-0">
                    <td
                      colSpan="2"
                      className="text-start fw-bold border border-secondary-subtle"
                    >
                      Total:{" "}
                    </td>
                    <td className="fw-bold border border-secondary-subtle">
                      {commonFormater.formatUsd(total.totalBalance)}
                    </td>
                    <td className="fw-bold border border-secondary-subtle">
                      {commonFormater.formatUsd(total.totalMonthlyPayments)}
                    </td>
                  </tr>
                </tbody>
              </Table>
            </div>
          </>
        ) : (
          <div style={{ textAlign: "center", margin: "20px" }}>
            <h3>No Liability Information Available.</h3>
          </div>
        )}
      </div>
    </>
  );
};

// map debts

DebtsView.propTypes = {
  id: PropTypes.string.isRequired,
};

export default DebtsView;
