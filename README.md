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
Please note that if you have already installed youtube-dl on your Pi PYCASTER will delete it and install the latest version from the official repo.

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

# STREAMING

Everything can be done in a web browser:

Connect to your Pi in your Web Browser using its ip :
<blockquote>http://pi-ip:8080/</blockquote>

Stream YouTube Video: 
Just click on <blockquote>"Stream Youtube"</blockquote> and Copy/Paste the video URL

Close currently played video : 
Click on <blockquote>"Kill"</blockquote>

Stream any Youtube-dl supported website : 
Click on <blockquote>"Stream non-youtube"</blockquote> and Copy/Paste the video URL.

<b> Tip : </b>
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

Create a function that is called when your button sent the user input, and put it next to the others
<pre><code>socket.on\('url', function\(url_read\) \{
      	socket\.url = url\_read;
	exec\("omxplayer  \-o hdmi $\(youtube\-dl \-g \-f mp4 '" \+ socket\.url \+ "') &"\);
	\}\);</pre></code>
	
# About
 
I had a Pi, I had a TV, I had a PC. And I was too lazy too get up and plug my pc to the TV through HDMI.
So I plugged the Pi to the TV, and started looking for a screen casting software.

I stumbled upon <a href="https://github.com/lanceseidman/PiCAST">Lance Seidman's PiCast</a> but had issues with the install and its use of livestream. So I first customized a bit PiCast Code, and I finally ended doing major changes. However, the install script and the general conception is the same. So, props to him !

That's how PYCASTER is born.

<b> How does it works ?</b>
It relies upon Node JS to create a lightweight server on the PI. You connect to the Pi, the server-side JavaScripts delivers a simple webpage (index.html). The communication is done in real time thanks to the socket.io library.
Your browser connects to the Pi, you send the URL you want to stream, and the Pi streams it for you through omxplayer and youtube-dl.
