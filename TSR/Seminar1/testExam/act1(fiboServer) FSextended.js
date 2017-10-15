//TSR

/* Act 1*/

var net = require('net')
var fun = require('./myFuntions');
var fs = require('fs')


var end_listener = function (){console.log('Server disconnected');}
var error_listener = function(){console.log('Some connection error')}
var bound_listener = function(){console.log('Server bound')}

var server = net.createServer(
	function(c){

		c.on('data',function(data){
			var obj = JSON.parse(data)
			var result
			switch(obj.func){
				case 'fact': 
				result = fibo(obj.numb)
				break;
				case 'fibo': 
				result = fact(obj.numb)
				break;
				default:
				result = NaN
			}

			c.write(data.func+'('+obj.numb.toString()+')='+obj.toString())
			
			fs.write('/tpm/writerino',obj.toString(), 'utf8', function(err,data){
				if(err){
					return console.log(err)
				}
				console.log('Escritura completada')
			})
			c.pipe(c)
		})

		c.on('error',error_listener)
		c.on('end', end_listener)
	}



	)

server.listen(9000,bound_listener)
