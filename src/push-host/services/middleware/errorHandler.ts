import { Request, Response, NextFunction, RequestHandler } from "express";

export const errorHandler = (
  err: any,
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  console.error(err.stack);
  res.status(500).json({
    code: 500,
    error: true,
    msg: "Internal Server Error",
    data: null,
  });
};

export const asyncHandler =
  (fn: RequestHandler) => (req: Request, res: Response, next: NextFunction) => {
    Promise.resolve(fn(req, res, next)).catch(next);
  };
