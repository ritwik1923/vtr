const express = require("express");
// const r = require("test")
const app = express();
const bodyParser = require("body-parser");
const path = require("path");
const multer = require("multer");
const imageToBase64 = require("image-to-base64");
const fs = require("fs");
// for calling python method
const spawn = require("child_process").spawn;
// const Buffer = require("Buffer")
const { report } = require("process");

//################### Random #######################
function rand(minlimit, maxlimit) {
  let randomnum = Math.random() * (maxlimit - minlimit) + minlimit;
  return Math.floor(randomnum);
}
// var ran =  rand(0,2);
// console.log("random :" + ran);
//###################Multer#######################
app.use(bodyParser.urlencoded({ extended: true }));

var storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "pictures");
  },
  filename: function (req, file, cb) {
    cb(
      null,
      file.filename + "-" + Date.now() + path.extname(file.originalname)
    );
  },
});

var upload = multer({
  storage: storage,
});
//###################Database : Mongodb#######################

const mongoClient = require("mongodb").MongoClient;
const mongoUrl = "mongodb://localhost:27017";
global.db = "";
mongoClient.connect(
  mongoUrl,
  {
    useUnifiedTopology: true,
    useNewUrlParser: true,
  },
  (err, res) => {
    if (err) {
      console.log("Datebase error " + err);
      return;
    }
    db = res.db("TVR");
    dbshoping = res.db("shoplist");
    console.log("Datebase listening...");
  }
);

//###################Posting#######################
function base64_encode(file) {
  // read binary data
  var bitmap = fs.readFileSync(file);
  // convert binary data to base64 encoded string
  return new Buffer(bitmap).toString("base64");
}
// const rPostUser = require(path.join(__dirname,"route","user","post-users.js"))
// app.post("/users", rPostUser)
function delfile(path) {
    try {
        fs.unlinkSync(path)
        //file removed
      } catch(err) {
        console.error(err)
      }
}
function vtr(cloth, face) {
  const pythonProcess = spawn("python", ["merge_final.py", cloth, face]);
  // const pythonProcess = spawn('python',["demo.py",cloth,face]);
  // console.log("python respond: ",pythonProcess)
  pythonProcess.stdout.on("data", function (data) {
    dataToSend = data.toString();
    dataToSend = dataToSend.substr(2, dataToSend.length - 4);
    // dataToSend = "result1/undefined-1624450196020.png"

    // dataToSend = dataToSend.replace("/", "\\")
    console.log("Pipe data from python script ...", dataToSend);
    // return res.sendFile(dataToSend)
    // res.sendFile("~/images/adrian.jpg")
    // res.set({'Content-Type': '~/images/adrian.jpg'});
  });

  return new Promise((resolve) => {
      setTimeout(() => {
        // try {
            // throw new Error('error!');
            resolve(dataToSend);
          // } catch (e) {

          //   console.error("taking longer time");
          // }
        
    }, 8000);
}).catch(function(error) {
    
    resolve("longtime");
    
  
  });
}

async function postUser() {
  app.post("/users", upload.single("picture"), async (req, res) => {
    var img = fs.readFileSync(req.file.path);
    // var encode_image = img.toString('base64')
    console.log("pic name: ", req.file.path);
    var base64str = base64_encode(req.file.path);
    console.log(base64str.substring(0, 30));

    cloth = "./cloths/DM333.png";
    face = "./" + req.file.path;
    face = face.replace("\\", "/");

    console.log("face name: ", face);
    // cout<<"arnab is sexy";
    var store_final_image = await vtr(cloth, face);
    if(store_final_image != "longtime") {
    var base64str1 = base64_encode(store_final_image);
    status = "good"
    console.log("store: ", store_final_image);
    delfile(req.file.path)
    }
    else {
        //error handling logic
        store_final_image = req.file.path
        base64str1 = base64str
        status = "bad"
        
    }
    delfile(store_final_image)
    //define a JSON object for image
    var finalImg = {
      contentType: "image/png",
      path: store_final_image,
      status: status,
      // minx: 7,
      // miny: 7,
      // maxx: 70,
      // maxy: 70,
      image:base64str1

      // new Buffer(encode_image,'base64')
    };

    //inserting to mongodb to the database
    // db.collection("users").insertOne(finalImg,(err,result) => {
    // db.collection("users").insertOne(finalImg,(err,result) => {
    //     if(err) {
    //         console.log("cant upload Image");
    //         return
    //     }
    //     // console.log("Image uploaded to Mongodb Database "+finalImg);
    console.log("Image:  " + req.file.mimetype);

    //     // res.contentType(finalImg.contentType)

    // })
    res.send(finalImg);
  });
  //###################Posting in new cloths#######################
}
postUser();

function base64_encode(file) {
  // read binary data
  var bitmap = fs.readFileSync(file);
  // convert binary data to base64 encoded string
  return new Buffer(bitmap).toString("base64");
}
app.post("/items", upload.single("picture"), (req, res) => {
  var img = fs.readFileSync(req.file.path);

  var base64str = base64_encode(req.file.path);
  console.log(base64str.substring(0, 30));
  //define a JSON object for image
  var finalImg = {
    contentType: req.file.mimetype,
    path: req.file.path,
    status: rand(0, 2),
    price: rand(450, 2000),
    image: base64str,
  };
  //inserting to mongodb to the database
  // db.collection("users").insertOne(finalImg,(err,result) => {
  dbshoping.collection("cloths").insertOne(finalImg, (err, result) => {
    if (err) {
      console.log("cant upload Image");
      return;
    }
    // console.log("Image uploaded to Mongodb Database "+finalImg);
    console.log("Image uploaded  " + finalImg);

    // res.contentType(finalImg.contentType)
    res.send(finalImg);
  });
});
//###################Get all data#######################
app.get("/allData", (req, res) => {
  dbshoping
    .collection("cloths")
    .find({})
    .toArray(function (err, result) {
      if (err) throw err;
      console.log("Data Sended  ");

      console.log("res  " + result.contentType);
      res.json(result);
      // db.close();
    });
});

//###################Listening#######################

app.listen(80, (err) => {
  if (err) {
    console.log("server error");
    return;
  }
  console.log("server listening...");
});

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
