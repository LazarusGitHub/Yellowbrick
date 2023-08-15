import React, { useState, useEffect } from "react";
import { Formik, Field, Form, ErrorMessage, FieldArray } from "formik";
import shortTermDebtSchema from "schemas/shortTermDebtSchema";
import shortTermDebtService from "services/shortTermDebtService";
import lookUpService from "services/lookUpService";
import debug from "sabio-debug";
import toastr from "toastr";
import { Table } from "react-bootstrap";
import PropTypes from "prop-types";

const _logger = debug.extend("ShortTermDebt");

function ShortTermDebt(props) {
  const defaultDebt = {
    loanTypeId: "",
    balance: "",
    monthlyPayments: "",
    institutionName: "",
    interestRate: "",
  };

  const client = {
    debts: [defaultDebt],
    id: props.clientId,
  };

  const [hasDebt, setHasDebt] = useState(false);

  const [lookUp, setLookUps] = useState({
    loanTypes: [],
    loanOptions: [],
  });

  useEffect(() => {
    lookUpService.lookUp(["LoanTypes"]).then(onLookUpSuccess).catch(onError);
  }, []);

  const onLookUpSuccess = (response) => {
    _logger(response);
    setLookUps((prevState) => {
      const look = { ...prevState };
      look.loanTypes = response.item.loanTypes;
      look.loanOptions = look.loanTypes.map(options);
      return look;
    });
  };

  const onSubmit = (values) => {
    let payload = { ...values };

    payload.debts = values.debts.map((defaultDebt) => ({
      ...defaultDebt,
      balance: defaultDebt.balance || null,
      monthlyPayments: defaultDebt.monthlyPayments || null,
      interestRate: defaultDebt.interestRate || null,
    }));

    shortTermDebtService
      .Add(payload)
      .then(onCreateShortTermDebtSuccess)
      .catch(onError);
    props.onNext();
  };

  const onCreateShortTermDebtSuccess = (response) => {
    _logger(response);
    toastr.success("Debts Added");
  };

  const onError = (err) => {
    _logger("Failed", err);
    toastr.error("Failed to created a record", err.message);
  };
  const options = (lookUp) => {
    return (
      <option key={lookUp.id} value={lookUp.id} className="text-dark">
        {lookUp.name}
      </option>
    );
  };

  return (
    <div className="py-6">
      <div className="row align-items-center">
        <div className="bg-white card">
          <div className="card-header">
            <h1>Short Term Debts</h1>
          </div>
          <div className="d-flex justify-content-start align-items-center mt-3">
            Do you currently have any debt in Car loans, credit cards, student
            loans, or Personal loans? &nbsp;
            <div className="form-check-inline mb-0">
              <input
                className="form-check-input border border-secondary"
                type="checkbox"
                name="hasDebt"
                checked={hasDebt}
                onChange={(e) => setHasDebt(e.target.checked)}
              />
            </div>
          </div>

        {hasDebt && (
          <Formik
            enableReinitialize={true}
            initialValues={client}
            validationSchema={shortTermDebtSchema}
            onSubmit={onSubmit}
          >
            {({ values }) => (
              <Form className="form-group">
                <Table responsive className="text-nowrap mt-4 ">
                  <thead className="table-primary">
                    <tr>
                      <th scope="col" className="border border-secondary">
                        #
                      </th>
                      <th scope="col" className="border border-secondary">
                        Loan Type
                      </th>
                      <th scope="col" className="border border-secondary">
                        Current Balance
                      </th>
                      <th scope="col" className="border border-secondary">
                        Monthly Payment
                      </th>
                      <th scope="col" className="border border-secondary">
                        Interest Rate
                      </th>
                      <th scope="col" className="border border-secondary">
                        Institution Name
                      </th>
                    </tr>
                  </thead>
                  <tbody className="">
                    <FieldArray
                      name="debts"
                      render={({ push, remove }) => (
                        <>
                          {values.debts.map((debts, index) => {
                            return (
                              <tr key={index}>
                                <th
                                  className="table-primary border border-secondary"
                                  scope="row"
                                >
                                  {index + 1}
                                </th>
                                <td className="p-1 border border-secondary">
                                  <Field
                                    as="select"
                                    name={`debts.${index}.loanTypeId`}
                                    className="form-select w-100 ps-3 py-2 text-dark "
                                  >
                                    <option value={""}>Select...</option>
                                    {lookUp.loanOptions}
                                  </Field>
                                  <ErrorMessage
                                    name={`debts.${index}.loanTypeId`}
                                    component="div"
                                    className="text-danger"
                                  />
                                </td>

                                  <td className="p-1 border border-secondary">
                                    <Field
                                      name={`debts.${index}.balance`}
                                      className="form-control w-100 ps-3 py-2"
                                      autoComplete="off"
                                    />

                                    <ErrorMessage
                                      name={`debts.${index}.balance`}
                                      component="div"
                                      className="text-danger"
                                    />
                                  </td>
                                  <td className="p-1 border border-secondary">
                                    <Field
                                      name={`debts.${index}.monthlyPayments`}
                                      className="form-control w-100 ps-3 py-2 "
                                    />
                                    <ErrorMessage
                                      name={`debts.${index}.monthlyPayments`}
                                      component="div"
                                      className="text-danger"
                                    />
                                  </td>

                                  <td className="p-1 border border-secondary">
                                    <Field
                                      name={`debts.${index}.interestRate`}
                                      className="form-control w-100 ps-3 py-2"
                                    />
                                    <ErrorMessage
                                      name={`debts.${index}.interestRate`}
                                      component="div"
                                      className="form-control"
                                    />
                                  </td>
                                  <td className="p-1 border border-secondary">
                                    <Field
                                      type="text"
                                      name={`debts.${index}.institutionName`}
                                      className="form-control w-100 ps-3 py-2"
                                    />
                                    <ErrorMessage
                                      name={`debts.${index}.institutionName`}
                                      component="div"
                                      className="text-danger"
                                    />
                                  </td>
                                  <td className="bg-white px-1">
                                    {index > 0 && (
                                      <button
                                        type="button"
                                        className="bg-white border-0"
                                        onClick={() => remove(index)}
                                      >
                                        <i className="fe fe-trash"></i>
                                      </button>
                                    )}
                                    {index + 1 === values.debts.length && (
                                      <button
                                        type="button"
                                        className="bg-white border-0"
                                        onClick={() => push(defaultDebt)}
                                      >
                                        <i className="fe fe-plus-circle"></i>
                                      </button>
                                    )}
                                  </td>
                                </tr>
                              );
                            })}
                          </>
                        )}
                      ></FieldArray>
                    </tbody>
                  </Table>

                  {!props.isInStepper && (
                    <button
                      className="btn btn-primary mt-3 float-end"
                      type="submit"
                    >
                      Submit
                    </button>
                  )}
                  {props.isInStepper && hasDebt && (
                    <div className="p-2">
                      <button
                        type="submit"
                        onClick={props.onBack}
                        className="btn btn-secondary me-3 mt-3"
                      >
                        {props.backLabel}
                      </button>
                      <button type="submit" className="btn btn-primary mt-3">
                        {props.nextLabel}
                      </button>
                    </div>
                  )}
                </Form>
              )}
            </Formik>
          )}
          {!hasDebt && props.isInStepper && (
            <div className="p-2">
              <button
                type="submit"
                onClick={props.onBack}
                className="btn btn-secondary me-3 mt-3"
              >
                {props.backLabel}
              </button>
              <button
                type="submit"
                className="btn btn-primary mt-3"
                onClick={props.onNext}
              >
                {props.nextLabel}
              </button>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
ShortTermDebt.propTypes = {
  clientId: PropTypes.number,
  nextLabel: PropTypes.string,
  backLabel: PropTypes.string,
  onNext: PropTypes.func,
  onBack: PropTypes.func,
  isInStepper: PropTypes.bool,
};
export default ShortTermDebt;
