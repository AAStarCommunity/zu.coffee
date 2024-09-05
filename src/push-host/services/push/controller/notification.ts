import { Request, Response, Router } from "express";
import { createResponse } from "../model/response";
import { asyncHandler } from "../../middleware/errorHandler";
import { NotifyRequest } from "../model/notify";
import { Notify } from "../service/notify";

const router = Router();

router.post(
  "/notification",
  asyncHandler(async (req: Request<{}, {}, NotifyRequest>, res: Response) => {
    await Notify(req.body.message, req.body.address);
    const response = createResponse(
      200,
      false,
      "Send notification successfully",
    );
    res.json(response);
  }),
);

export default router;
