import os
from io import BytesIO
from os import path
import json
import PIL
from PIL import Image
import copy
import sys
import uuid
import boto3
import urllib.parse
from env import DEST_BUCKET
from env import SRC_BUCKET


s3 = boto3.resource('s3')
s3_client = boto3.client('s3')


def lambda_handler(event, context):
    for key in event.get('Records'):
        object_key = key['s3']['object']['key']
        extension = path.splitext(object_key)[1].lower()

        obj = s3.Object(
            bucket_name=SRC_BUCKET,
            key=object_key,
        )
        obj_body = obj.get()['Body'].read()

        if extension in ['.jpeg', '.jpg', '.png']:
            format = 'JPEG'

        print('starting Image metadata stripping for {}/{}'.format(
            SRC_BUCKET,
            object_key,
        ))

        image = Image.open(BytesIO(obj_body))
        data = list(image.getdata())
        image_without_exif = Image.new(image.mode, image.size)
        image_without_exif.putdata(data)
        buffer = BytesIO()
        image_without_exif.save(buffer, format)
        buffer.seek(0) 

        obj = s3.Object(
            bucket_name=DEST_BUCKET,
            key=f"{object_key}",
        )
        obj.put(Body=buffer)

        print('File saved at {}/{}'.format(
            DEST_BUCKET,
            object_key,
        ))
        print("Image metdata stripping lambda handler completed.") 








