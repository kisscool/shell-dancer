Shell-Dancer
============

Shell-Dancer is a (very) experimental web micro-framework written in Bourne Shell and whose goal is to remain entirely POSIX compatible.
The framework in itself is inspired by Ruby's [`Sinatra`](http://www.sinatrarb.com/) framework, with a special emphasys on adhering to the UNIX philosophy.


Why? Oh god, why?
-----------------

Short answer : because we can.

Long answer : This whole project began as a joke between friends, then it became an intellectual challenge and now it is more of a POC. Who knows what it will become next ?

Seriously, don't even consider using this for real. It would be mad.

How to use Shell-Dancer
-----------------------

### Installation

Just clone this repository :

	$ git clone http://github.com/kisscool/shell-dancer.git

### Dependencies

* A POSIX-compliant system
* That's all

### Example

	#!/bin/sh
	
	. /path/to/shell-dancer/dancer.sh
	
	get '/hi' <<!
	  echo "Hello world !"
	!

### Deployment

Deployment is possible on any platform which supports CGI.

#### Apache2/mod_cgi

Define a new virtualhost like this:

	<VirtualHost *:81>
		# The trailing slash after cgi.sh is important!
		ScriptAlias / /path/to/shell-dancer/cgi.sh/

		ServerName example.com
		ServerAdmin admin@example.com

		<Directory "/path/to/shell-dancer/">
			AllowOverride None
			Options None
			Order allow,deny
			Allow from all
		</Directory>
	</VirtualHost>

Restart apache, and you're all set.

List of functions
---------------

Todo


