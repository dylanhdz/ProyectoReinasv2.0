import express from "express";
import {
  getAllRoles,
  createRole,
  updateRole,
  deleteRole,
  assignPermissionToRole,
  revokePermissionFromRole
} from "../controllers/roles.js";

const router = express.Router();

router.get("/", getAllRoles);
router.post("/", createRole);
router.put("/:id", updateRole);
router.delete("/:id", deleteRole);
router.post("/:roleName/features/:featureName", assignPermissionToRole);
router.delete("/:roleName/features/:featureName", revokePermissionFromRole);

export default router;
