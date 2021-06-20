const formidable = require("formidable")
const detect = require("detect-file-type")
const {v1 : uuidv1} = require("uuid")
const fs = require("fs")
const path = require("path")
// const { Db } = require("mongodb")

module.exports = (req,res) => {
    const form = new formidable.IncomingForm()
    form.parse(req,(err,fields,files) =>{
        if(err) {
            return res.send("Error in files")
        }
        detect.fromFile(files.picture.path,(err,result) =>   {
            const pictureName = uuidv1()+"."+result.ext
            const allowedImageTypes = ["jpg","jpeg","png"]
            if(!allowedImageTypes.includes(result.ext)) {
                res.send("Image Type is not allowed!!!...")
            }
            const oldPath = files.picture.path
            const currentPath = path.join(__dirname,"..","..","pictures",pictureName)
            fs.rename(oldPath,currentPath,err => {
                if(err) {
                   console.log("cannont move file");
                   return

                }
                console.log(oldPath)
                console.log(pictureName)
                const user = {"picture":pictureName}
                db.collection("users").insertOne(user,(err,dbResponse) => {
                    if(err) {
                        console.log("cant upload Image");
                        return
                    }
                    res.send("do in $currentPath")
//###################Send data back when everything is okay#######################
                    // res.sendFile(currentPath)
                })
            })
        })
        // console.log(files.picture.name)
    })
}