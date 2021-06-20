function rand( minlimit ,  maxlimit) {
    let randomnum = Math.random() * (maxlimit - minlimit) + minlimit;
    return Math.floor(randomnum) 
}
var ran =  rand(0,1);
console.log("random :" + ran);