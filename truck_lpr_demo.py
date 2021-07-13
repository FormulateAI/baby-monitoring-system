import time
import base64
import requests
import cv2
import re
import json

def detect_license_plate(image):
    license_number = ""
    url = 'https://vision.googleapis.com/v1/images:annotate?key=AIzaSyDDotUJaMWtaKJrvbVC_s-sE-DTbnR065A'
    res = ''
    image = cv2.imencode('.jpg', image)[1].tostring()
    img_base64 = base64.b64encode(image)
    ig = str(img_base64)
    ik=ig.replace('b\'','')
    headers={'content-type': 'application/json'}
    
    data ="""{
      "requests": [
        {
          "image": {
                   "content": '"""+ik[:-1]+"""'
                
                    },
          
          "features": [
            {
              "type": "TEXT_DETECTION"
            }
          ]
        }
      ]
    }"""
    r = requests.post(url, headers=headers,data=data)
    result = json.loads(r.text)
    try:
        result = result['responses'][0]['textAnnotations'][0]['description']
    except:
        return(res)
    result = result.replace('\n', '')
    result = re.sub('\W+','', result)
    mystates = ['AP','AR','AS','BR','CG','GA','GJ','HR' ,'HP' ,'JK','JH','KA','KL','MP','MH','MN','ML','MZ','NL' ,'OD','PB' ,'RJ','SK','TN','TS','TR','UA','UK','UP','WB','AN','CH','DN','DD','DL' ,'LD','PY']
    
    if(len(result) > 0):
        for word in mystates:
            if(word in result):
                res = re.findall(word + "[0-9]{1,2}\s*[A-Z]{1,4}\s*[0-9]{1,4}\s*]?", result)
                if(len(res) >0):
                    res = res
                    break
    if(len(res) > 0):
        license_number = res[0]
    else:
        license_number = ''
    return(license_number)