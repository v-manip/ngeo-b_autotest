#!/usr/bin/env python

from wsgiref import simple_server
import cgi

#------------------------------------------------------------------------------
# RequestHandler
#------------------------------------------------------------------------------
def RequestHandler(env, response):

    print("\nIncoming request:")
    status = "200 OK"
    statusNOK = "500 Internal Server Error"
     
    authorizedMessage =   """<?xml version="1.0" encoding="UTF-8"?>
                             <ws:BrwsAuthorizationCheckResponse xsi:schemaLocation="http://ngeo.eo.esa.int/schema/webserver ngEO-EICD-WS.xsd" xmlns:ws="http://ngeo.eo.esa.int/schema/webserver" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                                <ws:ResponseCode>AUTHORIZED</ws:ResponseCode>
                             </ws:BrwsAuthorizationCheckResponse>"""

    deniedMessage =       """<?xml version="1.0" encoding="UTF-8"?>
                             <wsBrwsAuthorizationCheckResponse xsi:schemaLocation="http://ngeo.eo.esa.int/schema/webserver ngEO-EICD-WS.xsd" xmlns:ws="http://ngeo.eo.esa.int/schema/webserver" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                                <ws:ResponseCode>NOT_AUTHORIZED</ws:ResponseCode>
                             </wsBrwsAuthorizationCheckResponse>"""

    try:
      #get the query string parameters from the url
      queryParams = GetQueryParams(env)
  
      #check if the user is authorized to access the content based on the query parameters 
      authorized = MakePolicyDecision(queryParams)
      
      if authorized:
        print("  -> Request authorized\n")
        responseBody = authorizedMessage
      else:
        print("  -> Request denied\n")
        responseBody = deniedMessage
    except Exception, e:
      print("%s" % str(e))
      responseBody = deniedMessage
      status = statusNOK
    
    response(status, [('Content-type', 'text/xml')])
    
    return ["%s" % responseBody]
    

#------------------------------------------------------------------------------
# GetQueryParams
#------------------------------------------------------------------------------
def GetQueryParams(env):
  qs = env.get('QUERY_STRING')
  if qs:
     return dict((k, v)
            for k, v in cgi.parse_qsl(qs))
  else:
     return {}

#------------------------------------------------------------------------------
# MakePolicyDecision
#------------------------------------------------------------------------------
def MakePolicyDecision(queryParams):
    authorized = False
    
    browseLayerId = queryParams.get('BrowseLayerId', "")
    userId = queryParams.get('UserId', "")
    timePeriod = queryParams.get('TimePeriod', "")
    
    print("  UserId: [%s]" % userId)
    print("  BrowseLayerId: [%s]" % browseLayerId)
    print("  TimePeriod: [%s]" % timePeriod)
    
    #Test policy rule
    if (userId == "musterfrau") and \
       (browseLayerId == "SAR_L1_BROW"):
      authorized = True
    else:
      authorized = False
    
    return authorized


#------------------------------------------------------------------------------
# Main
#------------------------------------------------------------------------------       
# Set up the server and bind the request handler function    
port = 8001
server = simple_server.make_server('', port, RequestHandler)
print "Test authorizer server running on port %d... (Ctrl-C to exit)" % port

# Run the server until the process is killed
server.serve_forever()