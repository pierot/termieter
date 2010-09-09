#!/usr/bin/python

import BaseHTTPServer, SimpleHTTPServer

import os
import sys

def run(server_class=BaseHTTPServer.HTTPServer,
        handler_class=SimpleHTTPServer.SimpleHTTPRequestHandler):
    print 'Server version: ',handler_class.server_version

    port=8000

    if len(sys.argv)>1:
        if sys.argv[1].isdigit():
            port=int(sys.argv[1])
    server_address = ('', port)

    httpd = server_class(server_address, handler_class)

    myurl='http://localhost:'+str(server_address[1])+'/'
    print 'Your Server is running on: ',myurl
    print 'and serving files from: ',os.getcwd(),'.'
    print 'To stop the server, type ^C.'

    if 'b' in sys.argv:
        print 'Trying to start webbrowser...'
        import webbrowser
        webbrowser.open(myurl)

    httpd.serve_forever()

run()