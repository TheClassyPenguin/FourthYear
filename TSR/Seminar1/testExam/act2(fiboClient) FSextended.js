//TSR

/* Act2 Seminar 1 Client */

var net = require('net')
var fs = require('fs')
if(process.argv.length != 4){
	console.log('This client must be invoked providing two arguments: the identifier of the function to be computed and its input value. Thus, a valid call would be: node client fibo 32. And a wrong call would be: node client fact.')
	process.exit(0)
}

var funcT = process.argv[3]
var numbT = parseInt(process.argv[4])
var obj = {'func': funcT, 'numb':numbT}
var obj2
fs.readFile('./input','utf8', function(err, data){

	if(err){
		return console.log(err)
	}
	obj2 = JSON.parse(data.toString())
})


var client = net.connect({port:9000}, function(){
	client.write(JSON.stringify(obj))
	client.write(JSON.stringify(obj2))
})

client.on('data', function(data){
	console.log(data.toString())
	client.end()
})

client.on('end',function(){
	console.log('client disconnected')
})