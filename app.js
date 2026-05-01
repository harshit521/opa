import express from "express";
import axios from "axios";

const app = express();
app.use(express.json());

// Call OPA
async function checkAccess(input) {
  const response = await axios.post(
    "http://localhost:8181/v1/data/auth/allow",
    { input }
  );
  return response.data.result;
}

app.post("/course-access", async (req, res) => {
  try {
    const input = req.body;

    const allowed = await checkAccess(input);

    if (!allowed) {
      return res.status(403).json({ message: "Access Denied" });
    }

    res.json({ message: "Access Granted" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.listen(3000, () => {
  console.log("Server running on port 3000");
});