import React from "react";
import { useFormik } from "formik";
import debug from "yellowbrick-debug";
import clientHousingService from "services/clientHousingService";
import toastr from "toastr";
import housingStatusSchema from "schemas/housingStatusSchema";
import PropTypes from "prop-types";

const _logger = debug.extend("HousingStatus");

function HousingStatus(props) {
  const formik = useFormik(
    {
    initialValues: props.isEdit && props.hasData ? 
    {
      clientId: props.clientId, // inherit clientId from props diff for view and stepper
      isHomeOwner: props.housing.isHomeOwner,
      isRenter: props.housing.isRenter,
      hasRentersInsurance: props.housing.hasRentersInsurance,
      rentPayment: props.housing.rentPayment,
    } 
      :
    {
      clientId: props.clientId,
      isHomeOwner: false,
      isRenter: false,
      hasRentersInsurance: false,
      rentPayment: "",
    },
    validationSchema: housingStatusSchema,

    onSubmit: (values) => {
      values.rentPayment = values.rentPayment || null;
      if(!onEditMode){
        clientHousingService
        .Add(values)
        .then(onSubmitSuccess)
        .then(props.giveHousingStatus(values))
        .catch(onSubmitError);
      } else {
        _logger("This is where the edit batch api call should be")
      }
    },
  });

  const onEditMode = props.isEdit

  const onSubmitSuccess = (response) => {
    _logger("Success", response);
    toastr.success("Housing Information Completed");
    props.onNext();
  };

  const onSubmitError = (err) => {
    _logger("Failed", err);
    // toastr.error("Failed to created a record", err.message);
  };

  return (
    <>
      <div className="py-6">
        <form
          className="card  p-3 mb-5 shadow-lg bg-white rounded col-11"
          onSubmit={formik.handleSubmit}
        >
          <div className="card-header">
            <h1>Housing Status</h1>
          </div>
          <div className="row align-items-center">
            <div className="pt-1 ">
              <div className="d-flex justify-content-start form-check-inline ">
                Do you currently own your home or rent? &nbsp;
                <div className=" mb-4">
                  <label>Own &nbsp;</label>
                  <input
                    type="checkbox"
                    name="isHomeOwner"
                    checked={formik.values.isHomeOwner}
                    onChange={formik.handleChange}
                    className="form-check-input border border-secondary"
                  />

                  <label className="form-check-label"> &nbsp;Rent &nbsp;</label>

                  <input
                    type="checkbox"
                    name="isRenter"
                    checked={formik.values.isRenter}
                    onChange={formik.handleChange}
                    className="form-check-input border border-secondary"
                  />
                </div>
              </div>
              {formik.values.isRenter && (
                <>
                  <div className="form-group">
                    <h5 className="fw-bold mt-3">If they rent:</h5>
                    <label className="d-flex align-items-center">
                      Around how much are you currently paying in rent?
                      <input
                        type="text"
                        style={{ marginLeft: 10 }}
                        name="rentPayment"
                        value={formik.values.rentPayment}
                        onChange={formik.handleChange}
                      />
                      {formik.touched.rentPayment &&
                      formik.errors.rentPayment ? (
                        <div className="text-danger ps-2">
                          {formik.errors.rentPayment}
                        </div>
                      ) : null}
                    </label>
                  </div>
                  <div className="d-flex justify-content-start align-items-center mt-2">
                    <p>Do you currently have renters insurance?</p>&nbsp;
                    <div className="form-check form-check-inline mb-3">
                      <input
                        className="form-check-input border border-secondary"
                        type="checkbox"
                        name="hasRentersInsurance"
                        checked={formik.values.hasRentersInsurance}
                        onChange={formik.handleChange}
                      />
                    </div>
                  </div>
                </>
              )}
              <div className="">
                {!props.isInStepper && (
                  <button type="submit" className="btn btn-primary float-end">
                    Submit
                  </button>
                )}
                {props.isInStepper && (
                  <div>
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
              </div>
            </div>
          </div>
        </form>
      </div>
    </>
  );
}
HousingStatus.propTypes = {
  clientId: PropTypes.number,
  nextLabel: PropTypes.string,
  backLabel: PropTypes.string,
  onNext: PropTypes.func,
  onBack: PropTypes.func,
  isInStepper: PropTypes.bool,
    giveHousingStatus: PropTypes.func,
    isEdit: PropTypes.bool,
    hasData: PropTypes.bool,
    housing: PropTypes.shape({
        clientId: PropTypes.string,
        isHomeOwner: PropTypes.bool,
        isRenter: PropTypes.bool,
        hasRentersInsurance: PropTypes.bool,
        rentPayment: PropTypes.number
    })
};
export default HousingStatus;
