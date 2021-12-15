from flask import Flask, request
#import requests
import json

app = Flask(__name__)

def notification_handler(msg):
    js = json.loads(msg)
    print(js)

@app.route('/', methods = ['GET', 'POST', 'PUT'])
def sns():
    # AWS sends JSON with text/plain mimetype
    try:
        data = json.loads(request.data)
    except:
        pass

    header = request.headers.get('X-Amz-Sns-Message-Type')
    print(header)
    # # subscribe to the SNS topic
    # if header == 'SubscriptionConfirmation' and 'SubscribeURL' in js:
    #     r = requests.get(js['SubscribeURL'])

    if header == 'Notification':
        notification_handler(data['Message'])

    return 'OK\n'

if __name__ == '__main__':
    app.run(
        host = "0.0.0.0",
        port = 5000,
        debug = False
    )