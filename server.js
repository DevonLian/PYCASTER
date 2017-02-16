var http = require('http');
var fs = require('fs');
var sys = require('sys');
var exec = require('child_process').exec;


// Chargement du fichier index.html affiché au client
var server = http.createServer(function(req, res) {
    fs.readFile('./index.html', 'utf-8', function(error, content) {
        res.writeHead(200, {"Content-Type": "text/html"});
        res.end(content);
    });
});

// Chargement de socket.io
var io = require('socket.io').listen(server);

io.sockets.on('connection', function (socket, pseudo) {

    	socket.on('url', function(url_read) {
      	socket.url = url_read;
	exec("omxplayer  -o hdmi $(youtube-dl -g -f mp4 '" + socket.url + "') &");
	});	

	socket.on('url_nyt', function(url_read_nyt) {
        socket.url = url_read_nyt;
        exec("omxplayer  -o hdmi $(youtube-dl -g '" + socket.url + "') &");
        });

	socket.on('kill', function(kill_omx) {
        exec("killall omxplayer.bin");
    });


});



server.listen(8080);
