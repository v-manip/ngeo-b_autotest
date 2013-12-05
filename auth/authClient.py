#!/usr/bin/env python

import httplib
from django.http import HttpResponse
from xml.etree import ElementTree
                                 
#-------------------------------------------------------------------------------
# AuthorizerClientMiddleware
#-------------------------------------------------------------------------------    
class AuthorizerClientMiddleware(object):  
        
    def process_request(self, request):  
    
          #Get user attributes from the request
          surname = request.META['surname'] 
          commonName = request.META['commonName']
          userId = request.META['uid']
          browseLayerId = request.GET.get("BrowseLayer", "empty")
          timePeriod = request.GET.get("Time", "empty")
          error = ['']

          authorizerServerInterface = AuthorizerServerInterface()
          
          authorized = authorizerServerInterface.isRequestAuthorized(userId, browseLayerId, timePeriod, error)
          if authorized:
            #OK - let the request through
            return None
          else:
            #NOK - deny request
            response = HttpResponse()  
            self.buildNotAuthorizedResponse(response, surname, commonName, userId, error)
            return response

    #-------------------------------------------------------------------------------
    # buildNotAuthorizedResponse
    #-------------------------------------------------------------------------------      
    def buildNotAuthorizedResponse(self, response, surname, commonName, userId, error):
      response.status_code = 401
      response.write("<b>%s</b> NOT AUTHORIZED" % (str(response.status_code)))
      response.write("<p>User %s %s (userId: %s) is not authorized to access this content.</p>" % (surname, commonName, userId))                
      response.write("<p>%s</p>" % (error[0]))                
      return response
    
    
#-------------------------------------------------------------------------------
# AuthorizerServerInterface
#-------------------------------------------------------------------------------    
class AuthorizerServerInterface(object):
    
    def isRequestAuthorized(self, userId, browseLayerId, timePeriod, error):
      
      #TODO: should be configurable from cfg file?
      authorizerServerBaseUrl = "localhost:8001"
    
      try:      
        #Set up connection to authorizer server   
        authServerConnection = httplib.HTTPConnection(authorizerServerBaseUrl)
  
        #Prepare the URL parameters
        url = "/ngEOWebServer/BrwsAuthorizationCheck?UserId=%s&BrowseLayerId=%s&TimePeriod=%s" % (userId, browseLayerId, timePeriod)
        
        #Send request
        authServerConnection.request("GET", url)
        resp = authServerConnection.getresponse()
        
        #Check the response status
        if resp.status != 200:
          raise Exception("server response: %d" % resp.status)
          
        #Parse the XML Response and get the elements that we are interested in     
        responseBody = resp.read()
        rootElem = ElementTree.XML(responseBody)    
   
        namespace = '{http://ngeo.eo.esa.int/schema/webserver}'
        responseCodeElem = rootElem.find("%sResponseCode" % namespace)     
        if responseCodeElem is None:
          raise Exception("element 'ResponseCode' not found in XML-Response of authorizer server")
          
        #Read the policy decision
        if responseCodeElem.text == "AUTHORIZED":
          authorized = True
        elif responseCodeElem.text == "NOT_AUTHORIZED":
          authorized = False
        else:
          raise Exception("element 'ResponseCode' does not contain a valid value.")
         
        exceptionElem = rootElem.find("%sExceptionElement" % namespace) 
        if exceptionElem is not None:
          error[0] = exceptionElem.text
        
      except Exception, e:
        authorized = False 
        error[0] = "Error while communication with authorizer server: %s" % str(e) 
                 
      return authorized
        
