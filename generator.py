#!env python

import argparse
import base64

parser = argparse.ArgumentParser(description='generates a docker config.json file or it\'s base64 encoded version')

parser.add_argument('-r', '--registry', dest='registry', default='index.docker.io', help='registry to use')
parser.add_argument('-u', '--username', dest='username', default='foo', help='username to use')
parser.add_argument('-p', '--password', dest='password', default='bar', help='password to use')
parser.add_argument('-e', '--email', dest='email', default='foo@example.com', help='e-mail to use')
parser.add_argument('-b', '--base64', dest='b64', default=False, action='store_true' , help='whether to encode auth string or not')

args = parser.parse_args()

# main
# print("registry: %s" % (args.registry))
# print("username: %s" % (args.username))
# print("password: %s" % (args.password))

auth = base64.b64encode(bytes("%s:%s" % (args.username, args.password), 'utf-8')).decode('utf-8')
secret = '{"auths":{"%s":{"username":"%s","password":"%s","email":"%s","auth":"%s"}}}' % (args.registry, args.username, args.password, args.email, auth)

if args.b64:
    print(base64.b64encode(bytes(secret, 'utf-8')).decode('utf-8'))
else:
    print(secret)
