import { Request, Response, Router } from "express";
import { Broadcast } from "../service/broadcast";
import { BroadcastRequest } from "../model/broadcast";
import { createResponse } from "../model/response";
import { asyncHandler } from "../../middleware/errorHandler";
import { GetChannels } from "../service/get-channels";
import { GetSubscribers, IsSubscribeExists } from "../service/get-subscribers";

const router = Router();

router.get(
  "/channels",
  asyncHandler(async (req: Request, res: Response) => {
    const rlt = await GetChannels();
    const response = createResponse(200, false, rlt);
    res.json(response);
  }),
);

router.post(
  "/broadcast",
  asyncHandler(
    async (req: Request<{}, {}, BroadcastRequest>, res: Response) => {
      for (const channel of req.body.channels) {
        if (!IsSubscribeExists(channel)) {
          const response = createResponse(400, true, "Channel(" + channel + ") not found");
          res.json(response);
          return;
        }
      }
      const rlt = await Broadcast(req.body);
      const response = createResponse(200, false, rlt);
      res.json(response);
    },
  ),
);

export default router;
