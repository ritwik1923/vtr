const express = require("express")
// const r = require("test")
const app = express()
const bodyParser = require("body-parser")
const path = require("path")
const multer = require("multer")
const imageToBase64 = require("image-to-base64")
const fs = require("fs")
// const Buffer = require("Buffer")
const { report } = require("process")

//################### Random #######################
function rand( minlimit ,  maxlimit) {
    let randomnum = Math.random() * (maxlimit - minlimit) + minlimit;
    return Math.floor(randomnum) 
}
// var ran =  rand(0,2);
// console.log("random :" + ran);
//###################Multer#######################
app.use(bodyParser.urlencoded({extended:true}))

var storage = multer.diskStorage({
    destination:function(req,file,cb) {
        cb(null,'pictures')
    },
    filename:function(req,file,cb) {
        cb(null,file.filename + '-' + Date.now() + path.extname(file.originalname))
    }
})

var upload = multer({
    storage:storage
})
//###################Database : Mongodb######################

const mongoClient = require("mongodb").MongoClient
const mongoUrl = "mongodb://localhost:27017"
global.db = ''
mongoClient.connect(mongoUrl,{
    useUnifiedTopology:true,useNewUrlParser:true
    },(err,res) => {
    if(err) {
        console.log("Datebase error "+err);
        return
    }
    db = res.db("TVR")
    dbshoping = res.db("shoplist")
    console.log("Datebase listening...");
})

//###################Posting#######################
function base64_encode(file) {
    // read binary data
    var bitmap = fs.readFileSync(file);
    // convert binary data to base64 encoded string
    return new Buffer(bitmap).toString('base64');
}
// const rPostUser = require(path.join(__dirname,"route","user","post-users.js"))
// app.post("/users", rPostUser)
app.post("/users", upload.single('picture'),(req,res) => {
    var img = fs.readFileSync(req.file.path)
    // var encode_image = img.toString('base64')
    // console.log(pictureName)
    var base64str = base64_encode(req.file.path)
    console.log(base64str.substring(0,30));
    //define a JSON object for image
    var finalImg = {
        contentType:req.file.mimetype,
        path:req.file.path,
        status:"uploaded",
        minx: 7,
        miny: 7,
        maxx: 70,
        maxy: 70,
        image:base64str 

        // new Buffer(encode_image,'base64')
    };
    //inserting to mongodb to the database
    // db.collection("users").insertOne(finalImg,(err,result) => {
    db.collection("users").insertOne(finalImg,(err,result) => {
        if(err) {
            console.log("cant upload Image");
            return
        }
        // console.log("Image uploaded to Mongodb Database "+finalImg);
        console.log("Image uploaded  "+finalImg);
        
        // res.contentType(finalImg.contentType)
        res.send(finalImg);
        
    })
})
//###################Posting in new cloths#######################
function base64_encode(file) {
    // read binary data
    var bitmap = fs.readFileSync(file);
    // convert binary data to base64 encoded string
    return new Buffer(bitmap).toString('base64');
}

app.post("/items", upload.single('picture'),(req,res) => {
    var img = fs.readFileSync(req.file.path)

    var base64str = base64_encode(req.file.path)
    console.log(base64str.substring(0,30));
    //define a JSON object for image
    var finalImg = {
        contentType:req.file.mimetype,
        path:req.file.path,
        status:rand(0,2),
        price:rand(450,2000),
        image:base64str 
    };
    //inserting to mongodb to the database
    // db.collection("users").insertOne(finalImg,(err,result) => {
    dbshoping.collection("cloths").insertOne(finalImg,(err,result) => {
        if(err) {
            console.log("cant upload Image");
            return
        }
        // console.log("Image uploaded to Mongodb Database "+finalImg);
        console.log("Image uploaded  "+finalImg);
        
        // res.contentType(finalImg.contentType)
        res.send(finalImg);
        
    })
})
//###################Get all data#######################
app.get("/allData",(req,res) => {
    
    
    dbshoping.collection("cloths").find({}).toArray(function(err, result) {
        if (err) throw err;
        console.log("Data Sended  ");
        
        console.log("res  "+result.contentType);
        res.json(result);
        // db.close();
    });
})

//###################Listening#######################

app.listen(80, err => {
    if(err){
        console.log("server error");
        return
    }
    console.log("server listening...")
})