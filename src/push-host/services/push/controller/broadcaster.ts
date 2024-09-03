import { Request, Response, Router } from "express";
import { Broadcast } from "../service/broadcast";
import { BroadcastRequest } from "../model/broadcast";
import { createResponse } from "../model/response";
import { asyncHandler } from "../../middleware/errorHandler";

const router = Router();

router.get("/", (req: Request, res: Response) => {
  res.send("Hello World!");
});

router.post(
  "/broadcast",
  asyncHandler(
    async (req: Request<{}, {}, BroadcastRequest>, res: Response) => {
      const rlt = await Broadcast(req.body);
      const response = createResponse(200, false, rlt);
      res.json(response);
    },
  ),
);

export default router;
