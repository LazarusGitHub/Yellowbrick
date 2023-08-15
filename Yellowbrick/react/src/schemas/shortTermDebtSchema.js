import * as Yup from "yup";

const shortTermDebtSchema = Yup.object().shape({
  debts: Yup.array().of(
    Yup.object().shape({
      loanTypeId: Yup.string().required("Loan Type ID is required"),
      balance: Yup.number()
        .min(0)
        .default(0)
        .nullable()
        .typeError("Balance must be a number greater than or equal to 0"),
      monthlyPayments: Yup.number()
        .min(0)
        .default(0)
        .nullable()
        .typeError(
          "Monthly payments must be a number greater than or equal to 0"
        ),
      institutionName: Yup.string()
        .max(100)
        .required("Institution name is required"),
      interestRate: Yup.number()
        .min(0)
        .default(0)
        .nullable()
        .typeError("Interest rate must be a number greater than or equal to 0"),
    })
  ),
  id: Yup.number()
    .required("Client ID is required")
    .positive("Client ID must be a positive number"),
});

export default shortTermDebtSchema;
