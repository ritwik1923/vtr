const formidable = require("formidable")
const detect = require("detect-file-type")
const {v1 : uuidv1} = require("uuid")
const fs = require("fs")
const path = require("path")
// const { Db } = require("mongodb")



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
          try {
              // throw new Error('error!');
              resolve(dataToSend);
            } catch (e) {
  
              console.error("taking longer time");
            }
          
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
      try{
      var store_final_image = await vtr(cloth, face);
      var base64str1 = base64_encode(store_final_image);
      status = "good"
      console.log("store: ", store_final_image);
      }
      catch(e) {
          //error handling logic
          store_final_image = req.file.path
          base64str1 = base64str
          status = "bad"
  
      }
      //define a JSON object for image
      var finalImg = {
        contentType: "image/png",
        path: store_final_image,
        status: status,
        minx: 7,
        miny: 7,
        maxx: 70,
        maxy: 70,
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
  
// module.exports = (req,res) => {
//     const form = new formidable.IncomingForm()
//     form.parse(req,(err,fields,files) =>{
//         if(err) {
//             return res.send("Error in files")
//         }
//         detect.fromFile(files.picture.path,(err,result) =>   {
//             const pictureName = uuidv1()+"."+result.ext
//             const allowedImageTypes = ["jpg","jpeg","png"]
//             if(!allowedImageTypes.includes(result.ext)) {
//                 res.send("Image Type is not allowed!!!...")
//             }
//             const oldPath = files.picture.path
//             const currentPath = path.join(__dirname,"..","..","pictures",pictureName)
//             fs.rename(oldPath,currentPath,err => {
//                 if(err) {
//                    console.log("cannont move file");
//                    return

//                 }
//                 console.log(oldPath)
//                 console.log(pictureName)
//                 const user = {"picture":pictureName}
//                 db.collection("users").insertOne(user,(err,dbResponse) => {
//                     if(err) {
//                         console.log("cant upload Image");
//                         return
//                     }
//                     res.send("do in $currentPath")
// //###################Send data back when everything is okay#######################
//                     // res.sendFile(currentPath)
//                 })
//             })
//         })
//         // console.log(files.picture.name)
//     })
// }