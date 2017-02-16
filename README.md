# PYCASTER : An Open Source Chromecast alternative !

PYCASTER is a casting application for your Raspberry Pi. It creates an HTTP server on your Pi that will stream videos for you and output it on an external monitor. Plug your Pi to your TV/Screen, connect to your Pi through your browser, and stream !

PYCASTER uses omxplayer for optimal performances (hardware-acceleration) and youtube-dl to generate a stream that is piped into omxplayer. No data will be stored on your Pi, unless you want to.
Youtube-dl allows access to a wide range of websites : PYCASTER will support all youtube-dl supported websites. See : <a href="https://rg3.github.io/youtube-dl/supportedsites.html">Youtube-dl list of supported sites</a>

# INSTALL PYCASTER

Download the setup.sh file and run it (on your Pi) :

<pre><code>wget https://raw.githubusercontent.com/DevonLian/PYCASTER/master/setup.sh
chmod +x setup.sh
./setup.sh</code></pre>

Or git clone the repo and run the setup
<pre><code>git clone https://github.com/DevonLian/PYCASTER.git
chmod +x setup.sh
./setup.sh</code></pre>

PYCASTER's code is really simple and will run on almost any distro.

<b>WHAT TO EXPECT TO BE INSTALLED...</b>

python-dev python-pip nodejs npm youtube-dl lame mpg321


#Controlling your PYCASTER

<b>START / STOP </b>

Using the scripts :

<pre><code>pycaster.sh start
pycaster.sh stop</code></pre>

Manually :

<pre><code>node /path-to/PYCASTER/server.js</code></pre>

OR

<pre><code>forever start /path-to/PYCASTER/server.js</code></pre>

<pre><code>forever</code></pre> ensures that your script runs continuously

<b> STREAMING </b>

Everything can be done in a web browser:

Connect to your Pi in your Web Browser using its ip :
<blockquote>http://pi-ip:8080/</blockquote>

Stream YouTube Video: 
Just click on "Stream Youtube" and Copy/Paste the video URL

Close currently played video : 
Click on "Kill"

Stream any Youtube-dl supported website : 
Click on "Stream non-youtube" and Copy/Paste the video URL.

Tip : 
To bypass unsupported youtube-dl hint, you'll need to find the direct stream URL, and pass it to PYCASTER. 
Here's how to do it :
<a href="https://gist.github.com/flyswatter/7357098">Isolate Stream Url through Chromium/Chrome</a>

More to come !

<b>I WANT MORE COMMANDS!</b>

PYCASTER build is pretty simple, here's how to add new commands :
1). Edit index.html : 
Add a new button : 
<pre><code>\<p\>\<input type="button" value="BUTTON_NAME" id="BUTTON_ID" />\</p\></pre></code>

Create a message linked to that button :
<pre><code>$\('\#BUTTON_ID'\).click\(function \(\) \{
		var url = prompt\('Url to Stream :'\);  //Sample Code
		socket.emit\('url', url\);              //Ask for a prompt and sends its results to the server
    \}\)</pre></code>
    
2). Edit server.js

Create a function that is called when your button sent the user input
<pre><code>socket.on\('url', function\(url_read\) \{
      	socket\.url = url\_read;
	exec\("omxplayer  \-o hdmi $\(youtube\-dl \-g \-f mp4 '" \+ socket\.url \+ "') &"\);
	\}\);
