import * as Yup from "yup";

const housingStatusSchema = Yup.object().shape({
  rentPayment: Yup.number().when("isRenter", {
    is: true,
    then: Yup.number().typeError("Must be a valid number"),

    otherwise: Yup.number().notRequired(),
  }),
});

export default housingStatusSchema;
