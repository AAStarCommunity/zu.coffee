import express, { Request, Response } from "express";
import config from "./config";
import broadcaster from "./services/push/controller/broadcaster";
import { errorHandler } from "./services/middleware/errorHandler";

const app = express();
const port = config.port;

app.use(express.json());

app.use(errorHandler);

app.use("/api", broadcaster);

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
