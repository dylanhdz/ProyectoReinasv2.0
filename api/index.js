import express  from "express";
import authRoutes from "./routes/auth.js"
import userRoutes from "./routes/users.js"
import postRoutes from "./routes/posts.js"
import comentRoutes from "./routes/coment.js"
import candidatasRoutes from "./routes/candidatas.js"
import caliRoutes from "./routes/cali.js"
import barraRoutes from "./routes/barra.js"
import cookieParser from "cookie-parser"
import multer from "multer";
import emailRoutes from "./routes/email.js";



const app = express()

app.use(express.json())
app.use(cookieParser())

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, '../client/public/upload')
    },
    filename: function (req, file, cb) {      
      cb(null, Date.now()+file.originalname)
    }
  })


const upload = multer({ storage })

app.post('/api/upload', upload.single('file'), function (req, res) {
    const file=req.file;

    res.status(200).json(file.filename)
  })


app.use("/api/auth",authRoutes)
app.use("/api/user",userRoutes)
app.use("/api/posts",postRoutes)
app.use("/api/coment",comentRoutes)
app.use("/api/cali",caliRoutes)
app.use("/api/candidatas",candidatasRoutes)
app.use("/api/barra",barraRoutes)
app.use("/api/email", emailRoutes);

app.listen(8800,()=>{
    console.log("Conectado puerto 8800!")
})